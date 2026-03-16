import 'package:orderman_flutter/features/payment/presentation/payment_controller.dart';

enum PaymentExecutionStatus {
  success,
  cancelled,
  failed,
}

class PaymentExecutionResult {
  const PaymentExecutionResult({
    required this.status,
    required this.message,
    this.reference,
    this.metadata = const <String, dynamic>{},
  });

  final PaymentExecutionStatus status;
  final String message;
  final String? reference;
  final Map<String, dynamic> metadata;

  bool get isSuccess => status == PaymentExecutionStatus.success;
}

class PaymentExecutionRequest {
  const PaymentExecutionRequest({
    required this.tableNumber,
    required this.amount,
    required this.currency,
    required this.description,
    required this.method,
    required this.receiptItems,
    this.customerEmail,
  });

  final int tableNumber;
  final double amount;
  final String currency;
  final String description;
  final PaymentMethod method;
  final List<Map<String, dynamic>> receiptItems;
  final String? customerEmail;
}

abstract class PaymentService {
  Future<PaymentExecutionResult> executePayment(
      PaymentExecutionRequest request);
  Future<bool> isAvailable();
  String get displayName;
}
