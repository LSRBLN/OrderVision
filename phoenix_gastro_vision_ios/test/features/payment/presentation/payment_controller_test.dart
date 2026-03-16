import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orderman_flutter/features/payment/data/payment_service.dart';
import 'package:orderman_flutter/features/payment/data/paypal_payment_service.dart';
import 'package:orderman_flutter/features/payment/data/tse_service.dart';
import 'package:orderman_flutter/features/payment/domain/bill_splitter.dart';
import 'package:orderman_flutter/features/payment/presentation/payment_controller.dart';
import 'package:orderman_flutter/features/printer/domain/printer_service.dart';
import 'package:orderman_flutter/features/printer/presentation/printer_providers.dart';

class _FakePaymentService implements PaymentService {
  _FakePaymentService(this._result, this._name);

  final PaymentExecutionResult _result;
  final String _name;

  @override
  String get displayName => _name;

  @override
  Future<PaymentExecutionResult> executePayment(
      PaymentExecutionRequest request) async {
    return _result;
  }

  @override
  Future<bool> isAvailable() async => true;
}

class _FakeTseService extends TseService {
  _FakeTseService(this._result);

  final TseSignatureResult _result;

  @override
  Future<TseStatus> checkStatus() async {
    return const TseStatus(isAvailable: true, message: 'OK');
  }

  @override
  Future<TseSignatureResult> signReceipt({
    required int tableNumber,
    required double amount,
    required String paymentMethod,
    required String receiptText,
  }) async {
    return _result;
  }
}

void main() {
  group('PaymentController', () {
    const session = PaymentSession(
      tableNumber: 12,
      items: [
        BillSplitItem(id: 'a', name: 'Cola', total: 3.0, seatNumber: 1),
        BillSplitItem(id: 'b', name: 'Burger', total: 13.9, seatNumber: 2),
        BillSplitItem(id: 'c', name: 'Kaffee', total: 2.8, seatNumber: 2),
      ],
    );

    test('initial state starts in even mode with 2 guests', () {
      final container = ProviderContainer(
        overrides: _productionOverrides(),
      );
      addTearDown(container.dispose);

      final state = container.read(paymentControllerProvider(session));

      expect(state.mode, SplitMode.even);
      expect(state.guests, 2);
      expect(state.result.parts, hasLength(2));
    });

    test('changing guest count recomputes even split', () {
      final container = ProviderContainer(
        overrides: _productionOverrides(),
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(paymentControllerProvider(session).notifier);
      notifier.setGuests(3);

      final state = container.read(paymentControllerProvider(session));
      expect(state.guests, 3);
      expect(state.result.parts, hasLength(3));
    });

    test('seat mode groups items by seat', () {
      final container = ProviderContainer(
        overrides: _productionOverrides(),
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(paymentControllerProvider(session).notifier);
      notifier.selectMode(SplitMode.seat);

      final state = container.read(paymentControllerProvider(session));
      expect(state.mode, SplitMode.seat);
      expect(state.result.parts.map((part) => part.label), [
        'Sitzplatz 1',
        'Sitzplatz 2',
      ]);
    });

    test('selective mode tracks selected item ids', () {
      final container = ProviderContainer(
        overrides: _productionOverrides(),
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(paymentControllerProvider(session).notifier);
      notifier.selectMode(SplitMode.selective);
      notifier.toggleSelectiveItem('a');
      notifier.toggleSelectiveItem('c');

      final state = container.read(paymentControllerProvider(session));
      expect(state.selectedItemIds, {'a', 'c'});
      expect(state.result.parts.first.total, 5.8);
      expect(state.result.parts.last.total, 13.9);
    });

    test(
        'payment method can be switched and completion message reflects method',
        () async {
      final fakePrinter = InMemoryPrinterService();
      final fakeSumup = _FakePaymentService(
        const PaymentExecutionResult(
          status: PaymentExecutionStatus.success,
          message: 'SumUp-Zahlung erfolgreich.',
          reference: 'sumup-ref',
        ),
        'SumUp',
      );
      final fakeTse = _FakeTseService(
        const TseSignatureResult(
          success: true,
          signature: 'TSE-123',
          message: 'OK',
        ),
      );
      final container = ProviderContainer(
        overrides: [
          ..._productionOverrides(),
          printerServiceProvider.overrideWithValue(fakePrinter),
          sumupPaymentServiceProvider.overrideWithValue(fakeSumup),
          tseServiceProvider.overrideWithValue(fakeTse),
        ],
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(paymentControllerProvider(session).notifier);

      notifier.selectMethod(PaymentMethod.sumup);

      final state = container.read(paymentControllerProvider(session));
      expect(state.method, PaymentMethod.sumup);
      expect(
        await notifier.completePayment(),
        'Gast 1 für Tisch 12 via SumUp abgeschlossen',
      );
    });

    test('selected split part changes completion target', () async {
      final container = ProviderContainer(
        overrides: [
          ..._productionOverrides(),
          printerServiceProvider.overrideWithValue(InMemoryPrinterService()),
          tseServiceProvider.overrideWithValue(
            _FakeTseService(
              const TseSignatureResult(
                success: true,
                signature: 'sig',
                message: 'OK',
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(paymentControllerProvider(session).notifier);

      notifier.selectPart(1);

      final state = container.read(paymentControllerProvider(session));
      expect(state.selectedPartIndex, 1);
      expect(
        await notifier.completePayment(),
        'Gast 2 für Tisch 12 via Bar abgeschlossen',
      );
    });

    test('completed split part is tracked and cannot be completed twice',
        () async {
      final container = ProviderContainer(
        overrides: [
          ..._productionOverrides(),
          printerServiceProvider.overrideWithValue(InMemoryPrinterService()),
          tseServiceProvider.overrideWithValue(
            _FakeTseService(
              const TseSignatureResult(
                success: true,
                signature: 'sig',
                message: 'OK',
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(paymentControllerProvider(session).notifier);

      final firstResult = await notifier.completePayment();
      final stateAfterFirst =
          container.read(paymentControllerProvider(session));

      expect(firstResult, 'Gast 1 für Tisch 12 via Bar abgeschlossen');
      expect(stateAfterFirst.completedPartLabels, {'Gast 1'});
      expect(stateAfterFirst.canCompleteSelectedPart, isFalse);
      expect(stateAfterFirst.completedCount, 1);
      expect(stateAfterFirst.completedTotal, 9.85);
      expect(stateAfterFirst.remainingTotal, 9.85);

      final secondResult = await notifier.completePayment();
      expect(secondResult, 'Gast 1 wurde bereits bezahlt');
    });

    test('summary values update for second split part when selected', () async {
      final container = ProviderContainer(
        overrides: [
          ..._productionOverrides(),
          printerServiceProvider.overrideWithValue(InMemoryPrinterService()),
          tseServiceProvider.overrideWithValue(
            _FakeTseService(
              const TseSignatureResult(
                success: true,
                signature: 'sig',
                message: 'OK',
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier =
          container.read(paymentControllerProvider(session).notifier);

      notifier.selectPart(1);
      final result = await notifier.completePayment();
      final state = container.read(paymentControllerProvider(session));

      expect(result, 'Gast 2 für Tisch 12 via Bar abgeschlossen');
      expect(state.completedPartLabels, {'Gast 2'});
      expect(state.completedTotal, 9.85);
      expect(state.remainingTotal, 9.85);
    });
  });
}

List<Override> _productionOverrides() {
  return [
    sumupPaymentServiceProvider.overrideWithValue(
      _FakePaymentService(
        const PaymentExecutionResult(
          status: PaymentExecutionStatus.success,
          message: 'SumUp-Zahlung erfolgreich.',
          reference: 'sumup-ref',
        ),
        'SumUp',
      ),
    ),
    nfcPaymentServiceProvider.overrideWithValue(
      _FakePaymentService(
        const PaymentExecutionResult(
          status: PaymentExecutionStatus.success,
          message: 'NFC-Zahlung erfasst.',
          reference: 'nfc-ref',
        ),
        'NFC',
      ),
    ),
    paypalPaymentServiceProvider.overrideWithValue(PaypalPaymentService()),
    tseServiceProvider.overrideWithValue(
      _FakeTseService(
        const TseSignatureResult(
          success: true,
          signature: 'TSE-TEST',
          message: 'OK',
        ),
      ),
    ),
  ];
}
