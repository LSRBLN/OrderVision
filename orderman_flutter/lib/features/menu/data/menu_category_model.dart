import 'package:isar/isar.dart';

part 'menu_category_model.g.dart';

@Collection()
class MenuCategoryModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String categoryId;

  late String name;
  int sortOrder = 0;
  bool isActive = true;
}
