import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/features/auth/domain/user_model.dart';
import 'package:orderman_flutter/features/floor_plan/domain/table_model.dart';
import 'package:orderman_flutter/features/floor_plan/presentation/floor_plan_controller.dart';
import 'package:orderman_flutter/features/order/presentation/order_screen.dart';
import 'package:orderman_flutter/shared/widgets/phoenix_page_scaffold.dart';
import 'package:orderman_flutter/shared/widgets/phoenix_touch.dart';

class FloorPlanScreen extends ConsumerWidget {
  const FloorPlanScreen({
    super.key,
    required this.user,
    required this.onLogout,
  });

  final UserModel user;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(floorPlanControllerProvider(user));
    final controller = ref.read(floorPlanControllerProvider(user).notifier);

    return PhoenixPageScaffold(
      title: 'Tischplan',
      subtitle:
          '${BrandingConfig.current.shortBrandName} • Kellner: ${user.name}',
      headerActions: [
        PhoenixPrimaryAction(
          onPressed: controller.toggleEditMode,
          icon: Icon(state.editMode ? Icons.edit_off : Icons.edit),
          child: Text(state.editMode ? 'Edit Mode Aus' : 'Edit Mode An'),
        ),
        PhoenixPrimaryAction(
          onPressed: onLogout,
          icon: const Icon(Icons.logout),
          child: const Text('Abmelden'),
        ),
      ],
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _FloorCanvas(
              user: user,
              tables: state.tables,
              editMode: state.editMode,
              onMoveTable: controller.moveTable,
              onCycleStatus: controller.cycleStatus,
              onOpenOrder: (tableNumber) {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => OrderScreen(
                      tableNumber: tableNumber,
                      waiterName: user.name,
                    ),
                  ),
                );
              },
              onLockOrUnlock: controller.lockOrUnlockTable,
              onTransfer: controller.transferTable,
            ),
    );
  }
}

class _FloorCanvas extends StatelessWidget {
  const _FloorCanvas({
    required this.user,
    required this.tables,
    required this.editMode,
    required this.onMoveTable,
    required this.onOpenOrder,
    required this.onCycleStatus,
    required this.onLockOrUnlock,
    required this.onTransfer,
  });

  final UserModel user;
  final List<TableModel> tables;
  final bool editMode;
  final Future<void> Function(int tableNumber, double nextX, double nextY)
      onMoveTable;
  final void Function(int tableNumber) onOpenOrder;
  final Future<void> Function(int tableNumber) onCycleStatus;
  final Future<void> Function(int tableNumber) onLockOrUnlock;
  final Future<void> Function(int tableNumber) onTransfer;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              for (final table in tables)
                _TableNode(
                  key: ValueKey(table.tableNumber),
                  table: table,
                  canvasSize: constraints.biggest,
                  editMode: editMode,
                  onMove: onMoveTable,
                  onTap: () => onOpenOrder(table.tableNumber),
                  onLongPress: () => _showContextMenu(
                    context,
                    table: table,
                    onCycleStatus: onCycleStatus,
                    onLockOrUnlock: onLockOrUnlock,
                    onTransfer: onTransfer,
                    isAdmin: user.isAdmin,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showContextMenu(
    BuildContext context, {
    required TableModel table,
    required Future<void> Function(int tableNumber) onCycleStatus,
    required Future<void> Function(int tableNumber) onLockOrUnlock,
    required Future<void> Function(int tableNumber) onTransfer,
    required bool isAdmin,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.refresh),
                title: const Text('Status weiter'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await onCycleStatus(table.tableNumber);
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Tisch sperren/entsperren'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await onLockOrUnlock(table.tableNumber);
                },
              ),
              if (isAdmin)
                ListTile(
                  leading: const Icon(Icons.swap_horiz),
                  title: const Text('Tisch transferieren'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await onTransfer(table.tableNumber);
                  },
                ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(
                    'Info: Tisch ${table.tableNumber}, Plätze ${table.seats}'),
                subtitle: Text('Status: ${table.status.name}'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TableNode extends StatelessWidget {
  const _TableNode({
    super.key,
    required this.table,
    required this.canvasSize,
    required this.editMode,
    required this.onMove,
    required this.onTap,
    required this.onLongPress,
  });

  final TableModel table;
  final Size canvasSize;
  final bool editMode;
  final Future<void> Function(int tableNumber, double nextX, double nextY)
      onMove;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    const size = 88.0;
    final left = table.posX * (canvasSize.width - size);
    final top = table.posY * (canvasSize.height - size);

    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        onPanUpdate: editMode
            ? (details) async {
                final nextX =
                    (left + details.delta.dx) / (canvasSize.width - size);
                final nextY =
                    (top + details.delta.dy) / (canvasSize.height - size);
                await onMove(table.tableNumber, nextX, nextY);
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: _statusColor(table.status),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white24),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('T${table.tableNumber}',
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text('${table.seats} Plätze',
                    style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _statusColor(TableStatus status) {
    switch (status) {
      case TableStatus.free:
        return Colors.green;
      case TableStatus.occupied:
        return Colors.yellow.shade700;
      case TableStatus.ordered:
        return Colors.red;
      case TableStatus.preparing:
        return Colors.blue;
      case TableStatus.ready:
        return Colors.orange;
      case TableStatus.payment:
        return Colors.purple;
    }
  }
}
