import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:orderman_flutter/core/logging/app_logger.dart';
import 'package:orderman_flutter/features/payment/data/payment_service.dart';

class NfcPaymentService implements PaymentService {
  @override
  String get displayName => 'NFC / Tap-to-Pay';

  @override
  Future<PaymentExecutionResult> executePayment(
    PaymentExecutionRequest request,
  ) async {
    try {
      final availability = await FlutterNfcKit.nfcAvailability;
      if (availability != NFCAvailability.available) {
        return const PaymentExecutionResult(
          status: PaymentExecutionStatus.failed,
          message: 'NFC ist auf diesem Gerät nicht verfügbar.',
        );
      }
      final tag = await FlutterNfcKit.poll(
        timeout: const Duration(seconds: 20),
      );
      await FlutterNfcKit.finish();
      return PaymentExecutionResult(
        status: PaymentExecutionStatus.success,
        message: 'NFC-Zahlung erfasst.',
        reference: tag.id,
        metadata: <String, dynamic>{
          'tagType': tag.type,
          'standard': tag.standard,
        },
      );
    } catch (error, stackTrace) {
      AppLogger.instance
          .e('NFC payment failed', error: error, stackTrace: stackTrace);
      return PaymentExecutionResult(
        status: PaymentExecutionStatus.failed,
        message: 'NFC-Fehler: $error',
      );
    }
  }

  @override
  Future<bool> isAvailable() async {
    final availability = await FlutterNfcKit.nfcAvailability;
    return availability == NFCAvailability.available;
  }
}
