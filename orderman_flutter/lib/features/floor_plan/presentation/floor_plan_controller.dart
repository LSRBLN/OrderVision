import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';
import 'package:orderman_flutter/features/auth/domain/user_model.dart';
import 'package:orderman_flutter/features/floor_plan/data/table_repository.dart';
import 'package:orderman_flutter/features/floor_plan/domain/table_model.dart';

class FloorPlanState {
  const FloorPlanState({
    this.isLoading = true,
    this.editMode = false,
    this.tables = const <TableModel>[],
    this.errorMessage,
  });

  final bool isLoading;
  final bool editMode;
  final List<TableModel> tables;
  final String? errorMessage;

  FloorPlanState copyWith({
    bool? isLoading,
    bool? editMode,
    List<TableModel>? tables,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FloorPlanState(
      isLoading: isLoading ?? this.isLoading,
      editMode: editMode ?? this.editMode,
      tables: tables ?? this.tables,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

final tableRepositoryProvider = Provider<TableRepository>((ref) {
  if (IsarService.instance.isReady) {
    return IsarTableRepository(IsarService.instance);
  }
  return InMemoryTableRepository();
});

final floorPlanControllerProvider =
    NotifierProvider.family<FloorPlanController, FloorPlanState, UserModel>(
  FloorPlanController.new,
);

class FloorPlanController extends FamilyNotifier<FloorPlanState, UserModel> {
  @override
  FloorPlanState build(UserModel arg) {
    Future<void>.microtask(_loadTables);
    return const FloorPlanState();
  }

  Future<void> _loadTables() async {
    final repository = ref.read(tableRepositoryProvider);
    final allTables = await repository.loadTables();

    final visibleTables = arg.isAdmin
        ? allTables
        : allTables
            .where(
                (table) => arg.allowedTableNumbers.contains(table.tableNumber))
            .toList();

    state = state.copyWith(
        isLoading: false, tables: visibleTables, clearError: true);
  }

  void toggleEditMode() {
    if (!arg.isAdmin) {
      state = state.copyWith(errorMessage: 'Edit Mode nur für Admin erlaubt.');
      return;
    }

    state = state.copyWith(editMode: !state.editMode, clearError: true);
  }

  Future<void> moveTable(int tableNumber, double nextX, double nextY) async {
    if (!state.editMode) {
      return;
    }

    final index =
        state.tables.indexWhere((table) => table.tableNumber == tableNumber);
    if (index < 0) {
      return;
    }

    final table = _copy(state.tables[index])
      ..posX = _clamp(nextX)
      ..posY = _clamp(nextY);

    final nextTables = [...state.tables]..[index] = table;
    state = state.copyWith(tables: nextTables, clearError: true);
    await ref.read(tableRepositoryProvider).updateTable(table);
  }

  Future<void> cycleStatus(int tableNumber) async {
    final index =
        state.tables.indexWhere((table) => table.tableNumber == tableNumber);
    if (index < 0) {
      return;
    }

    final old = state.tables[index];
    final nextStatus =
        TableStatus.values[(old.status.index + 1) % TableStatus.values.length];
    final updated = _copy(old)..status = nextStatus;
    final nextTables = [...state.tables]..[index] = updated;

    state = state.copyWith(tables: nextTables);
    await ref.read(tableRepositoryProvider).updateTable(updated);
  }

  Future<void> lockOrUnlockTable(int tableNumber) async {
    final index =
        state.tables.indexWhere((table) => table.tableNumber == tableNumber);
    if (index < 0) {
      return;
    }

    final old = state.tables[index];
    final updated = _copy(old)
      ..assignedWaiterId = old.assignedWaiterId == 'LOCKED' ? arg.id : 'LOCKED';
    final nextTables = [...state.tables]..[index] = updated;

    state = state.copyWith(tables: nextTables);
    await ref.read(tableRepositoryProvider).updateTable(updated);
  }

  Future<void> transferTable(int tableNumber) async {
    final index =
        state.tables.indexWhere((table) => table.tableNumber == tableNumber);
    if (index < 0) {
      return;
    }

    final old = state.tables[index];
    final updated = _copy(old)
      ..assignedWaiterId = old.assignedWaiterId == 'w-001' ? 'w-002' : 'w-001';
    final nextTables = [...state.tables]..[index] = updated;

    state = state.copyWith(tables: nextTables);
    await ref.read(tableRepositoryProvider).updateTable(updated);
  }

  TableModel? findByTableNumber(int tableNumber) {
    for (final table in state.tables) {
      if (table.tableNumber == tableNumber) {
        return table;
      }
    }
    return null;
  }

  double _clamp(double value) => math.max(0, math.min(1, value));

  TableModel _copy(TableModel source) {
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
