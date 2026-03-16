import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orderman_flutter/features/order/presentation/order_controller.dart';
import 'package:orderman_flutter/features/printer/domain/printer_service.dart';
import 'package:orderman_flutter/features/printer/presentation/printer_providers.dart';

void main() {
  group('OrderController', () {
    test('initial state loads categories and menu items for first category',
        () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(orderControllerProvider(12));

      expect(state.tableNumber, 12);
      expect(state.categories, isNotEmpty);
      expect(state.selectedCategory, state.categories.first);
      expect(state.menuItems, isNotEmpty);
      expect(state.items, isEmpty);
      expect(state.total, 0);
    });

    test(
        'adding the same item twice increases quantity instead of duplicating row',
        () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(orderControllerProvider(8).notifier);
      final firstMenuItem =
          container.read(orderControllerProvider(8)).menuItems.first;

      notifier.addItem(firstMenuItem);
      notifier.addItem(firstMenuItem);

      final state = container.read(orderControllerProvider(8));
      expect(state.items.length, 1);
      expect(state.items.first.quantity, 2);
      expect(state.total, firstMenuItem.price * 2);
    });

    test('quantity +/- works on selected cart item', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(orderControllerProvider(3).notifier);
      final firstMenuItem =
          container.read(orderControllerProvider(3)).menuItems.first;

      notifier.addItem(firstMenuItem);
      notifier.selectCartIndex(0);

      notifier.increaseSelectedQuantity();
      expect(
        container.read(orderControllerProvider(3)).items.first.quantity,
        2,
      );

      notifier.decreaseSelectedQuantity();
      expect(
        container.read(orderControllerProvider(3)).items.first.quantity,
        1,
      );

      notifier.decreaseSelectedQuantity();
      final state = container.read(orderControllerProvider(3));
      expect(state.items, isEmpty);
      expect(state.selectedCartIndex, isNull);
    });

    test('modifier is applied to selected cart item', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(orderControllerProvider(5).notifier);
      final firstMenuItem =
          container.read(orderControllerProvider(5)).menuItems.first;

      notifier.addItem(firstMenuItem);
      notifier.selectCartIndex(0);
      notifier.applyModifierToSelected('Ohne Eis');

      final state = container.read(orderControllerProvider(5));
      expect(state.items.first.note, 'Ohne Eis');
    });

    test(
        'new cart items inherit active seat and selected items can be reassigned',
        () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(orderControllerProvider(6).notifier);
      final firstMenuItem =
          container.read(orderControllerProvider(6)).menuItems.first;

      notifier.setActiveSeat(3);
      notifier.addItem(firstMenuItem);

      var state = container.read(orderControllerProvider(6));
      expect(state.items.first.seatNumber, 3);

      notifier.selectCartIndex(0);
      notifier.setActiveSeat(5);
      notifier.assignSelectedItemToActiveSeat();

      state = container.read(orderControllerProvider(6));
      expect(state.items.first.seatNumber, 5);
    });

    test('multiplier x2 and x3 updates selected cart quantity', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(orderControllerProvider(9).notifier);
      final firstMenuItem =
          container.read(orderControllerProvider(9)).menuItems.first;

      notifier.addItem(firstMenuItem);
      notifier.selectCartIndex(0);

      notifier.multiplySelectedQuantity(2);
      expect(
        container.read(orderControllerProvider(9)).items.first.quantity,
        2,
      );

      notifier.multiplySelectedQuantity(3);
      final state = container.read(orderControllerProvider(9));
      expect(state.items.first.quantity, 6);
    });

    test('price level and discounts affect cart total', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(orderControllerProvider(10).notifier);
      await notifier.selectCategory('Speisen');
      final burger = container
          .read(orderControllerProvider(10))
          .menuItems
          .firstWhere((item) => item.name == 'Burger');

      notifier.addItem(burger);
      notifier.selectCartIndex(0);
      notifier.applyPriceLevelToSelected('staff');
      notifier.applyDiscountToSelected(10);
      notifier.applyOrderDiscount(5);

      final state = container.read(orderControllerProvider(10));
      expect(state.items.first.priceLevel, 'staff');
      expect(state.items.first.grossLineTotal, 13.9);
      expect(state.items.first.lineTotal, closeTo(12.51, 0.001));
      expect(state.total, closeTo(11.8845, 0.001));
    });

    test('storno reason and discount are attached to kitchen ticket', () async {
      final fakePrinter = InMemoryPrinterService();
      final container = ProviderContainer(
        overrides: [
          printerServiceProvider.overrideWithValue(fakePrinter),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(orderControllerProvider(13).notifier);
      final firstMenuItem =
          container.read(orderControllerProvider(13)).menuItems.first;

      notifier.addItem(firstMenuItem);
      notifier.selectCartIndex(0);
      notifier.applyDiscountToSelected(10);
      notifier.voidSelectedItem(
        reason: StornoReason.gastStorniert,
        note: 'Gast hat es sich anders überlegt',
      );

      final result = await notifier.sendToKitchen(waiterName: 'Eva');

      expect(result.success, isTrue);
      expect(fakePrinter.lastTicket, isNotNull);
      expect(fakePrinter.lastTicket!.items.first.discountLabel, '10% Rabatt');
      expect(
        fakePrinter.lastTicket!.items.first.voidLabel,
        contains('gastStorniert'),
      );
    });

    test('sendToKitchen forwards ticket to printer service and clears cart',
        () async {
      final fakePrinter = InMemoryPrinterService();
      final container = ProviderContainer(
        overrides: [
          printerServiceProvider.overrideWithValue(fakePrinter),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(orderControllerProvider(4).notifier);
      final firstMenuItem =
          container.read(orderControllerProvider(4)).menuItems.first;

      notifier.addItem(firstMenuItem);
      notifier.selectCartIndex(0);
      notifier.applyModifierToSelected('Ohne Eis');

      final result = await notifier.sendToKitchen(waiterName: 'Max');

      expect(result.success, isTrue);
      expect(result.failure, isNull);

      final sent = fakePrinter.lastTicket;
      expect(sent, isNotNull);
      expect(sent!.tableNumber, 4);
      expect(sent.waiterName, 'Max');
      expect(sent.items, hasLength(1));
      expect(sent.items.first.quantity, 1);
      expect(sent.items.first.name, firstMenuItem.name);
      expect(sent.items.first.note, 'Ohne Eis');

      final state = container.read(orderControllerProvider(4));
      expect(state.items, isEmpty);
      expect(state.selectedCartIndex, isNull);
    });

    test('sendToKitchen returns failure and keeps cart when printer fails',
        () async {
      final fakePrinter = InMemoryPrinterService()
        ..nextResult = const PrintResult.failure(
          failure: PrinterFailure.connectionLost,
          message: 'Drucker-Verbindung verloren',
        );

      final container = ProviderContainer(
        overrides: [
          printerServiceProvider.overrideWithValue(fakePrinter),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(orderControllerProvider(7).notifier);
      final firstMenuItem =
          container.read(orderControllerProvider(7)).menuItems.first;

      notifier.addItem(firstMenuItem);
      notifier.selectCartIndex(0);

      final result = await notifier.sendToKitchen(waiterName: 'Mia');

      expect(result.success, isFalse);
      expect(result.failure, PrinterFailure.connectionLost);
      expect(result.message, 'Drucker-Verbindung verloren');

      final state = container.read(orderControllerProvider(7));
      expect(state.items, isNotEmpty);
      expect(state.items.first.menuItem.id, firstMenuItem.id);
    });

    test('sendToKitchen with empty cart returns failure message', () async {
      final fakePrinter = InMemoryPrinterService();
      final container = ProviderContainer(
        overrides: [
          printerServiceProvider.overrideWithValue(fakePrinter),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(orderControllerProvider(11).notifier);

      final result = await notifier.sendToKitchen(waiterName: 'Lea');

      expect(result.success, isFalse);
      expect(result.failure, PrinterFailure.unknown);
      expect(result.message, 'Keine Positionen zum Senden');
      expect(fakePrinter.lastTicket, isNull);
    });
  });
}
