import 'package:isar/isar.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';
import 'package:orderman_flutter/features/floor_plan/domain/table_model.dart';

abstract class TableRepository {
  Future<List<TableModel>> loadTables();
  Future<void> updateTable(TableModel table);
}

class IsarTableRepository implements TableRepository {
  IsarTableRepository(this._isarService);

  final IsarService _isarService;

  @override
  Future<List<TableModel>> loadTables() async {
    final db = _isarService.isar;
    final existing = await db.tableModels.where().sortByTableNumber().findAll();
    if (existing.isNotEmpty) {
      return existing.map(_cloneTable).toList();
    }

    final seed = InMemoryTableRepository.seedTables();
    await db.writeTxn(() async {
      await db.tableModels.putAll(seed);
    });

    return seed.map(_cloneTable).toList();
  }

  @override
  Future<void> updateTable(TableModel table) async {
    final db = _isarService.isar;
    final existing = await db.tableModels
        .filter()
        .tableNumberEqualTo(table.tableNumber)
        .findFirst();
    final next = _cloneTable(table);
    if (existing != null) {
      next.id = existing.id;
    }

    await db.writeTxn(() async {
      await db.tableModels.put(next);
    });
  }
}

class InMemoryTableRepository implements TableRepository {
  InMemoryTableRepository() : _tables = seedTables();

  final List<TableModel> _tables;

  @override
  Future<List<TableModel>> loadTables() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return _tables.map(_cloneTable).toList();
  }

  @override
  Future<void> updateTable(TableModel table) async {
    await Future<void>.delayed(const Duration(milliseconds: 60));
    final index =
        _tables.indexWhere((item) => item.tableNumber == table.tableNumber);
    if (index == -1) {
      _tables.add(_cloneTable(table));
      return;
    }
    _tables[index] = _cloneTable(table);
  }

  static List<TableModel> seedTables() {
    final result = <TableModel>[];
    for (var i = 0; i < 12; i++) {
      final table = TableModel()
        ..tableNumber = i + 1
        ..posX = 0.1 + ((i % 4) * 0.22)
        ..posY = 0.1 + ((i ~/ 4) * 0.26)
        ..seats = (i % 2 == 0) ? 4 : 6
        ..status = TableStatus.free
        ..assignedWaiterId = (i < 6) ? 'w-001' : 'w-002';
      result.add(table);
    }
    return result;
  }

  static TableModel _cloneTable(TableModel source) {
    return _cloneTableStatic(source);
  }

  static TableModel _cloneTableStatic(TableModel source) {
    return TableModel()
      ..id = source.id
      ..tableNumber = source.tableNumber
      ..posX = source.posX
      ..posY = source.posY
      ..seats = source.seats
      ..status = source.status
      ..assignedWaiterId = source.assignedWaiterId
      ..openedAt = source.openedAt;
  }
}

TableModel _cloneTable(TableModel source) {
  return InMemoryTableRepository._cloneTableStatic(source);
}
