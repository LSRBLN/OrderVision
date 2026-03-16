import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:orderman_flutter/core/config/production_config.dart';
import 'package:orderman_flutter/core/logging/app_logger.dart';

class TseStatus {
  const TseStatus({
    required this.isAvailable,
    required this.message,
  });

  final bool isAvailable;
  final String message;
}

class TseSignatureResult {
  const TseSignatureResult({
    required this.success,
    required this.signature,
    required this.message,
    this.transactionId = '',
  });

  final bool success;
  final String signature;
  final String message;
  final String transactionId;
}

class TseService {
  TseService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<TseStatus> checkStatus() async {
    if (!ProductionConfig.hasFiskaltrustConfig) {
      return const TseStatus(
        isAvailable: false,
        message: 'fiskaltrust ist noch nicht konfiguriert.',
      );
    }

    try {
      final response = await _client.get(
        Uri.parse('${ProductionConfig.fiskaltrustBaseUrl}/health'),
        headers: <String, String>{
          'x-api-key': ProductionConfig.fiskaltrustApiKey,
        },
      );
      return TseStatus(
        isAvailable: response.statusCode >= 200 && response.statusCode < 300,
        message: response.statusCode >= 200 && response.statusCode < 300
            ? 'TSE bereit.'
            : 'TSE antwortet mit Status ${response.statusCode}.',
      );
    } catch (error, stackTrace) {
      AppLogger.instance
          .e('TSE status failed', error: error, stackTrace: stackTrace);
      return TseStatus(isAvailable: false, message: 'TSE-Fehler: $error');
    }
  }

  Future<TseSignatureResult> signReceipt({
    required int tableNumber,
    required double amount,
    required String paymentMethod,
    required String receiptText,
  }) async {
    if (!ProductionConfig.hasFiskaltrustConfig) {
      return const TseSignatureResult(
        success: false,
        signature: '',
        message: 'fiskaltrust ist nicht konfiguriert.',
      );
    }

    try {
      final response = await _client.post(
        Uri.parse('${ProductionConfig.fiskaltrustBaseUrl}/sign'),
        headers: <String, String>{
          'content-type': 'application/json',
          'x-api-key': ProductionConfig.fiskaltrustApiKey,
          'x-cashbox-id': ProductionConfig.fiskaltrustCashboxId,
        },
        body: jsonEncode(<String, dynamic>{
          'tableNumber': tableNumber,
          'amount': amount,
          'paymentMethod': paymentMethod,
          'receiptText': receiptText,
        }),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return TseSignatureResult(
          success: false,
          signature: '',
          message: 'TSE-Signatur fehlgeschlagen (${response.statusCode}).',
        );
      }

      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      return TseSignatureResult(
        success: true,
        signature: payload['signature']?.toString() ?? '',
        transactionId: payload['transactionId']?.toString() ??
            payload['receiptId']?.toString() ??
            '',
        message: 'TSE-Signatur erfolgreich.',
      );
    } catch (error, stackTrace) {
      AppLogger.instance
          .e('TSE sign failed', error: error, stackTrace: stackTrace);
      return TseSignatureResult(
        success: false,
        signature: '',
        message: 'TSE-Fehler: $error',
      );
    }
  }
}
