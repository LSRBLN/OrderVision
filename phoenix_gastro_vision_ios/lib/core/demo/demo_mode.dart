import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/features/payment/data/nfc_payment_service.dart';
import 'package:orderman_flutter/features/payment/data/payment_service.dart';
import 'package:orderman_flutter/features/payment/data/paypal_payment_service.dart';
import 'package:orderman_flutter/features/payment/data/tse_service.dart';
import 'package:orderman_flutter/features/printer/domain/printer_service.dart';

final demoModeProvider = Provider<DemoModeConfig>((ref) {
  return const DemoModeConfig.enabled();
});

class DemoModeConfig {
  const DemoModeConfig({
    required this.enabled,
    required this.bannerTitle,
    required this.bannerSubtitle,
    required this.venueName,
    required this.operatorName,
    required this.sumUpTerminalLabel,
    required this.paypalMerchantLabel,
    required this.nfcReaderLabel,
    required this.tseEnvironmentLabel,
    required this.cashboxId,
  });

  const DemoModeConfig.enabled()
      : enabled = true,
        bannerTitle = 'DEMO MODE – Sandbox Active',
        bannerSubtitle =
            'Phoenix payment, printer and fiscal flows run on a safe in-app sandbox.',
        venueName = 'Phoenix Demo Lounge Berlin',
        operatorName = 'Lea Hoffmann',
        sumUpTerminalLabel = 'SumUp Solo • DEMO-SBX-17',
        paypalMerchantLabel = 'sandbox.merchant@phoenix-gastro-vision.demo',
        nfcReaderLabel = 'NFC SoftPOS • iPad Sandbox',
        tseEnvironmentLabel = 'fiskaltrust Middleware Sandbox',
        cashboxId = 'FT-CB-DEMO-2026-001';

  final bool enabled;
  final String bannerTitle;
  final String bannerSubtitle;
  final String venueName;
  final String operatorName;
  final String sumUpTerminalLabel;
  final String paypalMerchantLabel;
  final String nfcReaderLabel;
  final String tseEnvironmentLabel;
  final String cashboxId;
}

class DemoBanner extends ConsumerWidget {
  const DemoBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(demoModeProvider);
    if (!config.enabled) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      bottom: false,
      child: IgnorePointer(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color:
                      colorScheme.surfaceContainerHigh.withValues(alpha: 0.96),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                      color: BrandingConfig.current.primaryColor
                          .withValues(alpha: 0.5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.16),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          BrandingConfig.current.logoAssetPng,
                          width: 46,
                          height: 46,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              config.bannerTitle,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              config.bannerSubtitle,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: BrandingConfig.current.primaryColor
                              .withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'SANDBOX',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.8,
                            color: BrandingConfig.current.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DemoPaymentNarrative {
  const DemoPaymentNarrative({
    required this.statusMessage,
    required this.reference,
    required this.metadata,
  });

  final String statusMessage;
  final String reference;
  final Map<String, dynamic> metadata;
}

class DemoSandboxFactory {
  const DemoSandboxFactory(this._config);

  final DemoModeConfig _config;

  DemoPaymentNarrative buildPaymentNarrative({
    required String channel,
    required PaymentExecutionRequest request,
  }) {
    final now = DateTime.now();
    final refPrefix =
        channel.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
    final compactDate = DateFormat('yyMMddHHmmss').format(now);
    final cents = (request.amount * 100).round().toString().padLeft(1, '0');
    final table = request.tableNumber.toString().padLeft(2, '0');
    final reference = '$refPrefix-$compactDate-T$table-$cents';

    switch (channel) {
      case 'SumUp':
        return DemoPaymentNarrative(
          statusMessage:
              'SumUp sandbox approved on ${_config.sumUpTerminalLabel}. Authorization reserved for ${request.amount.toStringAsFixed(2)} ${request.currency}.',
          reference: reference,
          metadata: <String, dynamic>{
            'provider': 'sumup-demo',
            'terminal': _config.sumUpTerminalLabel,
            'entryMode': 'chip_contactless',
            'approvalCode': compactDate.substring(compactDate.length - 6),
            'merchant': _config.venueName,
          },
        );
      case 'PayPal':
        return DemoPaymentNarrative(
          statusMessage:
              'PayPal sandbox checkout confirmed for merchant ${_config.paypalMerchantLabel}. Buyer authentication completed successfully.',
          reference: reference,
          metadata: <String, dynamic>{
            'provider': 'paypal-demo',
            'merchant': _config.paypalMerchantLabel,
            'payerStatus': 'VERIFIED',
            'captureStatus': 'COMPLETED',
            'intent': 'CAPTURE',
          },
        );
      case 'NFC':
        return DemoPaymentNarrative(
          statusMessage:
              'NFC sandbox token captured via ${_config.nfcReaderLabel}. Device-side card verification passed.',
          reference: reference,
          metadata: <String, dynamic>{
            'provider': 'nfc-demo',
            'reader': _config.nfcReaderLabel,
            'tokenizedPan': '5413 **** **** 2048',
            'verificationMethod': 'device_cvm',
            'scheme': 'Mastercard',
          },
        );
      default:
        return DemoPaymentNarrative(
          statusMessage:
              'Sandbox payment approved for ${request.amount.toStringAsFixed(2)} ${request.currency}.',
          reference: reference,
          metadata: <String, dynamic>{
            'provider': 'demo',
          },
        );
    }
  }

  TseStatus buildTseStatus() {
    return TseStatus(
      isAvailable: true,
      message:
          '${_config.tseEnvironmentLabel} connected • Cashbox ${_config.cashboxId}',
    );
  }

  TseSignatureResult buildTseSignature({
    required int tableNumber,
    required double amount,
    required String paymentMethod,
  }) {
    final now = DateTime.now().toUtc();
    final txDate = DateFormat('yyyyMMddHHmmss').format(now);
    final transactionId =
        'TSE-$txDate-T${tableNumber.toString().padLeft(2, '0')}';
    final amountPart = amount.toStringAsFixed(2).replaceAll('.', '');
    final methodToken = paymentMethod
        .toUpperCase()
        .replaceAll(' ', '')
        .padRight(6, 'X')
        .substring(0, 6);
    final random = Random(tableNumber + now.second);
    final tail = List<String>.generate(
        10, (_) => random.nextInt(16).toRadixString(16).toUpperCase()).join();
    final signature = 'FT/$methodToken/$txDate/$amountPart/$tail';

    return TseSignatureResult(
      success: true,
      signature: signature,
      transactionId: transactionId,
      message:
          'Sandbox TSE signature recorded by ${_config.tseEnvironmentLabel}.',
    );
  }

  PrinterProfile kitchenPrinterProfile() {
    return const PrinterProfile(
      id: 'phoenix-demo-kitchen',
      name: 'Phoenix Demo Kitchen Printer',
      connectionType: PrinterConnectionType.network,
      ipAddress: '10.20.30.41',
      port: 9100,
      isDefault: true,
      isKitchenPrinter: true,
      logoUrl: 'assets/images/gastrovision.png',
    );
  }

  PrinterProfile receiptPrinterProfile() {
    return const PrinterProfile(
      id: 'phoenix-demo-receipt',
      name: 'Phoenix Demo Receipt Printer',
      connectionType: PrinterConnectionType.network,
      ipAddress: '10.20.30.42',
      port: 9100,
      isDefault: true,
      isReceiptPrinter: true,
      logoUrl: 'assets/images/gastrovision.png',
    );
  }

  List<PrinterDevice> discoverDemoPrinters() {
    return <PrinterDevice>[
      const PrinterDevice(
        id: 'phoenix-demo-kitchen-device',
        name: 'Phoenix Kitchen Pass • Sandbox',
        connectionType: PrinterConnectionType.network,
        ipAddress: '10.20.30.41',
        port: 9100,
        isConnected: true,
      ),
      const PrinterDevice(
        id: 'phoenix-demo-receipt-device',
        name: 'Phoenix Receipt Counter • Sandbox',
        connectionType: PrinterConnectionType.network,
        ipAddress: '10.20.30.42',
        port: 9100,
        isConnected: true,
      ),
    ];
  }

  KitchenTicketData enrichKitchenTicket(KitchenTicketData data) {
    return KitchenTicketData(
      tableNumber: data.tableNumber,
      items: data.items,
      waiterName: data.waiterName ?? _config.operatorName,
      brandLogoAsset: BrandingConfig.current.logoAssetPng,
      paymentMethodLabel: data.paymentMethodLabel ?? 'Demo Workflow',
      tseSignatureText:
          data.tseSignatureText ?? 'Sandbox fiscal imprint pending at payment',
      exchangeRateInfo: data.exchangeRateInfo ??
          'Settlement currency EUR • Demo sandbox routing',
      discountSummary: data.discountSummary,
      voidSummary: data.voidSummary,
      trainingMode: true,
    );
  }

  GuestReceiptData enrichGuestReceipt(GuestReceiptData data) {
    return GuestReceiptData(
      tableNumber: data.tableNumber,
      items: data.items,
      totalAmount: data.totalAmount,
      waiterName: data.waiterName ?? _config.operatorName,
      tipAmount: data.tipAmount,
      restaurantName: _config.venueName,
      qrData: data.qrData ??
          'https://sandbox.phoenix-gastro-vision.demo/receipt/${data.tableNumber}',
      footerMessage: 'Phoenix Demo Environment • No real payment was captured.',
      orderDiscountLabel: data.orderDiscountLabel,
      brandLogoAsset: BrandingConfig.current.logoAssetPng,
      paymentMethodLabel: data.paymentMethodLabel,
      tseSignatureText: data.tseSignatureText,
      tseTransactionId: data.tseTransactionId,
      exchangeRateInfo: data.exchangeRateInfo ??
          'Settlement currency EUR • Demo sandbox routing',
      voidSummary: data.voidSummary,
      trainingMode: true,
    );
  }
}

final demoSandboxFactoryProvider = Provider<DemoSandboxFactory>((ref) {
  return DemoSandboxFactory(ref.watch(demoModeProvider));
});

class DemoSumUpPaymentService implements PaymentService {
  DemoSumUpPaymentService(this._factory);

  final DemoSandboxFactory _factory;

  @override
  String get displayName => 'SumUp';

  @override
  Future<PaymentExecutionResult> executePayment(
      PaymentExecutionRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
    final narrative =
        _factory.buildPaymentNarrative(channel: 'SumUp', request: request);
    return PaymentExecutionResult(
      status: PaymentExecutionStatus.success,
      message: narrative.statusMessage,
      reference: narrative.reference,
      metadata: narrative.metadata,
    );
  }

  @override
  Future<bool> isAvailable() async => true;
}

class DemoPaypalPaymentService extends PaypalPaymentService {
  DemoPaypalPaymentService(this._factory);

  final DemoSandboxFactory _factory;

  @override
  Future<PaymentExecutionResult> executePayment(
      PaymentExecutionRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 560));
    final narrative =
        _factory.buildPaymentNarrative(channel: 'PayPal', request: request);
    return PaymentExecutionResult(
      status: PaymentExecutionStatus.success,
      message: narrative.statusMessage,
      reference: narrative.reference,
      metadata: narrative.metadata,
    );
  }

  @override
  Future<bool> isAvailable() async => true;
}

class DemoNfcPaymentService extends NfcPaymentService {
  DemoNfcPaymentService(this._factory);

  final DemoSandboxFactory _factory;

  @override
  Future<PaymentExecutionResult> executePayment(
      PaymentExecutionRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 520));
    final narrative =
        _factory.buildPaymentNarrative(channel: 'NFC', request: request);
    return PaymentExecutionResult(
      status: PaymentExecutionStatus.success,
      message: narrative.statusMessage,
      reference: narrative.reference,
      metadata: narrative.metadata,
    );
  }

  @override
  Future<bool> isAvailable() async => true;
}

class DemoTseService extends TseService {
  DemoTseService(this._factory);

  final DemoSandboxFactory _factory;

  @override
  Future<TseStatus> checkStatus() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    return _factory.buildTseStatus();
  }

  @override
  Future<TseSignatureResult> signReceipt({
    required int tableNumber,
    required double amount,
    required String paymentMethod,
    required String receiptText,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 240));
    return _factory.buildTseSignature(
      tableNumber: tableNumber,
      amount: amount,
      paymentMethod: paymentMethod,
    );
  }
}

class DemoPrinterService implements PrinterService {
  DemoPrinterService(this._factory);

  final DemoSandboxFactory _factory;
  KitchenTicketData? lastKitchenTicket;
  GuestReceiptData? lastGuestReceipt;

  @override
  Future<List<PrinterDevice>> discoverBluetoothPrinters() async {
    await Future<void>.delayed(const Duration(milliseconds: 220));
    return _factory.discoverDemoPrinters();
  }

  @override
  Future<PrinterProfile?> getDefaultKitchenPrinter() async {
    return _factory.kitchenPrinterProfile();
  }

  @override
  Future<PrinterProfile?> getDefaultReceiptPrinter() async {
    return _factory.receiptPrinterProfile();
  }

  @override
  Future<PrintResult> printKitchenTicket(KitchenTicketData data) async {
    await Future<void>.delayed(const Duration(milliseconds: 320));
    lastKitchenTicket = _factory.enrichKitchenTicket(data);
    return PrintResult.successDetailed(
      message:
          'Demo kitchen ticket rendered with Phoenix branding and fiscal sandbox context.',
      profile: _factory.kitchenPrinterProfile(),
    );
  }

  @override
  Future<PrintResult> printGuestReceipt(GuestReceiptData data) async {
    await Future<void>.delayed(const Duration(milliseconds: 360));
    lastGuestReceipt = _factory.enrichGuestReceipt(data);
    return PrintResult.successDetailed(
      message:
          'Demo receipt rendered with Phoenix logo and sandbox TSE signature.',
      profile: _factory.receiptPrinterProfile(),
    );
  }
}
