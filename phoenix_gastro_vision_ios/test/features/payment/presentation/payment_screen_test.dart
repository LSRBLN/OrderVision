import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orderman_flutter/features/payment/data/payment_service.dart';
import 'package:orderman_flutter/features/payment/data/paypal_payment_service.dart';
import 'package:orderman_flutter/features/payment/data/tse_service.dart';
import 'package:orderman_flutter/features/payment/domain/bill_splitter.dart';
import 'package:orderman_flutter/features/payment/presentation/payment_controller.dart';
import 'package:orderman_flutter/features/payment/presentation/payment_screen.dart';
import 'package:orderman_flutter/features/printer/domain/printer_service.dart';
import 'package:orderman_flutter/features/printer/presentation/printer_providers.dart';

class _FakePaymentService implements PaymentService {
  const _FakePaymentService(this._result, this._name);

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
  testWidgets('PaymentScreen renders split controls and preview',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1600, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    const session = PaymentSession(
      tableNumber: 7,
      items: [
        BillSplitItem(id: 'a', name: 'Cola', total: 3.0, seatNumber: 1),
        BillSplitItem(id: 'b', name: 'Pasta', total: 12.4, seatNumber: 2),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: _testOverrides(),
        child: const MaterialApp(
          home: PaymentScreen(session: session),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Phoenix Gastro Vision • Tisch 7'), findsOneWidget);
    expect(find.text('Split & Zahlungsfluss'), findsOneWidget);
    expect(find.text('Split-Vorschau'), findsOneWidget);
    expect(find.text('Gleichmäßig'), findsOneWidget);
    expect(find.text('Sitzplatz'), findsOneWidget);
    expect(find.text('Selektiv'), findsOneWidget);
    expect(find.text('Bar'), findsOneWidget);
    expect(find.text('SumUp'), findsOneWidget);
    expect(find.text('NFC'), findsOneWidget);
    expect(find.text('PayPal'), findsOneWidget);
    expect(find.text('Zahlung final abschließen'), findsOneWidget);
    expect(find.text('Gast 1'), findsOneWidget);
    expect(find.text('Gast 2'), findsOneWidget);
  });

  testWidgets(
      'PaymentScreen can complete a split part and disables repeat payment',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1600, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    const session = PaymentSession(
      tableNumber: 7,
      items: [
        BillSplitItem(id: 'a', name: 'Cola', total: 3.0, seatNumber: 1),
        BillSplitItem(id: 'b', name: 'Pasta', total: 12.4, seatNumber: 2),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: _testOverrides(),
        child: const MaterialApp(
          home: PaymentScreen(session: session),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text('Gast 2'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Zahlung final abschließen'));
    await tester.pumpAndSettle();

    expect(
        find.text('Gast 2 für Tisch 7 via Bar abgeschlossen'), findsOneWidget);
    expect(find.text('Bereits bezahlt'), findsOneWidget);
    expect(find.textContaining('Offen 7.70 €'), findsOneWidget);
  });
}

List<Override> _testOverrides() {
  return [
    sumupPaymentServiceProvider.overrideWithValue(
      const _FakePaymentService(
        PaymentExecutionResult(
          status: PaymentExecutionStatus.success,
          message: 'SumUp-Zahlung erfolgreich.',
          reference: 'sumup-ref',
        ),
        'SumUp',
      ),
    ),
    nfcPaymentServiceProvider.overrideWithValue(
      const _FakePaymentService(
        PaymentExecutionResult(
          status: PaymentExecutionStatus.success,
          message: 'NFC-Zahlung erfolgreich.',
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
    printerServiceProvider.overrideWithValue(InMemoryPrinterService()),
  ];
}
