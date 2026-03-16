import 'package:isar/isar.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';
import 'package:orderman_flutter/features/floor_plan/data/table_repository.dart';
import 'package:orderman_flutter/features/floor_plan/domain/table_model.dart';
import 'package:orderman_flutter/features/order/domain/order_item_model.dart';
import 'package:orderman_flutter/features/order/domain/order_model.dart';
import 'package:orderman_flutter/features/payment/data/payment_model.dart';
import 'package:orderman_flutter/features/printer/data/printer_profile_model.dart';

class MigrationService {
  MigrationService(this._isarService);

  final IsarService _isarService;

  Future<IsarMigrationResult> migrateInMemorySeedData() {
    return _isarService.runMigration(
      (db) async =>
          (await db.tableModels.where().sortByTableNumber().findAll()).isEmpty,
      (db) async {
        final seedTables = InMemoryTableRepository.seedTables();
        await db.writeTxn(() async {
          await db.tableModels.putAll(seedTables);
        });
      },
    );
  }

  Future<IsarMigrationResult> verifyCollectionsAccessible() {
    return _isarService.runMigration(
      (db) async {
        await db.tableModels.count();
        await db.orderModels.count();
        await db.orderItemModels.count();
        await db.paymentModels.count();
        await db.paymentPartModels.count();
        await db.printerProfileModels.count();
        return false;
      },
      (_) async {},
    );
  }
}
