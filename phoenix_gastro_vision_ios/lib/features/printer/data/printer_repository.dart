import 'package:isar/isar.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';
import 'package:orderman_flutter/features/printer/data/printer_profile_model.dart';
import 'package:orderman_flutter/features/printer/domain/printer_service.dart';

abstract class PrinterRepository {
  Future<List<PrinterProfile>> loadProfiles();
  Future<void> saveProfile(PrinterProfile profile);
  Future<void> deleteProfile(String profileId);
  Future<PrinterProfile?> getDefaultKitchenPrinter();
  Future<PrinterProfile?> getDefaultReceiptPrinter();
}

class IsarPrinterRepository implements PrinterRepository {
  IsarPrinterRepository(this._isarService);

  final IsarService _isarService;

  @override
  Future<void> deleteProfile(String profileId) async {
    final db = _isarService.isar;
    final existing = await db.printerProfileModels.getByProfileId(profileId);
    if (existing == null) {
      return;
    }

    await db.writeTxn(() async {
      await db.printerProfileModels.delete(existing.id);
    });
  }

  @override
  Future<PrinterProfile?> getDefaultKitchenPrinter() async {
    final profiles = await loadProfiles();
    return profiles
        .where((item) => item.isKitchenPrinter)
        .cast<PrinterProfile?>()
        .firstWhere(
          (item) => item?.isDefault == true,
          orElse: () => profiles
              .where((item) => item.isKitchenPrinter)
              .cast<PrinterProfile?>()
              .firstWhere(
                (item) => item != null,
                orElse: () => null,
              ),
        );
  }

  @override
  Future<PrinterProfile?> getDefaultReceiptPrinter() async {
    final profiles = await loadProfiles();
    return profiles
        .where((item) => item.isReceiptPrinter)
        .cast<PrinterProfile?>()
        .firstWhere(
          (item) => item?.isDefault == true,
          orElse: () => profiles
              .where((item) => item.isReceiptPrinter)
              .cast<PrinterProfile?>()
              .firstWhere(
                (item) => item != null,
                orElse: () => null,
              ),
        );
  }

  @override
  Future<List<PrinterProfile>> loadProfiles() async {
    final db = _isarService.isar;
    final records = await db.printerProfileModels.where().anyId().findAll();
    return records.map((item) => item.toDomain()).toList(growable: false);
  }

  @override
  Future<void> saveProfile(PrinterProfile profile) async {
    final db = _isarService.isar;
    final existing = await db.printerProfileModels.getByProfileId(profile.id);

    final model = profile.toModel();
    if (existing != null) {
      model.id = existing.id;
    }

    await db.writeTxn(() async {
      if (profile.isDefault) {
        final sameTypeProfiles =
            await db.printerProfileModels.where().anyId().findAll();
        for (final item in sameTypeProfiles) {
          final matchesScope =
              (profile.isKitchenPrinter && item.isKitchenPrinter) ||
                  (profile.isReceiptPrinter && item.isReceiptPrinter);
          if (!matchesScope || item.profileId == profile.id) {
            continue;
          }
          item.isDefault = false;
          await db.printerProfileModels.put(item);
        }
      }
      await db.printerProfileModels.put(model);
    });
  }
}

class InMemoryPrinterRepository implements PrinterRepository {
  final List<PrinterProfile> _profiles = <PrinterProfile>[];

  @override
  Future<void> deleteProfile(String profileId) async {
    _profiles.removeWhere((item) => item.id == profileId);
  }

  @override
  Future<PrinterProfile?> getDefaultKitchenPrinter() async {
    return _profiles
        .where((item) => item.isKitchenPrinter)
        .cast<PrinterProfile?>()
        .firstWhere(
          (item) => item?.isDefault == true,
          orElse: () => _profiles
              .where((item) => item.isKitchenPrinter)
              .cast<PrinterProfile?>()
              .firstWhere(
                (item) => item != null,
                orElse: () => null,
              ),
        );
  }

  @override
  Future<PrinterProfile?> getDefaultReceiptPrinter() async {
    return _profiles
        .where((item) => item.isReceiptPrinter)
        .cast<PrinterProfile?>()
        .firstWhere(
          (item) => item?.isDefault == true,
          orElse: () => _profiles
              .where((item) => item.isReceiptPrinter)
              .cast<PrinterProfile?>()
              .firstWhere(
                (item) => item != null,
                orElse: () => null,
              ),
        );
  }

  @override
  Future<List<PrinterProfile>> loadProfiles() async {
    return List<PrinterProfile>.unmodifiable(_profiles);
  }

  @override
  Future<void> saveProfile(PrinterProfile profile) async {
    _profiles.removeWhere((item) => item.id == profile.id);
    if (profile.isDefault) {
      for (var i = 0; i < _profiles.length; i++) {
        final current = _profiles[i];
        final matchesScope =
            (profile.isKitchenPrinter && current.isKitchenPrinter) ||
                (profile.isReceiptPrinter && current.isReceiptPrinter);
        if (!matchesScope) {
          continue;
        }
        _profiles[i] = PrinterProfile(
          id: current.id,
          name: current.name,
          connectionType: current.connectionType,
          bluetoothAddress: current.bluetoothAddress,
          ipAddress: current.ipAddress,
          port: current.port,
          charactersPerLine: current.charactersPerLine,
          paperWidthMm: current.paperWidthMm,
          dpi: current.dpi,
          timeoutMs: current.timeoutMs,
          autoCut: current.autoCut,
          openCashDrawer: current.openCashDrawer,
          isDefault: false,
          isKitchenPrinter: current.isKitchenPrinter,
          isReceiptPrinter: current.isReceiptPrinter,
          logoUrl: current.logoUrl,
        );
      }
    }
    _profiles.add(profile);
  }
}
