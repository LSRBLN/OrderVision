import 'package:isar/isar.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';
import 'package:orderman_flutter/features/payment/data/payment_model.dart';
import 'package:orderman_flutter/features/payment/domain/bill_splitter.dart';
import 'package:orderman_flutter/features/payment/presentation/payment_controller.dart';

class StoredPaymentSession {
  const StoredPaymentSession({
    required this.tableNumber,
    required this.method,
    required this.mode,
    required this.totalAmount,
    required this.paidAmount,
    required this.completedPartLabels,
    required this.parts,
  });

  final int tableNumber;
  final PaymentMethod method;
  final SplitMode mode;
  final double totalAmount;
  final double paidAmount;
  final Set<String> completedPartLabels;
  final List<BillSplitPart> parts;
}

abstract class PaymentRepository {
  Future<void> savePaymentSession({
    required PaymentSession session,
    required PaymentState state,
  });

  Future<StoredPaymentSession?> loadLatestPaymentSession(int tableNumber);
}

class IsarPaymentRepository implements PaymentRepository {
  IsarPaymentRepository(this._isarService);

  final IsarService _isarService;

  @override
  Future<StoredPaymentSession?> loadLatestPaymentSession(
      int tableNumber) async {
    final db = _isarService.isar;
    final records = await db.paymentModels
        .filter()
        .tableNumberEqualTo(tableNumber)
        .findAll();
    records.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final payment = records.isEmpty ? null : records.first;
    if (payment == null) {
      return null;
    }

    await payment.parts.load();
    return StoredPaymentSession(
      tableNumber: payment.tableNumber,
      method: _mapMethod(payment.method),
      mode: _mapSplitMode(payment.splitMode),
      totalAmount: payment.totalAmount,
      paidAmount: payment.paidAmount,
      completedPartLabels: payment.parts
          .where((item) => item.isCompleted)
          .map((item) => item.label)
          .toSet(),
      parts: payment.parts
          .map(
            (item) => BillSplitPart(
              label: item.label,
              items: const <BillSplitItem>[],
              total: item.totalAmount,
            ),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<void> savePaymentSession({
    required PaymentSession session,
    required PaymentState state,
  }) async {
    final db = _isarService.isar;
    await db.writeTxn(() async {
      final payment = PaymentModel()
        ..tableNumber = session.tableNumber
        ..createdAt = DateTime.now()
        ..method = _storedMethod(state.method)
        ..splitMode = _storedSplitMode(state.mode)
        ..totalAmount = state.total
        ..paidAmount = state.completedTotal
        ..isCompleted = state.remainingTotal <= 0;

      final parts = state.result.parts
          .map(
            (part) => PaymentPartModel()
              ..label = part.label
              ..totalAmount = part.total
              ..isCompleted = state.completedPartLabels.contains(part.label),
          )
          .toList(growable: false);

      await db.paymentPartModels.putAll(parts);
      payment.parts.addAll(parts);
      await db.paymentModels.put(payment);
      await payment.parts.save();
    });
  }

  PaymentMethod _mapMethod(StoredPaymentMethod method) {
    switch (method) {
      case StoredPaymentMethod.cash:
        return PaymentMethod.cash;
      case StoredPaymentMethod.sumup:
        return PaymentMethod.sumup;
      case StoredPaymentMethod.nfc:
        return PaymentMethod.nfc;
      case StoredPaymentMethod.paypal:
        return PaymentMethod.paypal;
      case StoredPaymentMethod.manualCard:
        return PaymentMethod.manualCard;
    }
  }

  SplitMode _mapSplitMode(StoredSplitMode mode) {
    switch (mode) {
      case StoredSplitMode.even:
        return SplitMode.even;
      case StoredSplitMode.seat:
        return SplitMode.seat;
      case StoredSplitMode.selective:
        return SplitMode.selective;
    }
  }

  StoredPaymentMethod _storedMethod(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return StoredPaymentMethod.cash;
      case PaymentMethod.sumup:
        return StoredPaymentMethod.sumup;
      case PaymentMethod.nfc:
        return StoredPaymentMethod.nfc;
      case PaymentMethod.paypal:
        return StoredPaymentMethod.paypal;
      case PaymentMethod.manualCard:
        return StoredPaymentMethod.manualCard;
    }
  }

  StoredSplitMode _storedSplitMode(SplitMode mode) {
    switch (mode) {
      case SplitMode.even:
        return StoredSplitMode.even;
      case SplitMode.seat:
        return StoredSplitMode.seat;
      case SplitMode.selective:
        return StoredSplitMode.selective;
    }
  }
}

class InMemoryPaymentRepository implements PaymentRepository {
  final Map<int, StoredPaymentSession> _sessions =
      <int, StoredPaymentSession>{};

  @override
  Future<StoredPaymentSession?> loadLatestPaymentSession(
      int tableNumber) async {
    return _sessions[tableNumber];
  }

  @override
  Future<void> savePaymentSession({
    required PaymentSession session,
    required PaymentState state,
  }) async {
    _sessions[session.tableNumber] = StoredPaymentSession(
      tableNumber: session.tableNumber,
      method: state.method,
      mode: state.mode,
      totalAmount: state.total,
      paidAmount: state.completedTotal,
      completedPartLabels: state.completedPartLabels,
      parts: state.result.parts,
    );
  }
}
