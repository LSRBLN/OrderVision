import 'dart:io';
import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:orderman_flutter/features/floor_plan/domain/table_model.dart';
import 'package:orderman_flutter/features/order/domain/order_item_model.dart';
import 'package:orderman_flutter/features/order/domain/order_model.dart';
import 'package:orderman_flutter/features/payment/data/payment_model.dart';
import 'package:orderman_flutter/features/menu/data/menu_category_model.dart';
import 'package:orderman_flutter/features/menu/data/menu_item_model.dart';
import 'package:orderman_flutter/features/printer/data/printer_profile_model.dart';

class IsarMigrationResult {
  const IsarMigrationResult({
    required this.hasMigrated,
    required this.message,
  });

  final bool hasMigrated;
  final String message;
}

class IsarService {
  IsarService._();

  static final IsarService instance = IsarService._();

  Isar? _isar;

  Isar get isar {
    final db = _isar;
    if (db == null) {
      throw StateError('IsarService is not initialized. Call init() first.');
    }
    return db;
  }

  bool get isReady => _isar != null;

  Future<Directory> get databaseDirectory async {
    return getApplicationDocumentsDirectory();
  }

  Future<Isar> init({String? directoryPath}) async {
    if (_isar != null) {
      return _isar!;
    }

    final dir = directoryPath == null
        ? await databaseDirectory
        : Directory(directoryPath);
    _isar = await Isar.open(
      [
        TableModelSchema,
        OrderModelSchema,
        OrderItemModelSchema,
        PaymentModelSchema,
        MenuCategoryModelSchema,
        MenuItemModelSchema,
        PrinterProfileModelSchema,
      ],
      directory: dir.path,
      name: 'orderman_flutter',
    );

    return _isar!;
  }

  Future<void> close() async {
    final db = _isar;
    if (db == null) {
      return;
    }

    await db.close();
    _isar = null;
  }

  Future<void> clearAll() async {
    final db = isar;
    await db.writeTxn(() async {
      await db.clear();
    });
  }

  Future<String> createBackup({String? backupFilePath}) async {
    final db = isar;
    final directory = await databaseDirectory;
    final filePath = backupFilePath ??
        '${directory.path}/orderman_flutter_backup_${DateTime.now().millisecondsSinceEpoch}.isar';
    await db.copyToFile(filePath);
    return filePath;
  }

  Future<String> exportJsonBackup({String? backupFilePath}) async {
    final db = isar;
    final directory = await databaseDirectory;
    final filePath = backupFilePath ??
        '${directory.path}/orderman_flutter_backup_${DateTime.now().millisecondsSinceEpoch}.json';

    final tables = await db.tableModels.where().findAll();
    final orders = await db.orderModels.where().findAll();
    final payments = await db.paymentModels.where().findAll();
    final menuCategories = await db.menuCategoryModels.where().findAll();
    final menuItems = await db.menuItemModels.where().findAll();
    final printerProfiles = await db.printerProfileModels.where().findAll();

    final payload = <String, dynamic>{
      'exportedAt': DateTime.now().toIso8601String(),
      'tables': tables
          .map((table) => <String, dynamic>{
                'tableNumber': table.tableNumber,
                'posX': table.posX,
                'posY': table.posY,
                'seats': table.seats,
                'status': table.status.name,
                'assignedWaiterId': table.assignedWaiterId,
                'openedAt': table.openedAt?.toIso8601String(),
              })
          .toList(growable: false),
      'orders': orders
          .map((order) => <String, dynamic>{
                'tableId': order.tableId,
                'waiterId': order.waiterId,
                'createdAt': order.createdAt.toIso8601String(),
                'status': order.status.name,
                'totalAmount': order.totalAmount,
                'tipAmount': order.tipAmount,
              })
          .toList(growable: false),
      'payments': payments
          .map((payment) => <String, dynamic>{
                'tableNumber': payment.tableNumber,
                'createdAt': payment.createdAt.toIso8601String(),
                'method': payment.method.name,
                'splitMode': payment.splitMode.name,
                'totalAmount': payment.totalAmount,
                'paidAmount': payment.paidAmount,
                'isCompleted': payment.isCompleted,
              })
          .toList(growable: false),
      'menuCategories': menuCategories
          .map((category) => <String, dynamic>{
                'categoryId': category.categoryId,
                'name': category.name,
                'sortOrder': category.sortOrder,
              })
          .toList(growable: false),
      'menuItems': menuItems
          .map((item) => <String, dynamic>{
                'itemId': item.itemId,
                'categoryId': item.categoryId,
                'name': item.name,
                'price': item.price,
                'happyHourPrice': item.happyHourPrice,
                'premiumPrice': item.premiumPrice,
                'priceLevels': item.priceLevels,
                'allergens': item.allergens,
                'discountEligible': item.discountEligible,
                'isActive': item.isActive,
                'autoDiscountThreshold': item.autoDiscountThreshold,
                'autoDiscountPercent': item.autoDiscountPercent,
                'sortOrder': item.sortOrder,
              })
          .toList(growable: false),
      'printerProfiles': printerProfiles
          .map((profile) => <String, dynamic>{
                'name': profile.name,
                'connectionType': profile.connectionType,
                'bluetoothAddress': profile.bluetoothAddress,
                'ipAddress': profile.ipAddress,
                'port': profile.port,
                'charactersPerLine': profile.charactersPerLine,
                'paperWidthMm': profile.paperWidthMm,
                'dpi': profile.dpi,
                'timeoutMs': profile.timeoutMs,
                'autoCut': profile.autoCut,
                'openCashDrawer': profile.openCashDrawer,
                'isDefault': profile.isDefault,
                'isKitchenPrinter': profile.isKitchenPrinter,
                'isReceiptPrinter': profile.isReceiptPrinter,
                'logoUrl': profile.logoUrl,
              })
          .toList(growable: false),
    };

    final file = File(filePath);
    await file
        .writeAsString(const JsonEncoder.withIndent('  ').convert(payload));
    return filePath;
  }

  Future<String> restoreJsonBackup(String backupFilePath) async {
    final file = File(backupFilePath);
    if (!await file.exists()) {
      throw StateError('Backup-Datei nicht gefunden: $backupFilePath');
    }

    final content = await file.readAsString();
    final payload = jsonDecode(content) as Map<String, dynamic>;
    final menuItems = (payload['menuItems'] as List<dynamic>? ?? const []);

    await clearAll();

    await isar.writeTxn(() async {
      for (final rawItem in menuItems) {
        final item = rawItem as Map<String, dynamic>;
        final menuItem = MenuItemModel()
          ..itemId = item['itemId']?.toString() ?? ''
          ..categoryId = item['categoryId']?.toString() ?? ''
          ..name = item['name']?.toString() ?? ''
          ..price = (item['price'] as num?)?.toDouble() ?? 0
          ..happyHourPrice = (item['happyHourPrice'] as num?)?.toDouble()
          ..premiumPrice = (item['premiumPrice'] as num?)?.toDouble()
          ..priceLevels = item['priceLevels']?.toString() ?? ''
          ..allergens = item['allergens']?.toString() ?? ''
          ..discountEligible = item['discountEligible'] as bool? ?? true
          ..isActive = item['isActive'] as bool? ?? true
          ..autoDiscountThreshold =
              (item['autoDiscountThreshold'] as num?)?.toInt() ?? 0
          ..autoDiscountPercent =
              (item['autoDiscountPercent'] as num?)?.toDouble() ?? 0
          ..sortOrder = (item['sortOrder'] as num?)?.toInt() ?? 0;
        await isar.menuItemModels.put(menuItem);
      }
    });

    return 'JSON-Backup wiederhergestellt: $backupFilePath';
  }

  Future<IsarMigrationResult> runMigration(
    Future<bool> Function(Isar db) migrationCheck,
    Future<void> Function(Isar db) migrationAction,
  ) async {
    final db = isar;
    final shouldMigrate = await migrationCheck(db);
    if (!shouldMigrate) {
      return const IsarMigrationResult(
        hasMigrated: false,
        message: 'Keine Migration erforderlich.',
      );
    }

    await migrationAction(db);
    return const IsarMigrationResult(
      hasMigrated: true,
      message: 'Migration erfolgreich durchgeführt.',
    );
  }
}
