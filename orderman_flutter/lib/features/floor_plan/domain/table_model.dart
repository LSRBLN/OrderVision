import 'package:isar/isar.dart';
import 'package:orderman_flutter/features/order/domain/order_model.dart';

part 'table_model.g.dart';

@Collection()
class TableModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late int tableNumber;

  late double posX;
  late double posY;
  late int seats;

  @Enumerated(EnumType.name)
  late TableStatus status;

  String? assignedWaiterId;
  DateTime? openedAt;

  final orders = IsarLinks<OrderModel>();
}

enum TableStatus {
  free,
  occupied,
  ordered,
  preparing,
  ready,
  payment,
}