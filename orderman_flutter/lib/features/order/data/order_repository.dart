import 'package:isar/isar.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';
import 'package:orderman_flutter/features/order/domain/menu_item.dart';
import 'package:orderman_flutter/features/order/domain/order_item_model.dart';
import 'package:orderman_flutter/features/order/domain/order_model.dart';
import 'package:orderman_flutter/features/order/presentation/order_controller.dart';

abstract class OrderRepository {
  Future<List<CartItem>> loadCartItemsForTable(int tableNumber);
  Future<void> saveCartItems({
    required int tableNumber,
    required String waiterId,
    required List<CartItem> items,
  });
}

class IsarOrderRepository implements OrderRepository {
  IsarOrderRepository(this._isarService);

  final IsarService _isarService;

  @override
  Future<List<CartItem>> loadCartItemsForTable(int tableNumber) async {
    final db = _isarService.isar;
    final orders =
        await db.orderModels.filter().tableIdEqualTo(tableNumber).findAll();
    final order = orders.isEmpty ? null : orders.first;
    if (order == null) {
      return const <CartItem>[];
    }

    await order.items.load();
    return order.items
        .map(
          (item) => CartItem(
            menuItem: item.toMenuItem(),
            quantity: item.quantity,
            seatNumber: item.seatNumber,
            note: item.note,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> saveCartItems({
    required int tableNumber,
    required String waiterId,
    required List<CartItem> items,
  }) async {
    final db = _isarService.isar;
    final orders =
        await db.orderModels.filter().tableIdEqualTo(tableNumber).findAll();
    final existing = orders.isEmpty ? null : orders.first;

    await db.writeTxn(() async {
      if (existing != null) {
        await existing.items.load();
        await db.orderItemModels
            .deleteAll(existing.items.map((item) => item.id).toList());
        existing.items.clear();
      }

      final order = existing ?? OrderModel();
      order.tableId = tableNumber;
      order.waiterId = waiterId;
      order.createdAt = existing?.createdAt ?? DateTime.now();
      order.totalAmount =
          items.fold<double>(0, (sum, item) => sum + item.lineTotal);

      final itemModels = items
          .map(
            (item) => OrderItemModel()
              ..name = item.menuItem.name
              ..price = item.menuItem.price
              ..quantity = item.quantity
              ..seatNumber = item.seatNumber
              ..note = item.note
              ..isPrinted = false,
          )
          .toList();

      await db.orderItemModels.putAll(itemModels);
      order.items.addAll(itemModels);
      await db.orderModels.put(order);
      await order.items.save();
    });
  }
}

class InMemoryOrderRepository implements OrderRepository {
  final Map<int, List<CartItem>> _storage = <int, List<CartItem>>{};

  @override
  Future<List<CartItem>> loadCartItemsForTable(int tableNumber) async {
    return List<CartItem>.from(_storage[tableNumber] ?? const <CartItem>[]);
  }

  @override
  Future<void> saveCartItems({
    required int tableNumber,
    required String waiterId,
    required List<CartItem> items,
  }) async {
    _storage[tableNumber] = List<CartItem>.from(items);
  }
}

extension on OrderItemModel {
  MenuItem toMenuItem() {
    return MenuItem(
      id: '${name}_${price.toStringAsFixed(2)}',
      name: name,
      price: price,
      category: 'Persisted',
    );
  }
}
