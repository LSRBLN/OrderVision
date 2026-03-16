import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/features/order/domain/menu_item.dart';
import 'package:orderman_flutter/features/order/presentation/order_controller.dart';
import 'package:orderman_flutter/features/payment/domain/bill_splitter.dart';
import 'package:orderman_flutter/features/payment/presentation/payment_controller.dart';
import 'package:orderman_flutter/features/payment/presentation/payment_screen.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({
    super.key,
    required this.tableNumber,
    required this.waiterName,
  });

  final int tableNumber;
  final String waiterName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderControllerProvider(tableNumber));
    final controller = ref.read(orderControllerProvider(tableNumber).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tisch $tableNumber | Kellner: $waiterName'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text('Sitzplatz ${state.activeSeat}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton.tonalIcon(
              onPressed: state.items.isEmpty
                  ? null
                  : () {
                      final session = PaymentSession(
                        tableNumber: tableNumber,
                        items: state.items
                            .asMap()
                            .entries
                            .map(
                              (entry) => BillSplitItem(
                                id: '${entry.value.menuItem.id}_${entry.key}',
                                name:
                                    '${entry.value.quantity}x ${entry.value.menuItem.name}',
                                total: entry.value.lineTotal,
                                seatNumber: entry.value.seatNumber,
                              ),
                            )
                            .toList(growable: false),
                      );

                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => PaymentScreen(session: session),
                        ),
                      );
                    },
              icon: const Icon(Icons.payment),
              label: const Text('Zahlung'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 360,
              child: _CartPanel(
                state: state,
                onSelectSeat: controller.setActiveSeat,
                onAssignSeat: controller.assignSelectedItemToActiveSeat,
                onSelectItem: controller.selectCartIndex,
                onDecreaseQuantity: controller.decreaseSelectedQuantity,
                onIncreaseQuantity: controller.increaseSelectedQuantity,
                onMultiplyBy2: () => controller.multiplySelectedQuantity(2),
                onMultiplyBy3: () => controller.multiplySelectedQuantity(3),
                onStorno: () async {
                  final result = await _showStornoDialog(context);
                  if (result == null) {
                    return;
                  }
                  controller.voidSelectedItem(
                    reason: result.reason,
                    note: result.note,
                  );
                },
                onModifier: () async {
                  final text = await _showModifierDialog(context);
                  if (text != null) {
                    controller.applyModifierToSelected(text);
                  }
                },
                onItemDiscount: () async {
                  final value =
                      await _showDiscountDialog(context, 'Artikelrabatt %');
                  if (value != null) {
                    controller.applyDiscountToSelected(value);
                  }
                },
                onOrderDiscount: () async {
                  final value =
                      await _showDiscountDialog(context, 'Gesamtrabatt %');
                  if (value != null) {
                    controller.applyOrderDiscount(value);
                  }
                },
                onPriceLevel: controller.applyPriceLevelToSelected,
                onSend: () async {
                  final result =
                      await controller.sendToKitchen(waiterName: waiterName);
                  if (!context.mounted) {
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result.message),
                      backgroundColor: result.success
                          ? Colors.green.shade700
                          : Theme.of(context).colorScheme.error,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MenuPanel(
                state: state,
                onSelectCategory: controller.selectCategory,
                onAddItem: controller.addItem,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showModifierDialog(BuildContext context) async {
    final ctrl = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier hinzufügen'),
          content: TextField(
            controller: ctrl,
            decoration: const InputDecoration(hintText: 'z. B. Ohne Eis'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(ctrl.text),
              child: const Text('Speichern'),
            ),
          ],
        );
      },
    );
  }

  Future<double?> _showDiscountDialog(
      BuildContext context, String title) async {
    final ctrl = TextEditingController();
    return showDialog<double>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: ctrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(hintText: 'z. B. 10'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(
                double.tryParse(ctrl.text.trim().replaceAll(',', '.')),
              ),
              child: const Text('Übernehmen'),
            ),
          ],
        );
      },
    );
  }

  Future<_StornoDialogResult?> _showStornoDialog(BuildContext context) async {
    final ctrl = TextEditingController();
    var selected = StornoReason.falschBestellt;
    return showDialog<_StornoDialogResult>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Storno erfassen'),
              content: SizedBox(
                width: 420,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<StornoReason>(
                      initialValue: selected,
                      items: const [
                        DropdownMenuItem(
                          value: StornoReason.falschBestellt,
                          child: Text('Falsch bestellt'),
                        ),
                        DropdownMenuItem(
                          value: StornoReason.gastStorniert,
                          child: Text('Gast storniert'),
                        ),
                        DropdownMenuItem(
                          value: StornoReason.kueche,
                          child: Text('Küche'),
                        ),
                        DropdownMenuItem(
                          value: StornoReason.sonstiges,
                          child: Text('Sonstiges'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selected = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: ctrl,
                      decoration: const InputDecoration(
                        labelText: 'Freitext / Zusatz',
                      ),
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
                  onPressed: () => Navigator.of(context).pop(
                    _StornoDialogResult(
                        reason: selected, note: ctrl.text.trim()),
                  ),
                  child: const Text('Storno speichern'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _StornoDialogResult {
  const _StornoDialogResult({
    required this.reason,
    required this.note,
  });

  final StornoReason reason;
  final String note;
}

class _CartPanel extends StatelessWidget {
  const _CartPanel({
    required this.state,
    required this.onSelectSeat,
    required this.onAssignSeat,
    required this.onSelectItem,
    required this.onDecreaseQuantity,
    required this.onIncreaseQuantity,
    required this.onMultiplyBy2,
    required this.onMultiplyBy3,
    required this.onStorno,
    required this.onModifier,
    required this.onItemDiscount,
    required this.onOrderDiscount,
    required this.onPriceLevel,
    required this.onSend,
  });

  final OrderState state;
  final ValueChanged<int> onSelectSeat;
  final VoidCallback onAssignSeat;
  final ValueChanged<int> onSelectItem;
  final VoidCallback onDecreaseQuantity;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onMultiplyBy2;
  final VoidCallback onMultiplyBy3;
  final VoidCallback onStorno;
  final VoidCallback onModifier;
  final VoidCallback onItemDiscount;
  final VoidCallback onOrderDiscount;
  final ValueChanged<String> onPriceLevel;
  final Future<void> Function() onSend;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Warenkorb', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var seat = 1; seat <= 6; seat++)
                  ChoiceChip(
                    label: Text('S$seat'),
                    selected: state.activeSeat == seat,
                    onSelected: (_) => onSelectSeat(seat),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  final isSelected = state.selectedCartIndex == index;
                  return ListTile(
                    selected: isSelected,
                    onTap: () => onSelectItem(index),
                    title: Text('${item.quantity}x ${item.menuItem.name}'),
                    subtitle: Text([
                      if (item.seatNumber != null)
                        'Sitzplatz ${item.seatNumber}',
                      if (item.effectiveDiscountPercent > 0)
                        'Rabatt ${item.effectiveDiscountPercent.toStringAsFixed(0)}%',
                      if (item.isVoided)
                        'STORNO ${item.voidReason?.name ?? ''}',
                      if (item.note != null && item.note!.isNotEmpty)
                        item.note!,
                    ].join(' • ')),
                    trailing: Text('${item.lineTotal.toStringAsFixed(2)} €'),
                  );
                },
              ),
            ),
            const Divider(),
            Text('Zwischensumme: ${state.subtotal.toStringAsFixed(2)} €'),
            if (state.orderDiscountPercent > 0)
              Text(
                'Gesamtrabatt: ${state.orderDiscountPercent.toStringAsFixed(0)}%',
              ),
            Text('Total: ${state.total.toStringAsFixed(2)} €'),
            const SizedBox(height: 8),
            if (state.selectedCartIndex != null)
              DropdownButtonFormField<String>(
                initialValue: state.items[state.selectedCartIndex!].priceLevel,
                decoration: const InputDecoration(labelText: 'Preisstufe'),
                items: [
                  for (final key in {
                    'normal',
                    ...state.items[state.selectedCartIndex!].menuItem
                        .priceLevels.keys,
                  })
                    DropdownMenuItem(value: key, child: Text(key)),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onPriceLevel(value);
                  }
                },
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onDecreaseQuantity,
                    child: const Text('- Menge'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onIncreaseQuantity,
                    child: const Text('+ Menge'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onMultiplyBy2,
                    child: const Text('x2'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onMultiplyBy3,
                    child: const Text('x3'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onAssignSeat,
                    child: const Text('Sitz zuweisen'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onStorno,
                    child: const Text('Storno'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onModifier,
                    child: const Text('Modifier'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onItemDiscount,
                    child: const Text('Artikelrabatt'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onOrderDiscount,
                    child: const Text('Gesamtrabatt'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => onSend(),
                child: const Text('Senden'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuPanel extends StatelessWidget {
  const _MenuPanel({
    required this.state,
    required this.onSelectCategory,
    required this.onAddItem,
  });

  final OrderState state;
  final ValueChanged<String> onSelectCategory;
  final ValueChanged<MenuItem> onAddItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              children: [
                for (final category in state.categories)
                  ChoiceChip(
                    label: Text(category),
                    selected: category == state.selectedCategory,
                    onSelected: (_) {
                      onSelectCategory(category);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: state.menuItems.length,
                itemBuilder: (context, index) {
                  final item = state.menuItems[index];
                  return FilledButton.tonal(
                    onPressed: () => onAddItem(item),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.name, textAlign: TextAlign.center),
                        const SizedBox(height: 4),
                        Text('${item.price.toStringAsFixed(2)} €'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
