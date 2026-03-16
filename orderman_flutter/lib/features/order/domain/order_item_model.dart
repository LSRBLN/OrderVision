import 'package:isar/isar.dart';

part 'order_item_model.g.dart';

@Collection()
class OrderItemModel {
  Id id = Isar.autoIncrement;

  late String menuItemId;
  late String name;
  late double price;
  late int quantity;
  int? seatNumber;
  String? note;
  double manualDiscountPercent = 0;
  double autoDiscountPercent = 0;
  bool isVoided = false;
  String? voidReason;
  String? voidNote;

  bool isPrinted = false;
}
