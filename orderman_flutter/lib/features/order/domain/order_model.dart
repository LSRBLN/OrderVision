import 'package:isar/isar.dart';
import 'package:orderman_flutter/features/order/domain/order_item_model.dart';

part 'order_model.g.dart';

@Collection()
class OrderModel {
  Id id = Isar.autoIncrement;

  late int tableId;
  late String waiterId;
  late DateTime createdAt;

  @Enumerated(EnumType.name)
  OrderStatus status = OrderStatus.open;

  double totalAmount = 0.0;
  double tipAmount = 0.0;

  final items = IsarLinks<OrderItemModel>();
}

enum OrderStatus { open }
