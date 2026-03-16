import 'package:isar/isar.dart';
import 'package:orderman_flutter/features/printer/domain/printer_service.dart';

part 'printer_profile_model.g.dart';

@Collection()
class PrinterProfileModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String profileId;

  late String name;

  @Enumerated(EnumType.name)
  late PrinterConnectionType connectionType;

  String? bluetoothAddress;
  String? ipAddress;
  int port = 9100;
  int charactersPerLine = 42;
  int paperWidthMm = 80;
  int dpi = 203;
  int timeoutMs = 30000;
  bool autoCut = true;
  bool openCashDrawer = false;
  bool isDefault = false;
  bool isKitchenPrinter = false;
  bool isReceiptPrinter = false;
  String? logoUrl;
}

extension PrinterProfileModelMapper on PrinterProfileModel {
  PrinterProfile toDomain() {
    return PrinterProfile(
      id: profileId,
      name: name,
      connectionType: connectionType,
      bluetoothAddress: bluetoothAddress,
      ipAddress: ipAddress,
      port: port,
      charactersPerLine: charactersPerLine,
      paperWidthMm: paperWidthMm,
      dpi: dpi,
      timeoutMs: timeoutMs,
      autoCut: autoCut,
      openCashDrawer: openCashDrawer,
      isDefault: isDefault,
      isKitchenPrinter: isKitchenPrinter,
      isReceiptPrinter: isReceiptPrinter,
      logoUrl: logoUrl,
    );
  }
}

extension PrinterProfileMapper on PrinterProfile {
  PrinterProfileModel toModel() {
    return PrinterProfileModel()
      ..profileId = id
      ..name = name
      ..connectionType = connectionType
      ..bluetoothAddress = bluetoothAddress
      ..ipAddress = ipAddress
      ..port = port
      ..charactersPerLine = charactersPerLine
      ..paperWidthMm = paperWidthMm
      ..dpi = dpi
      ..timeoutMs = timeoutMs
      ..autoCut = autoCut
      ..openCashDrawer = openCashDrawer
      ..isDefault = isDefault
      ..isKitchenPrinter = isKitchenPrinter
      ..isReceiptPrinter = isReceiptPrinter
      ..logoUrl = logoUrl;
  }
}
