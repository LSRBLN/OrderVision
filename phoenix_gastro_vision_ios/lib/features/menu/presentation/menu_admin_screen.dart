import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/features/menu/data/menu_category_model.dart';
import 'package:orderman_flutter/features/order/domain/menu_item.dart';
import 'package:orderman_flutter/features/order/presentation/order_controller.dart';

class MenuAdminState {
  const MenuAdminState({
    this.isLoading = true,
    this.categories = const <MenuCategoryModel>[],
    this.items = const <MenuItem>[],
    this.message,
  });

  final bool isLoading;
  final List<MenuCategoryModel> categories;
  final List<MenuItem> items;
  final String? message;

  MenuAdminState copyWith({
    bool? isLoading,
    List<MenuCategoryModel>? categories,
    List<MenuItem>? items,
    String? message,
    bool clearMessage = false,
  }) {
    return MenuAdminState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      items: items ?? this.items,
      message: clearMessage ? null : (message ?? this.message),
    );
  }
}

final menuAdminControllerProvider =
    NotifierProvider<MenuAdminController, MenuAdminState>(
  MenuAdminController.new,
);

class MenuAdminController extends Notifier<MenuAdminState> {
  bool _hasLoadedOnce = false;

  @override
  MenuAdminState build() {
    if (!_hasLoadedOnce) {
      _hasLoadedOnce = true;
      Future<void>.microtask(load);
    }

    return const MenuAdminState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearMessage: true);
    final repo = ref.read(menuRepositoryProvider);
    final categories = await repo.loadCategoryModels();
    final items = await repo.loadAllItems();
    state = state.copyWith(
      isLoading: false,
      categories: categories,
      items: items,
    );
  }

  Future<void> saveCategory({
    required String categoryId,
    required String name,
    required int sortOrder,
    required bool isActive,
  }) async {
    final category = MenuCategoryModel()
      ..categoryId = categoryId
      ..name = name
      ..sortOrder = sortOrder
      ..isActive = isActive;
    await ref.read(menuRepositoryProvider).saveCategory(category);
    await load();
    state = state.copyWith(message: 'Kategorie gespeichert.');
  }

  Future<void> saveItem(MenuItem item) async {
    await ref.read(menuRepositoryProvider).saveMenuItem(item);
    await load();
    state = state.copyWith(message: 'Menüartikel gespeichert.');
  }

  Future<void> toggleItemActive(MenuItem item) async {
    await ref
        .read(menuRepositoryProvider)
        .setMenuItemActive(item.id, !item.isActive);
    await load();
    state = state.copyWith(message: 'Artikelstatus aktualisiert.');
  }

  Future<void> moveCategory(int oldIndex, int newIndex) async {
    final categories = [...state.categories];
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = categories.removeAt(oldIndex);
    categories.insert(newIndex, item);
    await ref.read(menuRepositoryProvider).reorderCategories(categories);
    await load();
  }

  Future<void> moveItem(int oldIndex, int newIndex) async {
    final items = [...state.items];
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);

    final reorderedItems = <MenuItem>[
      for (var i = 0; i < items.length; i++) items[i].copyWith(sortOrder: i),
    ];

    await ref.read(menuRepositoryProvider).reorderMenuItems(reorderedItems);
    await load();
  }
}

class MenuAdminScreen extends ConsumerWidget {
  const MenuAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(menuAdminControllerProvider);
    final controller = ref.read(menuAdminControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Menü verwalten')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showItemEditor(context, controller),
        icon: const Icon(Icons.add),
        label: const Text('Artikel hinzufügen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (state.message != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MaterialBanner(
                  content: Text(state.message!),
                  actions: const [SizedBox.shrink()],
                ),
              ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ReorderableListView.builder(
                              padding: const EdgeInsets.all(12),
                              itemCount: state.categories.length,
                              onReorder: controller.moveCategory,
                              itemBuilder: (context, index) {
                                final category = state.categories[index];
                                return ListTile(
                                  key: ValueKey(category.categoryId),
                                  title: Text(category.name),
                                  subtitle:
                                      Text('Sortierung: ${category.sortOrder}'),
                                  trailing: IconButton(
                                    onPressed: () => _showCategoryEditor(
                                      context,
                                      controller,
                                      category: category,
                                    ),
                                    icon: const Icon(Icons.edit_outlined),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Card(
                      child: state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ReorderableListView.builder(
                              padding: const EdgeInsets.all(12),
                              itemCount: state.items.length,
                              onReorder: controller.moveItem,
                              itemBuilder: (context, index) {
                                final item = state.items[index];
                                return ListTile(
                                  key: ValueKey(item.id),
                                  title: Text(item.name),
                                  subtitle: Text(
                                    '${item.category} • ${item.price.toStringAsFixed(2)} € • Rabatt: ${item.discountEligible ? 'Ja' : 'Nein'} • Preisstufen: ${item.priceLevels.keys.join(', ')}',
                                  ),
                                  trailing: Wrap(
                                    spacing: 8,
                                    children: [
                                      IconButton(
                                        onPressed: () => _showItemEditor(
                                          context,
                                          controller,
                                          item: item,
                                        ),
                                        icon: const Icon(Icons.edit_outlined),
                                      ),
                                      Switch(
                                        value: item.isActive,
                                        onChanged: (_) =>
                                            controller.toggleItemActive(item),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCategoryEditor(
    BuildContext context,
    MenuAdminController controller, {
    MenuCategoryModel? category,
  }) async {
    final idController =
        TextEditingController(text: category?.categoryId ?? '');
    final nameController = TextEditingController(text: category?.name ?? '');
    final sortController = TextEditingController(
      text: (category?.sortOrder ?? 0).toString(),
    );
    var isActive = category?.isActive ?? true;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(category == null
                  ? 'Kategorie anlegen'
                  : 'Kategorie bearbeiten'),
              content: SizedBox(
                width: 420,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                        controller: idController,
                        decoration: const InputDecoration(labelText: 'ID')),
                    TextField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Name')),
                    TextField(
                        controller: sortController,
                        decoration:
                            const InputDecoration(labelText: 'Sortierung')),
                    SwitchListTile(
                      value: isActive,
                      onChanged: (value) => setState(() => isActive = value),
                      title: const Text('Aktiv'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Abbrechen'),
                ),
                FilledButton(
                  onPressed: () async {
                    await controller.saveCategory(
                      categoryId: idController.text.trim(),
                      name: nameController.text.trim(),
                      sortOrder: int.tryParse(sortController.text.trim()) ?? 0,
                      isActive: isActive,
                    );
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Speichern'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showItemEditor(
    BuildContext context,
    MenuAdminController controller, {
    MenuItem? item,
  }) async {
    final idController = TextEditingController(text: item?.id ?? '');
    final nameController = TextEditingController(text: item?.name ?? '');
    final categoryController =
        TextEditingController(text: item?.category ?? 'Getränke');
    final priceController = TextEditingController(
      text: item == null ? '0.00' : item.price.toStringAsFixed(2),
    );
    final allergenController =
        TextEditingController(text: item?.allergens.join(',') ?? '');
    final autoThresholdController = TextEditingController(
      text: (item?.autoDiscountThreshold ?? 0).toString(),
    );
    final autoDiscountController = TextEditingController(
      text: (item?.autoDiscountPercent ?? 0).toStringAsFixed(0),
    );
    final priceLevelsController = TextEditingController(
      text: item == null
          ? 'normal:0;happyhour:0;staff:0'
          : item.priceLevels.entries
              .map((entry) => '${entry.key}:${entry.value}')
              .join(';'),
    );
    var discountEligible = item?.discountEligible ?? true;
    var isActive = item?.isActive ?? true;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title:
                  Text(item == null ? 'Artikel anlegen' : 'Artikel bearbeiten'),
              content: SizedBox(
                width: 460,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                          controller: idController,
                          decoration: const InputDecoration(labelText: 'ID')),
                      TextField(
                          controller: nameController,
                          decoration: const InputDecoration(labelText: 'Name')),
                      TextField(
                          controller: categoryController,
                          decoration:
                              const InputDecoration(labelText: 'Kategorie')),
                      TextField(
                          controller: priceController,
                          decoration:
                              const InputDecoration(labelText: 'Preis')),
                      TextField(
                          controller: allergenController,
                          decoration: const InputDecoration(
                              labelText: 'Allergene (CSV)')),
                      TextField(
                          controller: autoThresholdController,
                          decoration: const InputDecoration(
                              labelText: 'Auto-Rabatt ab Menge')),
                      TextField(
                          controller: autoDiscountController,
                          decoration: const InputDecoration(
                              labelText: 'Auto-Rabatt %')),
                      TextField(
                          controller: priceLevelsController,
                          decoration: const InputDecoration(
                              labelText:
                                  'Preisstufen (z. B. normal:10;happyhour:8)')),
                      SwitchListTile(
                        value: discountEligible,
                        onChanged: (value) =>
                            setState(() => discountEligible = value),
                        title: const Text('Rabattfähig'),
                      ),
                      SwitchListTile(
                        value: isActive,
                        onChanged: (value) => setState(() => isActive = value),
                        title: const Text('Aktiv'),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Abbrechen'),
                ),
                FilledButton(
                  onPressed: () async {
                    await controller.saveItem(
                      MenuItem(
                        id: idController.text.trim(),
                        name: nameController.text.trim(),
                        price: double.tryParse(priceController.text
                                .trim()
                                .replaceAll(',', '.')) ??
                            0,
                        category: categoryController.text.trim(),
                        allergens: allergenController.text.trim().isEmpty
                            ? const <String>[]
                            : allergenController.text.trim().split(','),
                        discountEligible: discountEligible,
                        isActive: isActive,
                        autoDiscountThreshold:
                            int.tryParse(autoThresholdController.text.trim()) ??
                                0,
                        autoDiscountPercent: double.tryParse(
                                autoDiscountController.text
                                    .trim()
                                    .replaceAll(',', '.')) ??
                            0,
                        priceLevels:
                            _parsePriceLevels(priceLevelsController.text),
                      ),
                    );
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Speichern'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Map<String, double> _parsePriceLevels(String raw) {
    final result = <String, double>{};
    for (final pair in raw.split(';')) {
      final parts = pair.split(':');
      if (parts.length != 2) {
        continue;
      }
      final value = double.tryParse(parts[1].trim().replaceAll(',', '.'));
      if (value == null) {
        continue;
      }
      result[parts[0].trim()] = value;
    }
    return result;
  }
}
