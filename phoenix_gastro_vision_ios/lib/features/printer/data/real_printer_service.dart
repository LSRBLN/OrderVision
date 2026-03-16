import 'dart:async';

import 'package:flutter_thermal_printer_pos/flutter_thermal_printer_pos.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/core/permissions/permission_service.dart';
import 'package:orderman_flutter/features/printer/data/printer_repository.dart';
import 'package:orderman_flutter/features/printer/domain/printer_service.dart';

class RealPrinterService implements PrinterService {
  RealPrinterService({
    required PermissionService permissionService,
    required PrinterRepository printerRepository,
  })  : _permissionService = permissionService,
        _printerRepository = printerRepository;

  final PermissionService _permissionService;
  final PrinterRepository _printerRepository;

  @override
  Future<List<PrinterDevice>> discoverBluetoothPrinters() async {
    final permissionResult =
        await _permissionService.ensurePrinterPermissions();
    if (!permissionResult.allGranted) {
      return const <PrinterDevice>[];
    }

    final devices = await FlutterThermalPrinterPos.getBluetoothDevices();
    return devices
        .map(
          (device) => PrinterDevice(
            id: device.address,
            name: device.name,
            connectionType: PrinterConnectionType.bluetooth,
            address: device.address,
            isBonded: device.bondState > 0,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<PrinterProfile?> getDefaultKitchenPrinter() {
    return _printerRepository.getDefaultKitchenPrinter();
  }

  @override
  Future<PrinterProfile?> getDefaultReceiptPrinter() {
    return _printerRepository.getDefaultReceiptPrinter();
  }

  @override
  Future<PrintResult> printGuestReceipt(GuestReceiptData data) async {
    final profile = await _printerRepository.getDefaultReceiptPrinter();
    if (profile == null) {
      return const PrintResult.failure(
        failure: PrinterFailure.noPrinter,
        message: 'Kein Standard-Rechnungsdrucker konfiguriert.',
      );
    }

    final payload = _buildGuestReceiptPayload(data, profile);
    return _printWithRetry(
      profile: profile,
      payload: payload,
      successMessage: 'Rechnung erfolgreich gedruckt.',
    );
  }

  @override
  Future<PrintResult> printKitchenTicket(KitchenTicketData data) async {
    final profile = await _printerRepository.getDefaultKitchenPrinter();
    if (profile == null) {
      return const PrintResult.failure(
        failure: PrinterFailure.noPrinter,
        message: 'Kein Küchen-Drucker konfiguriert.',
      );
    }

    final payload = _buildKitchenTicketPayload(data, profile);
    return _printWithRetry(
      profile: profile,
      payload: payload,
      successMessage: 'Küchenbon erfolgreich gedruckt.',
    );
  }

  String _buildGuestReceiptPayload(
    GuestReceiptData data,
    PrinterProfile profile,
  ) {
    final buffer = StringBuffer()
      ..writeln(
        data.trainingMode
            ? '[C]<b>${BrandingConfig.current.texts.printerTrainingLabel}</b>'
            : '[C]<b>${BrandingConfig.current.texts.printerReceiptHeader}</b>',
      )
      ..writeln('[C]<b>${data.restaurantName}</b>')
      ..writeln('[C]Tisch ${data.tableNumber}')
      ..writeln(
        data.paymentMethodLabel == null || data.paymentMethodLabel!.isEmpty
            ? '[L]'
            : '[C]Zahlungsart: ${data.paymentMethodLabel}',
      )
      ..writeln('[L]')
      ..writeln('[L]${DateTime.now()}')
      ..writeln('[L]--------------------------------')
      ..writeln(
        data.items.map(
          (item) {
            final line =
                "[L]${item.quantity}x ${item.name}[R]${(item.totalPrice ?? item.quantity * item.unitPrice).toStringAsFixed(2)}€";
            final extras = <String>[
              if (item.discountLabel != null && item.discountLabel!.isNotEmpty)
                '[L]- ${item.discountLabel}',
              if (item.voidLabel != null && item.voidLabel!.isNotEmpty)
                "[L]<b>STORNO: ${item.voidLabel}</b>",
            ];
            return ([line, ...extras]).join('\n');
          },
        ).join('\n'),
      )
      ..writeln('[L]--------------------------------')
      ..writeln('[R]Gesamt:[R]${data.totalAmount.toStringAsFixed(2)}€');

    if (data.orderDiscountLabel != null &&
        data.orderDiscountLabel!.isNotEmpty) {
      buffer.writeln('[L]- ${data.orderDiscountLabel}');
    }

    if (data.voidSummary != null && data.voidSummary!.isNotEmpty) {
      buffer.writeln('[L]<b>Storno: ${data.voidSummary}</b>');
    }

    if (data.exchangeRateInfo != null && data.exchangeRateInfo!.isNotEmpty) {
      buffer.writeln('[L]Kursinfo: ${data.exchangeRateInfo}');
    }

    if (data.tipAmount > 0) {
      buffer.writeln('[R]Trinkgeld:[R]${data.tipAmount.toStringAsFixed(2)}€');
    }

    if (data.tseTransactionId != null && data.tseTransactionId!.isNotEmpty) {
      buffer.writeln('[L]TSE-ID: ${data.tseTransactionId}');
    }

    if (data.tseSignatureText != null && data.tseSignatureText!.isNotEmpty) {
      buffer.writeln('[L]TSE: ${data.tseSignatureText}');
    }

    if (data.qrData != null && data.qrData!.isNotEmpty) {
      buffer.writeln("[C]<qrcode size='10'>${data.qrData}</qrcode>");
    }

    buffer
      ..writeln('[C]${data.footerMessage}')
      ..writeln('[L]');

    final logoSource = data.brandLogoAsset ?? profile.logoUrl;
    if (logoSource != null && logoSource.isNotEmpty) {
      return "[C]<img>$logoSource</img>\n${buffer.toString()}";
    }
    return buffer.toString();
  }

  String _buildKitchenTicketPayload(
    KitchenTicketData data,
    PrinterProfile profile,
  ) {
    final buffer = StringBuffer()
      ..writeln(
        data.trainingMode
            ? '[C]<b>${BrandingConfig.current.texts.printerTrainingLabel}</b>'
            : '[C]<b>${BrandingConfig.current.texts.printerReceiptHeader}</b>',
      )
      ..writeln(
        '[C]<font size=\'big\'><b>${BrandingConfig.current.texts.printerKitchenTitle}</b></font>',
      )
      ..writeln('[C]Tisch ${data.tableNumber}')
      ..writeln(
        data.waiterName == null || data.waiterName!.isEmpty
            ? '[L]'
            : '[L]Kellner: ${data.waiterName}',
      )
      ..writeln(
        data.paymentMethodLabel == null || data.paymentMethodLabel!.isEmpty
            ? '[L]'
            : '[L]Zahlungsart: ${data.paymentMethodLabel}',
      )
      ..writeln('[L]--------------------------------');

    for (final item in data.items) {
      buffer.writeln("[L]<b>${item.quantity}x ${item.name}</b>");
      if (item.discountLabel != null && item.discountLabel!.isNotEmpty) {
        buffer.writeln('[L]  Rabatt: ${item.discountLabel}');
      }
      if (item.voidLabel != null && item.voidLabel!.isNotEmpty) {
        buffer.writeln('[L]<b>  STORNO: ${item.voidLabel}</b>');
      }
      if (item.note != null && item.note!.isNotEmpty) {
        buffer.writeln('[L]  ! ${item.note}');
      }
    }

    buffer
      ..writeln('[L]--------------------------------')
      ..writeln(
        data.discountSummary == null || data.discountSummary!.isEmpty
            ? '[L]'
            : '[L]Rabatt: ${data.discountSummary}',
      )
      ..writeln(
        data.voidSummary == null || data.voidSummary!.isEmpty
            ? '[L]'
            : '[L]<b>Storno: ${data.voidSummary}</b>',
      )
      ..writeln(
        data.exchangeRateInfo == null || data.exchangeRateInfo!.isEmpty
            ? '[L]'
            : '[L]Kursinfo: ${data.exchangeRateInfo}',
      )
      ..writeln(
        data.tseSignatureText == null || data.tseSignatureText!.isEmpty
            ? '[L]'
            : '[L]TSE: ${data.tseSignatureText}',
      )
      ..writeln('[C]${DateTime.now()}');

    final logoSource = data.brandLogoAsset ?? profile.logoUrl;
    if (logoSource != null && logoSource.isNotEmpty) {
      return "[C]<img>$logoSource</img>\n${buffer.toString()}";
    }
    return buffer.toString();
  }

  Future<PrintResult> _printWithRetry({
    required PrinterProfile profile,
    required String payload,
    required String successMessage,
  }) async {
    final permissionResult =
        await _permissionService.ensurePrinterPermissions();
    if (profile.isBluetooth && !permissionResult.allGranted) {
      return PrintResult.failure(
        failure: PrinterFailure.permissionDenied,
        message: permissionResult.hasPermanentlyDenied
            ? 'Bluetooth-Berechtigungen wurden dauerhaft verweigert.'
            : 'Bluetooth-Berechtigungen fehlen für den Druck.',
        profile: profile,
      );
    }

    const maxAttempts = 2;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final success =
            await _dispatchPrint(profile: profile, payload: payload);
        if (success) {
          return PrintResult.successDetailed(
            message: successMessage,
            profile: profile,
            attempts: attempt,
          );
        }
      } on ThermalPrinterException catch (error) {
        final failure = _mapFailure(error);
        if (attempt >= maxAttempts) {
          return PrintResult.failure(
            failure: failure,
            message: _mapErrorMessage(error, failure),
            profile: profile,
            attempts: attempt,
          );
        }
      } on TimeoutException {
        if (attempt >= maxAttempts) {
          return PrintResult.failure(
            failure: PrinterFailure.timeout,
            message: 'Druck-Timeout. Bitte Verbindung zum Drucker prüfen.',
            profile: profile,
            attempts: attempt,
          );
        }
      } catch (_) {
        if (attempt >= maxAttempts) {
          return PrintResult.failure(
            failure: PrinterFailure.unknown,
            message: 'Unbekannter Druckfehler.',
            profile: profile,
            attempts: attempt,
          );
        }
      }
    }

    return PrintResult.failure(
      failure: PrinterFailure.unknown,
      message: 'Druck konnte nicht abgeschlossen werden.',
      profile: profile,
      attempts: maxAttempts,
    );
  }

  Future<bool> _dispatchPrint({
    required PrinterProfile profile,
    required String payload,
  }) {
    if (profile.isBluetooth) {
      final address = profile.bluetoothAddress;
      if (address == null || address.isEmpty) {
        throw ThermalPrinterException(
          code: 'INVALID_ARGUMENTS',
          message: 'Bluetooth-Adresse fehlt.',
        );
      }

      return FlutterThermalPrinterPos.printBluetoothDevice(
        address: address,
        payload: payload,
        autoCut: profile.autoCut,
        openCashbox: profile.openCashDrawer,
        printerDpi: profile.dpi,
        printerWidthMM: profile.paperWidthMm,
        printerNbrCharactersPerLine: profile.charactersPerLine,
      );
    }

    final ipAddress = profile.ipAddress;
    if (ipAddress == null || ipAddress.isEmpty) {
      throw ThermalPrinterException(
        code: 'INVALID_ARGUMENTS',
        message: 'IP-Adresse fehlt.',
      );
    }

    return FlutterThermalPrinterPos.printTcp(
      ip: ipAddress,
      port: profile.port,
      payload: payload,
      autoCut: profile.autoCut,
      openCashbox: profile.openCashDrawer,
      printerDpi: profile.dpi,
      printerWidthMM: profile.paperWidthMm,
      printerNbrCharactersPerLine: profile.charactersPerLine,
      timeout: profile.timeoutMs,
    );
  }

  PrinterFailure _mapFailure(ThermalPrinterException error) {
    final code = error.code.toUpperCase();
    final message = error.message.toLowerCase();
    if (code.contains('INVALID_ARGUMENTS')) {
      return PrinterFailure.invalidConfiguration;
    }
    if (code.contains('BLUETOOTH')) {
      return PrinterFailure.bluetoothUnavailable;
    }
    if (message.contains('timeout')) {
      return PrinterFailure.timeout;
    }
    if (message.contains('paper')) {
      return PrinterFailure.paperOut;
    }
    if (message.contains('connection')) {
      return PrinterFailure.connectionLost;
    }
    return PrinterFailure.unknown;
  }

  String _mapErrorMessage(
    ThermalPrinterException error,
    PrinterFailure failure,
  ) {
    switch (failure) {
      case PrinterFailure.invalidConfiguration:
        return 'Drucker-Konfiguration ist ungültig.';
      case PrinterFailure.bluetoothUnavailable:
        return 'Bluetooth-Drucker ist nicht erreichbar.';
      case PrinterFailure.timeout:
        return 'Drucker antwortet nicht rechtzeitig.';
      case PrinterFailure.paperOut:
        return 'Drucker meldet Papierproblem.';
      case PrinterFailure.connectionLost:
        return 'Verbindung zum Drucker wurde unterbrochen.';
      case PrinterFailure.permissionDenied:
        return 'Berechtigungen für den Druck fehlen.';
      case PrinterFailure.noPrinter:
        return 'Kein Drucker verfügbar.';
      case PrinterFailure.unknown:
        return error.message;
    }
  }
}
