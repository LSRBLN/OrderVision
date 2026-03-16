import 'package:orderman_flutter/core/config/production_config.dart';
import 'package:orderman_flutter/core/logging/app_logger.dart';
import 'package:orderman_flutter/features/payment/data/payment_service.dart';
import 'package:sumup/sumup.dart';

class SumUpPaymentService implements PaymentService {
  bool _initialized = false;

  @override
  String get displayName => 'SumUp';

  Future<void> _ensureInitialized() async {
    if (_initialized) {
      return;
    }
    if (!ProductionConfig.hasSumUpConfig) {
      throw StateError('SUMUP_AFFILIATE_KEY fehlt.');
    }
    await Sumup.init(ProductionConfig.sumUpAffiliateKey);
    _initialized = true;
  }

  @override
  Future<PaymentExecutionResult> executePayment(
    PaymentExecutionRequest request,
  ) async {
    try {
      await _ensureInitialized();
      if (!(await Sumup.isLoggedIn ?? false)) {
        await Sumup.login();
      }
      await Sumup.prepareForCheckout();

      final payment = SumupPayment(
        title: request.description,
        total: request.amount,
        currency: request.currency,
        foreignTransactionId:
            'table-${request.tableNumber}-${DateTime.now().millisecondsSinceEpoch}',
        saleItemsCount: request.receiptItems.length,
        customerEmail: request.customerEmail,
        skipSuccessScreen: true,
      );
      final response = await Sumup.checkout(SumupPaymentRequest(payment));
      if (response.success != true) {
        return const PaymentExecutionResult(
          status: PaymentExecutionStatus.failed,
          message: 'SumUp-Zahlung fehlgeschlagen.',
        );
      }

      return PaymentExecutionResult(
        status: PaymentExecutionStatus.success,
        message: 'SumUp-Zahlung erfolgreich.',
        reference: response.transactionCode,
        metadata: <String, dynamic>{
          'cardType': response.cardType,
          'cardLastDigits': response.cardLastDigits,
          'paymentType': response.paymentType,
        },
      );
    } catch (error, stackTrace) {
      AppLogger.instance
          .e('SumUp payment failed', error: error, stackTrace: stackTrace);
      return PaymentExecutionResult(
        status: PaymentExecutionStatus.failed,
        message: 'SumUp-Fehler: $error',
      );
    }
  }

  @override
  Future<bool> isAvailable() async => ProductionConfig.hasSumUpConfig;
}
