import 'package:isar/isar.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';
import 'package:orderman_flutter/features/menu/data/menu_category_model.dart';
import 'package:orderman_flutter/features/menu/data/menu_item_model.dart';
import 'package:orderman_flutter/features/order/domain/menu_item.dart';

const List<String> kDefaultMenuCategories = <String>[
  'Getränke',
  'Speisen',
  'Dessert',
];

List<MenuItem> defaultMenuItemsForCategory(String category) {
  switch (category) {
    case 'Getränke':
      return const [
        MenuItem(id: 'cola', name: 'Cola', price: 3.00, category: 'Getränke'),
        MenuItem(id: 'fanta', name: 'Fanta', price: 3.00, category: 'Getränke'),
        MenuItem(
            id: 'wasser', name: 'Wasser', price: 2.50, category: 'Getränke'),
        MenuItem(id: 'bier', name: 'Bier', price: 4.20, category: 'Getränke'),
      ];
    case 'Speisen':
      return const [
        MenuItem(
            id: 'schnitzel',
            name: 'Schnitzel',
            price: 14.50,
            category: 'Speisen'),
        MenuItem(
          id: 'burger',
          name: 'Burger',
          price: 13.90,
          category: 'Speisen',
          autoDiscountThreshold: 3,
          autoDiscountPercent: 10,
        ),
        MenuItem(id: 'salat', name: 'Salat', price: 10.80, category: 'Speisen'),
        MenuItem(id: 'pasta', name: 'Pasta', price: 12.40, category: 'Speisen'),
      ];
    case 'Dessert':
      return const [
        MenuItem(
            id: 'tiramisu', name: 'Tiramisu', price: 6.90, category: 'Dessert'),
        MenuItem(
            id: 'eis',
            name: 'Gemischtes Eis',
            price: 5.20,
            category: 'Dessert'),
        MenuItem(
            id: 'kuchen', name: 'Kuchen', price: 4.80, category: 'Dessert'),
      ];
    default:
      return const <MenuItem>[];
  }
}

abstract class MenuRepository {
  Future<List<String>> categories();
  Future<List<MenuItem>> itemsForCategory(String category);
  Future<List<MenuCategoryModel>> loadCategoryModels();
  Future<List<MenuItem>> loadAllItems();
  Future<void> saveCategory(MenuCategoryModel category);
  Future<void> reorderCategories(List<MenuCategoryModel> categories);
  Future<void> saveMenuItem(MenuItem item);
  Future<void> reorderMenuItems(List<MenuItem> items);
  Future<void> setMenuItemActive(String itemId, bool isActive);
}

class IsarMenuRepository implements MenuRepository {
  IsarMenuRepository(this._isarService);

  final IsarService _isarService;

  @override
  Future<List<String>> categories() async {
    await _ensureSeedData();
    final db = _isarService.isar;
    final categories =
        await db.menuCategoryModels.where().sortBySortOrder().findAll();
    return categories
        .where((item) => item.isActive)
        .map((item) => item.name)
        .toList(growable: false);
  }

  @override
  Future<List<MenuItem>> itemsForCategory(String category) async {
    await _ensureSeedData();
    final db = _isarService.isar;
    final categories =
        await db.menuCategoryModels.filter().nameEqualTo(category).findAll();
    if (categories.isEmpty) {
      return const <MenuItem>[];
    }
    final categoryId = categories.first.categoryId;
    final items = await db.menuItemModels
        .filter()
        .categoryIdEqualTo(categoryId)
        .findAll();
    items.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return items
        .where((item) => item.isActive)
        .map(_mapItem)
        .toList(growable: false);
  }

  @override
  Future<List<MenuCategoryModel>> loadCategoryModels() async {
    await _ensureSeedData();
    final db = _isarService.isar;
    final items =
        await db.menuCategoryModels.where().sortBySortOrder().findAll();
    return items.toList(growable: false);
  }

  @override
  Future<List<MenuItem>> loadAllItems() async {
    await _ensureSeedData();
    final db = _isarService.isar;
    final items = await db.menuItemModels.where().sortBySortOrder().findAll();
    return items.map(_mapItem).toList(growable: false);
  }

  @override
  Future<void> reorderCategories(List<MenuCategoryModel> categories) async {
    final db = _isarService.isar;
    await db.writeTxn(() async {
      for (var i = 0; i < categories.length; i++) {
        categories[i].sortOrder = i;
      }
      await db.menuCategoryModels.putAll(categories);
    });
  }

  @override
  Future<void> saveCategory(MenuCategoryModel category) async {
    final db = _isarService.isar;
    await db.writeTxn(() async {
      await db.menuCategoryModels.put(category);
    });
  }

  @override
  Future<void> saveMenuItem(MenuItem item) async {
    final db = _isarService.isar;
    final category = await db.menuCategoryModels
        .filter()
        .nameEqualTo(item.category)
        .findAll();
    if (category.isEmpty) {
      throw StateError('Category ${item.category} not found');
    }
    final existing = await db.menuItemModels.getByItemId(item.id);
    final model = MenuItemModel()
      ..itemId = item.id
      ..categoryId = category.first.categoryId
      ..name = item.name
      ..price = item.price
      ..happyHourPrice = item.happyHourPrice
      ..premiumPrice = item.premiumPrice
      ..priceLevels = _encodePriceLevels(item.priceLevels)
      ..allergens = item.allergens.join(',')
      ..discountEligible = item.discountEligible
      ..isActive = item.isActive
      ..autoDiscountThreshold = item.autoDiscountThreshold
      ..autoDiscountPercent = item.autoDiscountPercent
      ..sortOrder = existing?.sortOrder ?? item.sortOrder;
    if (existing != null) {
      model.id = existing.id;
    }
    await db.writeTxn(() async {
      await db.menuItemModels.put(model);
    });
  }

  @override
  Future<void> reorderMenuItems(List<MenuItem> items) async {
    final db = _isarService.isar;
    final existingItems = await db.menuItemModels.where().findAll();
    final itemsByItemId = <String, MenuItemModel>{
      for (final item in existingItems) item.itemId: item,
    };

    await db.writeTxn(() async {
      for (var index = 0; index < items.length; index++) {
        final model = itemsByItemId[items[index].id];
        if (model == null) {
          continue;
        }
        model.sortOrder = index;
        await db.menuItemModels.put(model);
      }
    });
  }

  @override
  Future<void> setMenuItemActive(String itemId, bool isActive) async {
    final db = _isarService.isar;
    final existing = await db.menuItemModels.getByItemId(itemId);
    if (existing == null) {
      return;
    }
    existing.isActive = isActive;
    await db.writeTxn(() async {
      await db.menuItemModels.put(existing);
    });
  }

  Future<void> _ensureSeedData() async {
    final db = _isarService.isar;
    final existingCategories =
        await db.menuCategoryModels.where().anyId().findAll();
    if (existingCategories.isNotEmpty) {
      return;
    }

    final categories = <MenuCategoryModel>[
      MenuCategoryModel()
        ..categoryId = 'drinks'
        ..name = 'Getränke'
        ..sortOrder = 0,
      MenuCategoryModel()
        ..categoryId = 'food'
        ..name = 'Speisen'
        ..sortOrder = 1,
      MenuCategoryModel()
        ..categoryId = 'dessert'
        ..name = 'Dessert'
        ..sortOrder = 2,
    ];

    final items = <MenuItemModel>[
      MenuItemModel()
        ..itemId = 'cola'
        ..categoryId = 'drinks'
        ..name = 'Cola'
        ..price = 3.00
        ..priceLevels = 'normal:3.0;happyhour:2.5;staff:2.0'
        ..allergens = 'caffeine'
        ..sortOrder = 0,
      MenuItemModel()
        ..itemId = 'bier'
        ..categoryId = 'drinks'
        ..name = 'Bier'
        ..price = 4.20
        ..priceLevels = 'normal:4.2;happyhour:3.8;staff:3.5'
        ..sortOrder = 1,
      MenuItemModel()
        ..itemId = 'burger'
        ..categoryId = 'food'
        ..name = 'Burger'
        ..price = 13.90
        ..priceLevels = 'normal:13.9;happyhour:11.9;staff:9.9'
        ..autoDiscountThreshold = 3
        ..autoDiscountPercent = 10
        ..sortOrder = 0,
      MenuItemModel()
        ..itemId = 'schnitzel'
        ..categoryId = 'food'
        ..name = 'Schnitzel'
        ..price = 14.50
        ..priceLevels = 'normal:14.5;staff:12.0'
        ..sortOrder = 1,
      MenuItemModel()
        ..itemId = 'tiramisu'
        ..categoryId = 'dessert'
        ..name = 'Tiramisu'
        ..price = 6.90
        ..priceLevels = 'normal:6.9;staff:5.9'
        ..sortOrder = 0,
    ];

    await db.writeTxn(() async {
      await db.menuCategoryModels.putAll(categories);
      await db.menuItemModels.putAll(items);
    });
  }

  MenuItem _mapItem(MenuItemModel item) {
    final categoryName = _categoryNameFromId(item.categoryId);

    return MenuItem(
      id: item.itemId,
      name: item.name,
      price: item.price,
      category: categoryName,
      sortOrder: item.sortOrder,
      happyHourPrice: item.happyHourPrice,
      premiumPrice: item.premiumPrice,
      allergens:
          item.allergens.isEmpty ? const <String>[] : item.allergens.split(','),
      discountEligible: item.discountEligible,
      isActive: item.isActive,
      autoDiscountThreshold: item.autoDiscountThreshold,
      autoDiscountPercent: item.autoDiscountPercent,
      priceLevels: _decodePriceLevels(item.priceLevels),
    );
  }

  String _categoryNameFromId(String categoryId) {
    switch (categoryId) {
      case 'drinks':
        return 'Getränke';
      case 'food':
        return 'Speisen';
      case 'dessert':
        return 'Dessert';
      default:
        return categoryId;
    }
  }

  Map<String, double> _decodePriceLevels(String value) {
    if (value.trim().isEmpty) {
      return const <String, double>{};
    }
    final map = <String, double>{};
    for (final pair in value.split(';')) {
      final parts = pair.split(':');
      if (parts.length != 2) {
        continue;
      }
      final parsed = double.tryParse(parts[1]);
      if (parsed == null) {
        continue;
      }
      map[parts[0]] = parsed;
    }
    return map;
  }

  String _encodePriceLevels(Map<String, double> value) {
    if (value.isEmpty) {
      return '';
    }
    return value.entries
        .map((entry) => '${entry.key}:${entry.value}')
        .join(';');
  }
}

class InMemoryMenuRepository implements MenuRepository {
  const InMemoryMenuRepository();

  @override
  Future<List<String>> categories() async {
    return kDefaultMenuCategories;
  }

  @override
  Future<List<MenuItem>> itemsForCategory(String category) async {
    return defaultMenuItemsForCategory(category);
  }

  @override
  Future<List<MenuCategoryModel>> loadCategoryModels() async {
    return <MenuCategoryModel>[
      MenuCategoryModel()
        ..categoryId = 'drinks'
        ..name = 'Getränke'
        ..sortOrder = 0,
      MenuCategoryModel()
        ..categoryId = 'food'
        ..name = 'Speisen'
        ..sortOrder = 1,
      MenuCategoryModel()
        ..categoryId = 'dessert'
        ..name = 'Dessert'
        ..sortOrder = 2,
    ];
  }

  @override
  Future<List<MenuItem>> loadAllItems() async {
    final result = <MenuItem>[];
    for (final category in await categories()) {
      result.addAll(await itemsForCategory(category));
    }
    return result;
  }

  @override
  Future<void> reorderCategories(List<MenuCategoryModel> categories) async {}

  @override
  Future<void> saveCategory(MenuCategoryModel category) async {}

  @override
  Future<void> saveMenuItem(MenuItem item) async {}

  @override
  Future<void> reorderMenuItems(List<MenuItem> items) async {}

  @override
  Future<void> setMenuItemActive(String itemId, bool isActive) async {}
}
