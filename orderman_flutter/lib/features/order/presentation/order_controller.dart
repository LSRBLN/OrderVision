import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';
import 'package:orderman_flutter/features/order/data/menu_repository.dart';
import 'package:orderman_flutter/features/order/data/order_repository.dart';
import 'package:orderman_flutter/features/order/domain/menu_item.dart';
import 'package:orderman_flutter/features/printer/domain/printer_service.dart';
import 'package:orderman_flutter/features/printer/presentation/printer_providers.dart';

class CartItem {
  const CartItem({
    required this.menuItem,
    required this.quantity,
    this.seatNumber,
    this.note,
    this.manualDiscountPercent = 0,
    this.autoDiscountPercent = 0,
    this.isVoided = false,
    this.voidReason,
    this.voidNote,
    this.priceLevel = 'normal',
  });

  final MenuItem menuItem;
  final int quantity;
  final int? seatNumber;
  final String? note;
  final double manualDiscountPercent;
  final double autoDiscountPercent;
  final bool isVoided;
  final StornoReason? voidReason;
  final String? voidNote;
  final String priceLevel;

  double get effectiveDiscountPercent =>
      manualDiscountPercent > autoDiscountPercent
          ? manualDiscountPercent
          : autoDiscountPercent;

  double get grossLineTotal => menuItem.priceForLevel(priceLevel) * quantity;

  double get discountAmount =>
      grossLineTotal * (effectiveDiscountPercent / 100);

  double get lineTotal => isVoided ? 0 : grossLineTotal - discountAmount;

  CartItem copyWith({
    int? quantity,
    int? seatNumber,
    String? note,
    bool clearSeat = false,
    bool clearNote = false,
    double? manualDiscountPercent,
    double? autoDiscountPercent,
    bool? isVoided,
    StornoReason? voidReason,
    String? voidNote,
    String? priceLevel,
    bool clearVoidReason = false,
    bool clearVoidNote = false,
  }) {
    return CartItem(
      menuItem: menuItem,
      quantity: quantity ?? this.quantity,
      seatNumber: clearSeat ? null : (seatNumber ?? this.seatNumber),
      note: clearNote ? null : (note ?? this.note),
      manualDiscountPercent:
          manualDiscountPercent ?? this.manualDiscountPercent,
      autoDiscountPercent: autoDiscountPercent ?? this.autoDiscountPercent,
      isVoided: isVoided ?? this.isVoided,
      voidReason: clearVoidReason ? null : (voidReason ?? this.voidReason),
      voidNote: clearVoidNote ? null : (voidNote ?? this.voidNote),
      priceLevel: priceLevel ?? this.priceLevel,
    );
  }
}

enum StornoReason {
  falschBestellt,
  gastStorniert,
  kueche,
  sonstiges,
}

class OrderState {
  const OrderState({
    required this.tableNumber,
    required this.categories,
    required this.selectedCategory,
    required this.menuItems,
    this.activeSeat = 1,
    this.items = const <CartItem>[],
    this.selectedCartIndex,
    this.orderDiscountPercent = 0,
  });

  final int tableNumber;
  final List<String> categories;
  final String selectedCategory;
  final List<MenuItem> menuItems;
  final int activeSeat;
  final List<CartItem> items;
  final int? selectedCartIndex;
  final double orderDiscountPercent;

  double get subtotal => items.fold(0, (sum, item) => sum + item.lineTotal);

  double get orderDiscountAmount => subtotal * (orderDiscountPercent / 100);

  double get total => subtotal - orderDiscountAmount;

  OrderState copyWith({
    List<String>? categories,
    String? selectedCategory,
    List<MenuItem>? menuItems,
    int? activeSeat,
    List<CartItem>? items,
    int? selectedCartIndex,
    double? orderDiscountPercent,
    bool clearSelected = false,
  }) {
    return OrderState(
      tableNumber: tableNumber,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      menuItems: menuItems ?? this.menuItems,
      activeSeat: activeSeat ?? this.activeSeat,
      items: items ?? this.items,
      orderDiscountPercent: orderDiscountPercent ?? this.orderDiscountPercent,
      selectedCartIndex:
          clearSelected ? null : (selectedCartIndex ?? this.selectedCartIndex),
    );
  }
}

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  if (IsarService.instance.isReady) {
    return IsarMenuRepository(IsarService.instance);
  }
  return const InMemoryMenuRepository();
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  if (IsarService.instance.isReady) {
    return IsarOrderRepository(IsarService.instance);
  }
  return InMemoryOrderRepository();
});

final orderControllerProvider =
    NotifierProvider.family<OrderController, OrderState, int>(
  OrderController.new,
);

class OrderController extends FamilyNotifier<OrderState, int> {
  @override
  OrderState build(int arg) {
    const defaultCategories = kDefaultMenuCategories;
    final defaultSelected = defaultCategories.first;
    Future<void>.microtask(_loadMenu);
    Future<void>.microtask(_restorePersistedCart);
    return OrderState(
      tableNumber: arg,
      categories: defaultCategories,
      selectedCategory: defaultSelected,
      menuItems: defaultMenuItemsForCategory(defaultSelected),
    );
  }

  Future<void> _loadMenu() async {
    final repo = ref.read(menuRepositoryProvider);
    final categories = await repo.categories();
    final selected = categories.isEmpty ? '' : categories.first;
    final items = selected.isEmpty
        ? const <MenuItem>[]
        : await repo.itemsForCategory(selected);
    state = state.copyWith(
      categories: categories,
      selectedCategory: selected,
      menuItems: items,
    );
  }

  Future<void> _restorePersistedCart() async {
    if (state.items.isNotEmpty) {
      return;
    }
    final persisted =
        await ref.read(orderRepositoryProvider).loadCartItemsForTable(arg);
    if (persisted.isEmpty) {
      return;
    }
    state = state.copyWith(items: persisted);
  }

  Future<void> selectCategory(String category) async {
    final repo = ref.read(menuRepositoryProvider);
    state = state.copyWith(
      selectedCategory: category,
      menuItems: await repo.itemsForCategory(category),
    );
  }

  void addItem(MenuItem item) {
    final index = state.items.indexWhere(
        (entry) => entry.menuItem.id == item.id && entry.note == null);
    if (index == -1) {
      state = state.copyWith(items: [
        ...state.items,
        CartItem(
          menuItem: item,
          quantity: 1,
          seatNumber: state.activeSeat,
          priceLevel: 'normal',
        ),
      ]);
      _persistCart();
      return;
    }

    final updated = state.items[index].copyWith(
      quantity: state.items[index].quantity + 1,
      autoDiscountPercent: _calculateAutoDiscount(
        item,
        state.items[index].quantity + 1,
      ),
    );
    final next = [...state.items]..[index] = updated;
    state = state.copyWith(items: next);
    _persistCart();
  }

  void selectCartIndex(int index) {
    if (index < 0 || index >= state.items.length) {
      state = state.copyWith(clearSelected: true);
      return;
    }
    state = state.copyWith(selectedCartIndex: index);
  }

  void setActiveSeat(int seatNumber) {
    state = state.copyWith(activeSeat: seatNumber.clamp(1, 20));
  }

  void assignSelectedItemToActiveSeat() {
    final selected = state.selectedCartIndex;
    if (selected == null || selected < 0 || selected >= state.items.length) {
      return;
    }

    final updated =
        state.items[selected].copyWith(seatNumber: state.activeSeat);
    final next = [...state.items]..[selected] = updated;
    state = state.copyWith(items: next);
    _persistCart();
  }

  void removeSelectedItem() {
    final selected = state.selectedCartIndex;
    if (selected == null || selected < 0 || selected >= state.items.length) {
      return;
    }

    final next = [...state.items]..removeAt(selected);
    state = state.copyWith(items: next, clearSelected: true);
    _persistCart();
  }

  void increaseSelectedQuantity() {
    final selected = state.selectedCartIndex;
    if (selected == null || selected < 0 || selected >= state.items.length) {
      return;
    }

    final nextQuantity = state.items[selected].quantity + 1;
    final updated = state.items[selected].copyWith(
      quantity: nextQuantity,
      autoDiscountPercent:
          _calculateAutoDiscount(state.items[selected].menuItem, nextQuantity),
    );
    final next = [...state.items]..[selected] = updated;
    state = state.copyWith(items: next);
    _persistCart();
  }

  void decreaseSelectedQuantity() {
    final selected = state.selectedCartIndex;
    if (selected == null || selected < 0 || selected >= state.items.length) {
      return;
    }

    final current = state.items[selected];
    if (current.quantity <= 1) {
      final next = [...state.items]..removeAt(selected);
      state = state.copyWith(items: next, clearSelected: true);
      _persistCart();
      return;
    }

    final nextQuantity = current.quantity - 1;
    final updated = current.copyWith(
      quantity: nextQuantity,
      autoDiscountPercent:
          _calculateAutoDiscount(current.menuItem, nextQuantity),
    );
    final next = [...state.items]..[selected] = updated;
    state = state.copyWith(items: next);
    _persistCart();
  }

  void multiplySelectedQuantity(int factor) {
    final selected = state.selectedCartIndex;
    if (factor <= 1) {
      return;
    }
    if (selected == null || selected < 0 || selected >= state.items.length) {
      return;
    }

    final current = state.items[selected];
    final updated = current.copyWith(quantity: current.quantity * factor);
    final next = [...state.items]..[selected] = updated;
    state = state.copyWith(items: next);
    _persistCart();
  }

  void applyModifierToSelected(String note) {
    final selected = state.selectedCartIndex;
    if (selected == null || selected < 0 || selected >= state.items.length) {
      return;
    }

    final trimmed = note.trim();
    final updated = state.items[selected].copyWith(
      note: trimmed,
      clearNote: trimmed.isEmpty,
    );
    final next = [...state.items]..[selected] = updated;
    state = state.copyWith(items: next);
    _persistCart();
  }

  void applyDiscountToSelected(double percent) {
    final selected = state.selectedCartIndex;
    if (selected == null || selected < 0 || selected >= state.items.length) {
      return;
    }

    final updated = state.items[selected].copyWith(
      manualDiscountPercent: percent.clamp(0, 100),
    );
    final next = [...state.items]..[selected] = updated;
    state = state.copyWith(items: next);
    _persistCart();
  }

  void applyOrderDiscount(double percent) {
    state = state.copyWith(orderDiscountPercent: percent.clamp(0, 100));
    _persistCart();
  }

  void applyPriceLevelToSelected(String level) {
    final selected = state.selectedCartIndex;
    if (selected == null || selected < 0 || selected >= state.items.length) {
      return;
    }
    final updated = state.items[selected].copyWith(priceLevel: level);
    final next = [...state.items]..[selected] = updated;
    state = state.copyWith(items: next);
    _persistCart();
  }

  void voidSelectedItem({
    required StornoReason reason,
    String? note,
  }) {
    final selected = state.selectedCartIndex;
    if (selected == null || selected < 0 || selected >= state.items.length) {
      return;
    }

    final updated = state.items[selected].copyWith(
      isVoided: true,
      voidReason: reason,
      voidNote: note?.trim(),
    );
    final next = [...state.items]..[selected] = updated;
    state = state.copyWith(items: next);
    _persistCart();
  }

  Future<PrintResult> sendToKitchen({String? waiterName}) async {
    if (state.items.isEmpty) {
      return const PrintResult.failure(
        failure: PrinterFailure.unknown,
        message: 'Keine Positionen zum Senden',
      );
    }

    final printerService = ref.read(printerServiceProvider);
    final ticket = KitchenTicketData(
      tableNumber: state.tableNumber,
      waiterName: waiterName,
      items: state.items
          .map(
            (item) => KitchenTicketItem(
              quantity: item.quantity,
              name: item.menuItem.name,
              note: item.note,
              discountLabel: item.effectiveDiscountPercent > 0
                  ? '${item.effectiveDiscountPercent.toStringAsFixed(0)}% Rabatt'
                  : null,
              voidLabel: item.isVoided
                  ? '${item.voidReason?.name ?? 'storno'} ${item.voidNote ?? ''}'
                      .trim()
                  : null,
            ),
          )
          .toList(growable: false),
    );

    final result = await printerService.printKitchenTicket(ticket);
    if (!result.success) {
      return result;
    }

    state = state.copyWith(items: const [], clearSelected: true);
    await _persistCart();
    return result;
  }

  Future<void> _persistCart() {
    return ref.read(orderRepositoryProvider).saveCartItems(
          tableNumber: state.tableNumber,
          waiterId: 'active-user',
          items: state.items,
        );
  }

  GuestReceiptData buildGuestReceiptData({
    String? waiterName,
    double tipAmount = 0,
  }) {
    return GuestReceiptData(
      tableNumber: state.tableNumber,
      waiterName: waiterName,
      totalAmount: state.total + tipAmount,
      tipAmount: tipAmount,
      items: state.items
          .map(
            (item) => GuestReceiptItem(
              quantity: item.quantity,
              name: item.isVoided
                  ? '${item.menuItem.name} (STORNO)'
                  : item.menuItem.name,
              unitPrice: item.menuItem.priceForLevel(item.priceLevel),
              totalPrice: item.lineTotal,
              discountLabel: item.effectiveDiscountPercent > 0
                  ? '${item.effectiveDiscountPercent.toStringAsFixed(0)}% Rabatt'
                  : null,
              voidLabel: item.isVoided
                  ? '${item.voidReason?.name ?? 'storno'} ${item.voidNote ?? ''}'
                      .trim()
                  : null,
            ),
          )
          .toList(growable: false),
      orderDiscountLabel: state.orderDiscountPercent > 0
          ? '${state.orderDiscountPercent.toStringAsFixed(0)}% Gesamtrabatt'
          : null,
    );
  }

  double _calculateAutoDiscount(MenuItem item, int quantity) {
    if (!item.discountEligible) {
      return 0;
    }
    if (item.autoDiscountThreshold <= 0) {
      return 0;
    }
    return quantity >= item.autoDiscountThreshold
        ? item.autoDiscountPercent
        : 0;
  }
}
