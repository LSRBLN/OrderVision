import 'package:orderman_flutter/core/config/production_config.dart';
import 'package:orderman_flutter/features/payment/data/payment_service.dart';

class PaypalPaymentService implements PaymentService {
  @override
  String get displayName => 'PayPal';

  @override
  Future<PaymentExecutionResult> executePayment(
    PaymentExecutionRequest request,
  ) async {
    return const PaymentExecutionResult(
      status: PaymentExecutionStatus.failed,
      message:
          'PayPal wird über den Checkout-Screen gestartet und nicht direkt im Service ausgeführt.',
    );
  }

  List<Map<String, dynamic>> buildTransactions(
      PaymentExecutionRequest request) {
    return <Map<String, dynamic>>[
      <String, dynamic>{
        'amount': <String, dynamic>{
          'total': request.amount.toStringAsFixed(2),
          'currency': request.currency,
          'details': <String, dynamic>{
            'subtotal': request.amount.toStringAsFixed(2),
            'shipping': '0',
            'shipping_discount': 0,
          },
        },
        'description': request.description,
        'item_list': <String, dynamic>{
          'items': request.receiptItems,
        },
      },
    ];
  }

  @override
  Future<bool> isAvailable() async => ProductionConfig.hasPaypalConfig;
}
