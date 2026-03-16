import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/core/config/production_config.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';
import 'package:orderman_flutter/features/payment/data/nfc_payment_service.dart';
import 'package:orderman_flutter/features/payment/data/payment_service.dart';
import 'package:orderman_flutter/features/payment/data/paypal_payment_service.dart';
import 'package:orderman_flutter/features/payment/data/payment_repository.dart';
import 'package:orderman_flutter/features/payment/data/sumup_payment_service.dart';
import 'package:orderman_flutter/features/payment/data/tse_service.dart';
import 'package:orderman_flutter/features/payment/domain/bill_splitter.dart';
import 'package:orderman_flutter/features/printer/domain/printer_service.dart';
import 'package:orderman_flutter/features/printer/presentation/printer_providers.dart';

enum SplitMode {
  even,
  seat,
  selective,
}

enum PaymentMethod {
  cash,
  sumup,
  nfc,
  paypal,
  manualCard,
}

enum TseConnectionState {
  unknown,
  connected,
  error,
}

class PaymentStatusSummary {
  const PaymentStatusSummary({
    required this.label,
    required this.available,
    required this.message,
  });

  final String label;
  final bool available;
  final String message;
}

class PaymentSession {
  const PaymentSession({
    required this.tableNumber,
    required this.items,
  });

  final int tableNumber;
  final List<BillSplitItem> items;
}

class PaymentState {
  const PaymentState({
    required this.tableNumber,
    required this.items,
    required this.mode,
    required this.method,
    required this.guests,
    required this.selectedItemIds,
    required this.selectedPartIndex,
    required this.completedPartLabels,
    required this.result,
    this.isProcessing = false,
    this.statusMessage,
    this.lastTransactionReference,
    this.tseSignature,
    this.paymentStatuses = const <PaymentStatusSummary>[],
    this.trainingMode = ProductionConfig.trainingModeDefault,
    this.tseConnectionState = TseConnectionState.unknown,
    this.tseStatusMessage = 'TSE-Status wird geladen …',
    this.tseTransactionId,
  });

  final int tableNumber;
  final List<BillSplitItem> items;
  final SplitMode mode;
  final PaymentMethod method;
  final int guests;
  final Set<String> selectedItemIds;
  final int selectedPartIndex;
  final Set<String> completedPartLabels;
  final BillSplitResult result;
  final bool isProcessing;
  final String? statusMessage;
  final String? lastTransactionReference;
  final String? tseSignature;
  final List<PaymentStatusSummary> paymentStatuses;
  final bool trainingMode;
  final TseConnectionState tseConnectionState;
  final String tseStatusMessage;
  final String? tseTransactionId;

  double get completedTotal => result.parts
      .where((part) => completedPartLabels.contains(part.label))
      .fold(0, (sum, part) => sum + part.total);

  double get remainingTotal => total - completedTotal;

  int get completedCount => result.parts
      .where((part) => completedPartLabels.contains(part.label))
      .length;

  bool get canCompleteSelectedPart {
    if (result.parts.isEmpty || selectedPartIndex >= result.parts.length) {
      return false;
    }
    return !completedPartLabels
            .contains(result.parts[selectedPartIndex].label) &&
        !isProcessing;
  }

  bool get tseSigned => tseSignature != null && tseSignature!.isNotEmpty;

  bool get canFinalizePayment =>
      canCompleteSelectedPart &&
      tseConnectionState == TseConnectionState.connected &&
      !isProcessing;

  double get total => items.fold(0, (sum, item) => sum + item.total);

  PaymentState copyWith({
    SplitMode? mode,
    PaymentMethod? method,
    int? guests,
    Set<String>? selectedItemIds,
    int? selectedPartIndex,
    Set<String>? completedPartLabels,
    BillSplitResult? result,
    bool? isProcessing,
    String? statusMessage,
    bool clearStatusMessage = false,
    String? lastTransactionReference,
    bool clearTransactionReference = false,
    String? tseSignature,
    bool clearTseSignature = false,
    List<PaymentStatusSummary>? paymentStatuses,
    bool? trainingMode,
    TseConnectionState? tseConnectionState,
    String? tseStatusMessage,
    String? tseTransactionId,
    bool clearTseTransactionId = false,
  }) {
    return PaymentState(
      tableNumber: tableNumber,
      items: items,
      mode: mode ?? this.mode,
      method: method ?? this.method,
      guests: guests ?? this.guests,
      selectedItemIds: selectedItemIds ?? this.selectedItemIds,
      selectedPartIndex: selectedPartIndex ?? this.selectedPartIndex,
      completedPartLabels: completedPartLabels ?? this.completedPartLabels,
      result: result ?? this.result,
      isProcessing: isProcessing ?? this.isProcessing,
      statusMessage:
          clearStatusMessage ? null : (statusMessage ?? this.statusMessage),
      lastTransactionReference: clearTransactionReference
          ? null
          : (lastTransactionReference ?? this.lastTransactionReference),
      tseSignature:
          clearTseSignature ? null : (tseSignature ?? this.tseSignature),
      paymentStatuses: paymentStatuses ?? this.paymentStatuses,
      trainingMode: trainingMode ?? this.trainingMode,
      tseConnectionState: tseConnectionState ?? this.tseConnectionState,
      tseStatusMessage: tseStatusMessage ?? this.tseStatusMessage,
      tseTransactionId: clearTseTransactionId
          ? null
          : (tseTransactionId ?? this.tseTransactionId),
    );
  }
}

final billSplitterProvider = Provider<BillSplitter>((ref) {
  return const BillSplitter();
});

final sumupPaymentServiceProvider = Provider<PaymentService>((ref) {
  return SumUpPaymentService();
});

final nfcPaymentServiceProvider = Provider<PaymentService>((ref) {
  return NfcPaymentService();
});

final paypalPaymentServiceProvider = Provider<PaypalPaymentService>((ref) {
  return PaypalPaymentService();
});

final tseServiceProvider = Provider<TseService>((ref) {
  return TseService();
});

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  if (IsarService.instance.isReady) {
    return IsarPaymentRepository(IsarService.instance);
  }
  return InMemoryPaymentRepository();
});

final paymentControllerProvider =
    NotifierProvider.family<PaymentController, PaymentState, PaymentSession>(
  PaymentController.new,
);

class PaymentController extends FamilyNotifier<PaymentState, PaymentSession> {
  @override
  PaymentState build(PaymentSession arg) {
    final splitter = ref.read(billSplitterProvider);
    final total = arg.items.fold<double>(0, (sum, item) => sum + item.total);

    Future<void>.microtask(_restorePersistedPayment);
    Future<void>.microtask(_refreshStatuses);

    return PaymentState(
      tableNumber: arg.tableNumber,
      items: arg.items,
      mode: SplitMode.even,
      method: PaymentMethod.cash,
      guests: 2,
      selectedItemIds: const <String>{},
      selectedPartIndex: 0,
      completedPartLabels: const <String>{},
      result: splitter.splitEvenly(total: total, guests: 2),
      paymentStatuses: <PaymentStatusSummary>[
        PaymentStatusSummary(
          label: 'SumUp',
          available: ProductionConfig.hasSumUpConfig,
          message: ProductionConfig.hasSumUpConfig
              ? 'SumUp-Konfiguration vorhanden.'
              : 'SumUp nicht konfiguriert.',
        ),
        const PaymentStatusSummary(
          label: 'NFC',
          available: true,
          message: 'NFC-Verfügbarkeit wird beim Bezahlvorgang geprüft.',
        ),
        PaymentStatusSummary(
          label: 'PayPal',
          available: ProductionConfig.hasPaypalConfig,
          message: ProductionConfig.hasPaypalConfig
              ? 'PayPal-Konfiguration vorhanden.'
              : 'PayPal nicht konfiguriert.',
        ),
        PaymentStatusSummary(
          label: 'TSE',
          available: ProductionConfig.hasFiskaltrustConfig,
          message: ProductionConfig.hasFiskaltrustConfig
              ? 'TSE konfiguriert.'
              : 'fiskaltrust ist nicht konfiguriert.',
        ),
      ],
    );
  }

  Future<void> _refreshStatuses() async {
    try {
      final tseStatus = await ref.read(tseServiceProvider).checkStatus();
      final sumupAvailable =
          await ref.read(sumupPaymentServiceProvider).isAvailable();
      final nfcAvailable =
          await ref.read(nfcPaymentServiceProvider).isAvailable();
      final paypalAvailable =
          await ref.read(paypalPaymentServiceProvider).isAvailable();

      state = state.copyWith(
        paymentStatuses: <PaymentStatusSummary>[
          PaymentStatusSummary(
            label: 'SumUp',
            available: sumupAvailable,
            message: sumupAvailable
                ? 'SumUp-Konfiguration vorhanden.'
                : 'SumUp nicht konfiguriert.',
          ),
          PaymentStatusSummary(
            label: 'NFC',
            available: nfcAvailable,
            message: nfcAvailable ? 'NFC bereit.' : 'NFC nicht verfügbar.',
          ),
          PaymentStatusSummary(
            label: 'PayPal',
            available: paypalAvailable,
            message: paypalAvailable
                ? 'PayPal-Konfiguration vorhanden.'
                : 'PayPal nicht konfiguriert.',
          ),
          PaymentStatusSummary(
            label: 'TSE',
            available: tseStatus.isAvailable,
            message: tseStatus.message,
          ),
        ],
        tseConnectionState: tseStatus.isAvailable
            ? TseConnectionState.connected
            : TseConnectionState.error,
        tseStatusMessage: tseStatus.message,
      );
    } on StateError {
      // Ignore disposed provider containers in tests.
    }
  }

  Future<void> _restorePersistedPayment() async {
    final persisted = await ref
        .read(paymentRepositoryProvider)
        .loadLatestPaymentSession(arg.tableNumber);
    if (persisted == null) {
      return;
    }

    final currentResult = BillSplitResult(parts: persisted.parts);
    state = state.copyWith(
      mode: persisted.mode,
      method: persisted.method,
      completedPartLabels: persisted.completedPartLabels,
      result: currentResult,
    );
  }

  void selectMode(SplitMode mode) {
    state = state.copyWith(mode: mode);
    _recompute();
  }

  void selectMethod(PaymentMethod method) {
    state = state.copyWith(method: method);
  }

  void setTrainingMode(bool value) {
    state = state.copyWith(trainingMode: value);
  }

  void selectPart(int index) {
    if (index < 0 || index >= state.result.parts.length) {
      return;
    }
    state = state.copyWith(selectedPartIndex: index);
  }

  void setGuests(int guests) {
    state = state.copyWith(guests: guests.clamp(1, 12).toInt());
    _recompute();
  }

  void toggleSelectiveItem(String itemId) {
    final next = {...state.selectedItemIds};
    if (!next.add(itemId)) {
      next.remove(itemId);
    }
    state = state.copyWith(selectedItemIds: next);
    _recompute();
  }

  void _recompute() {
    final splitter = ref.read(billSplitterProvider);

    switch (state.mode) {
      case SplitMode.even:
        state = state.copyWith(
          selectedPartIndex: 0,
          completedPartLabels: const <String>{},
          result:
              splitter.splitEvenly(total: state.total, guests: state.guests),
        );
        break;
      case SplitMode.seat:
        state = state.copyWith(
          selectedPartIndex: 0,
          completedPartLabels: const <String>{},
          result: splitter.splitBySeat(state.items),
        );
        break;
      case SplitMode.selective:
        state = state.copyWith(
          selectedPartIndex: 0,
          completedPartLabels: const <String>{},
          result: splitter.splitSelective(
            items: state.items,
            selectedItemIds: state.selectedItemIds,
          ),
        );
        break;
    }
  }

  Future<String> completePayment({required BrandingConfig branding}) async {
    final part = state.result.parts.isEmpty
        ? null
        : state.result.parts[state.selectedPartIndex];
    final target = part == null ? 'Zahlung' : part.label;
    if (part != null && state.completedPartLabels.contains(part.label)) {
      return '$target wurde bereits bezahlt';
    }

    if (state.tseConnectionState == TseConnectionState.unknown) {
      await _refreshStatuses();
    }

    if (state.tseConnectionState != TseConnectionState.connected) {
      return 'Zahlungsabschluss blockiert: ${state.tseStatusMessage}';
    }

    state = state.copyWith(
      isProcessing: true,
      clearStatusMessage: true,
      clearTransactionReference: true,
      clearTseSignature: true,
      clearTseTransactionId: true,
    );

    final executionResult =
        await _executeSelectedPayment(part: part, target: target);
    if (!executionResult.isSuccess) {
      state = state.copyWith(
        isProcessing: false,
        statusMessage: executionResult.message,
      );
      return executionResult.message;
    }

    if (part != null) {
      state = state.copyWith(
        completedPartLabels: {...state.completedPartLabels, part.label},
      );
    }

    final tseResult = await ref.read(tseServiceProvider).signReceipt(
          tableNumber: state.tableNumber,
          amount: part?.total ?? state.total,
          paymentMethod: _methodLabel(state.method),
          receiptText: _buildReceiptSigningText(part: part, target: target),
        );

    if (!tseResult.success) {
      state = state.copyWith(
        isProcessing: false,
        tseConnectionState: TseConnectionState.error,
        tseStatusMessage: tseResult.message,
        statusMessage: '${executionResult.message} • ${tseResult.message}',
      );
      return 'Zahlung nicht abgeschlossen: ${tseResult.message}';
    }

    if (part != null) {
      state = state.copyWith(
        completedPartLabels: {...state.completedPartLabels, part.label},
      );
    }

    final receipt = GuestReceiptData(
      tableNumber: state.tableNumber,
      totalAmount: state.total,
      waiterName: 'POS',
      items: state.items
          .map(
            (item) => GuestReceiptItem(
              quantity: 1,
              name: item.name,
              unitPrice: item.total,
              totalPrice: item.total,
            ),
          )
          .toList(growable: false),
      restaurantName: branding.fallbackRestaurantName,
      brandLogoAsset: branding.logoAssetPng,
      paymentMethodLabel: _methodLabel(state.method),
      footerMessage: 'Vielen Dank für Ihren Besuch im ${branding.appName}.',
      tseSignatureText: tseResult.signature,
      tseTransactionId: tseResult.transactionId,
      exchangeRateInfo: 'Basiswährung EUR',
      orderDiscountLabel: 'Keine globalen Rabatte',
      trainingMode: state.trainingMode,
    );
    await ref.read(printerServiceProvider).printGuestReceipt(receipt);

    await ref.read(paymentRepositoryProvider).savePaymentSession(
          session: arg,
          state: state,
        );

    state = state.copyWith(
      isProcessing: false,
      lastTransactionReference: executionResult.reference,
      tseSignature: tseResult.signature,
tseTransactionId: tseResult.transactionId,
      tseConnectionState: TseConnectionState.connected,
      tseStatusMessage: tseResult.message,
      statusMessage: '${executionResult.message} • TSE signiert',
    );

    return '$target für Tisch ${state.tableNumber} via ${_methodLabel(state.method)} abgeschlossen';
  }

  Future<PaymentExecutionResult> _executeSelectedPayment({
    required BillSplitPart? part,
    required String target,
  }) async {
    final amount = part?.total ?? state.total;
    final request = PaymentExecutionRequest(
      tableNumber: state.tableNumber,
      amount: amount,
      currency: 'EUR',
      description: '$target Tisch ${state.tableNumber}',
      method: state.method,
      receiptItems: state.items
          .map(
            (item) => <String, dynamic>{
              'name': item.name,
              'quantity': 1,
              'price': item.total.toStringAsFixed(2),
              'currency': 'EUR',
            },
          )
          .toList(growable: false),
    );

    switch (state.method) {
      case PaymentMethod.cash:
        return PaymentExecutionResult(
          status: PaymentExecutionStatus.success,
          message: 'Barzahlung verbucht.',
          reference: 'cash-${DateTime.now().millisecondsSinceEpoch}',
        );
      case PaymentMethod.sumup:
        return ref.read(sumupPaymentServiceProvider).executePayment(request);
      case PaymentMethod.nfc:
        return ref.read(nfcPaymentServiceProvider).executePayment(request);
      case PaymentMethod.paypal:
        return const PaymentExecutionResult(
          status: PaymentExecutionStatus.failed,
          message: 'PayPal wird über den Checkout-Button gestartet.',
        );
      case PaymentMethod.manualCard:
        return PaymentExecutionResult(
          status: PaymentExecutionStatus.success,
          message:
              'Manuelle Kartenzahlung erfasst. Ingenico Move/3500 nur als Fallback vorgesehen.',
          reference: 'manual-${DateTime.now().millisecondsSinceEpoch}',
        );
    }
  }

  String _buildReceiptSigningText({
    required BillSplitPart? part,
    required String target,
  }) {
    return [
      'Table: ${state.tableNumber}',
      'Target: $target',
      'Method: ${_methodLabel(state.method)}',
      'Amount: ${(part?.total ?? state.total).toStringAsFixed(2)}',
    ].join(' | ');
  }

  String _methodLabel(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return 'Bar';
      case PaymentMethod.sumup:
        return 'SumUp';
      case PaymentMethod.nfc:
        return 'NFC';
      case PaymentMethod.paypal:
        return 'PayPal';
      case PaymentMethod.manualCard:
        return 'Manuelle Karte';
    }
  }
}
