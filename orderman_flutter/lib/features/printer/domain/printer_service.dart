class KitchenTicketItem {
  const KitchenTicketItem({
    required this.quantity,
    required this.name,
    this.note,
    this.discountLabel,
    this.voidLabel,
  });

  final int quantity;
  final String name;
  final String? note;
  final String? discountLabel;
  final String? voidLabel;
}

class GuestReceiptItem {
  const GuestReceiptItem({
    required this.quantity,
    required this.name,
    required this.unitPrice,
    this.totalPrice,
    this.discountLabel,
    this.voidLabel,
  });

  final int quantity;
  final String name;
  final double unitPrice;
  final double? totalPrice;
  final String? discountLabel;
  final String? voidLabel;
}

class KitchenTicketData {
  const KitchenTicketData({
    required this.tableNumber,
    required this.items,
    this.waiterName,
    this.brandLogoAsset,
    this.paymentMethodLabel,
    this.tseSignatureText,
    this.exchangeRateInfo,
    this.discountSummary,
    this.voidSummary,
    this.trainingMode = false,
  });

  final int tableNumber;
  final String? waiterName;
  final List<KitchenTicketItem> items;
  final String? brandLogoAsset;
  final String? paymentMethodLabel;
  final String? tseSignatureText;
  final String? exchangeRateInfo;
  final String? discountSummary;
  final String? voidSummary;
  final bool trainingMode;
}

class GuestReceiptData {
  const GuestReceiptData({
    required this.tableNumber,
    required this.items,
    required this.totalAmount,
    this.waiterName,
    this.tipAmount = 0,
    this.restaurantName = 'OrderFlutter POS',
    this.qrData,
    this.footerMessage = 'Danke für Ihren Besuch!',
    this.orderDiscountLabel,
    this.brandLogoAsset,
    this.paymentMethodLabel,
    this.tseSignatureText,
    this.tseTransactionId,
    this.exchangeRateInfo,
    this.voidSummary,
    this.trainingMode = false,
  });

  final int tableNumber;
  final String? waiterName;
  final List<GuestReceiptItem> items;
  final double totalAmount;
  final double tipAmount;
  final String restaurantName;
  final String? qrData;
  final String footerMessage;
  final String? orderDiscountLabel;
  final String? brandLogoAsset;
  final String? paymentMethodLabel;
  final String? tseSignatureText;
  final String? tseTransactionId;
  final String? exchangeRateInfo;
  final String? voidSummary;
  final bool trainingMode;
}

enum PrinterConnectionType {
  bluetooth,
  network,
}

enum PrintDocumentType {
  kitchenTicket,
  guestReceipt,
}

class PrinterDevice {
  const PrinterDevice({
    required this.id,
    required this.name,
    required this.connectionType,
    this.address,
    this.ipAddress,
    this.port,
    this.isBonded = false,
    this.isConnected = false,
  });

  final String id;
  final String name;
  final PrinterConnectionType connectionType;
  final String? address;
  final String? ipAddress;
  final int? port;
  final bool isBonded;
  final bool isConnected;

  String get stableIdentifier =>
      address ?? '${ipAddress ?? 'unknown'}:${port ?? 9100}';
}

class PrinterProfile {
  const PrinterProfile({
    required this.id,
    required this.name,
    required this.connectionType,
    this.bluetoothAddress,
    this.ipAddress,
    this.port = 9100,
    this.charactersPerLine = 42,
    this.paperWidthMm = 80,
    this.dpi = 203,
    this.timeoutMs = 30000,
    this.autoCut = true,
    this.openCashDrawer = false,
    this.isDefault = false,
    this.isKitchenPrinter = false,
    this.isReceiptPrinter = false,
    this.logoUrl,
  });

  final String id;
  final String name;
  final PrinterConnectionType connectionType;
  final String? bluetoothAddress;
  final String? ipAddress;
  final int port;
  final int charactersPerLine;
  final int paperWidthMm;
  final int dpi;
  final int timeoutMs;
  final bool autoCut;
  final bool openCashDrawer;
  final bool isDefault;
  final bool isKitchenPrinter;
  final bool isReceiptPrinter;
  final String? logoUrl;

  bool get isBluetooth => connectionType == PrinterConnectionType.bluetooth;
  bool get isNetwork => connectionType == PrinterConnectionType.network;
}

enum PrinterFailure {
  noPrinter,
  paperOut,
  connectionLost,
  timeout,
  permissionDenied,
  invalidConfiguration,
  bluetoothUnavailable,
  unknown,
}

class PrintResult {
  const PrintResult._({
    required this.success,
    required this.message,
    this.failure,
    this.profile,
    this.attempts = 1,
  });

  const PrintResult.success(String message)
      : this._(
          success: true,
          message: message,
        );

  const PrintResult.successDetailed({
    required String message,
    PrinterProfile? profile,
    int attempts = 1,
  }) : this._(
          success: true,
          message: message,
          profile: profile,
          attempts: attempts,
        );

  const PrintResult.failure({
    required PrinterFailure failure,
    required String message,
    PrinterProfile? profile,
    int attempts = 1,
  }) : this._(
          success: false,
          message: message,
          failure: failure,
          profile: profile,
          attempts: attempts,
        );

  final bool success;
  final String message;
  final PrinterFailure? failure;
  final PrinterProfile? profile;
  final int attempts;
}

abstract class PrinterService {
  Future<List<PrinterDevice>> discoverBluetoothPrinters();
  Future<PrinterProfile?> getDefaultKitchenPrinter();
  Future<PrinterProfile?> getDefaultReceiptPrinter();
  Future<PrintResult> printKitchenTicket(KitchenTicketData data);
  Future<PrintResult> printGuestReceipt(GuestReceiptData data);
}

class InMemoryPrinterService implements PrinterService {
  KitchenTicketData? lastTicket;
  GuestReceiptData? lastReceipt;
  PrintResult nextResult =
      const PrintResult.success('Küchenbon erfolgreich gesendet');

  @override
  Future<List<PrinterDevice>> discoverBluetoothPrinters() async {
    return const <PrinterDevice>[];
  }

  @override
  Future<PrinterProfile?> getDefaultKitchenPrinter() async {
    return null;
  }

  @override
  Future<PrinterProfile?> getDefaultReceiptPrinter() async {
    return null;
  }

  @override
  Future<PrintResult> printKitchenTicket(KitchenTicketData data) async {
    lastTicket = data;
    return nextResult;
  }

  @override
  Future<PrintResult> printGuestReceipt(GuestReceiptData data) async {
    lastReceipt = data;
    return const PrintResult.success('Rechnung erfolgreich gedruckt');
  }

  String buildTicketPreview(KitchenTicketData data) {
    final lines = <String>[
      if (data.trainingMode) 'TRAINING',
      'KUECHENBON',
      'Tisch: ${data.tableNumber}',
      if (data.waiterName != null && data.waiterName!.isNotEmpty)
        'Kellner: ${data.waiterName}',
      if (data.paymentMethodLabel != null &&
          data.paymentMethodLabel!.isNotEmpty)
        'Zahlungsart: ${data.paymentMethodLabel}',
      '------------------------------',
      ...data.items.expand((item) => [
            '${item.quantity}x ${item.name}',
            if (item.note != null && item.note!.isNotEmpty) '  ! ${item.note}',
          ]),
      if (data.discountSummary != null && data.discountSummary!.isNotEmpty)
        'Rabatt: ${data.discountSummary}',
      if (data.voidSummary != null && data.voidSummary!.isNotEmpty)
        'Storno: ${data.voidSummary}',
      if (data.exchangeRateInfo != null && data.exchangeRateInfo!.isNotEmpty)
        'Kurs: ${data.exchangeRateInfo}',
      if (data.tseSignatureText != null && data.tseSignatureText!.isNotEmpty)
        'TSE: ${data.tseSignatureText}',
    ];

    return lines.join('\n');
  }

  String buildReceiptPreview(GuestReceiptData data) {
    final lines = <String>[
      if (data.trainingMode) 'TRAINING',
      data.restaurantName,
      'Tisch: ${data.tableNumber}',
      if (data.waiterName != null && data.waiterName!.isNotEmpty)
        'Kellner: ${data.waiterName}',
      if (data.paymentMethodLabel != null &&
          data.paymentMethodLabel!.isNotEmpty)
        'Zahlungsart: ${data.paymentMethodLabel}',
      '------------------------------',
      ...data.items.map(
        (item) =>
            '${item.quantity}x ${item.name} ${((item.totalPrice ?? item.unitPrice * item.quantity)).toStringAsFixed(2)}€',
      ),
      '------------------------------',
      'Gesamt: ${data.totalAmount.toStringAsFixed(2)} €',
      if (data.orderDiscountLabel != null &&
          data.orderDiscountLabel!.isNotEmpty)
        'Rabatt: ${data.orderDiscountLabel}',
      if (data.voidSummary != null && data.voidSummary!.isNotEmpty)
        'Storno: ${data.voidSummary}',
      if (data.exchangeRateInfo != null && data.exchangeRateInfo!.isNotEmpty)
        'Kurs: ${data.exchangeRateInfo}',
      if (data.tipAmount > 0)
        'Trinkgeld: ${data.tipAmount.toStringAsFixed(2)} €',
      if (data.tseTransactionId != null && data.tseTransactionId!.isNotEmpty)
        'TSE-ID: ${data.tseTransactionId}',
      if (data.tseSignatureText != null && data.tseSignatureText!.isNotEmpty)
        'TSE: ${data.tseSignatureText}',
      data.footerMessage,
    ];

    return lines.join('\n');
  }
}
