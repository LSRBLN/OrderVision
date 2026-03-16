import 'package:isar/isar.dart';

part 'menu_item_model.g.dart';

@Collection()
class MenuItemModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String itemId;

  late String categoryId;
  late String name;
  late double price;
  double? happyHourPrice;
  double? premiumPrice;
  String priceLevels = '';
  String allergens = '';
  bool discountEligible = true;
  bool isActive = true;
  int autoDiscountThreshold = 0;
  double autoDiscountPercent = 0;
  int sortOrder = 0;
}
