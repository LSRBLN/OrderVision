import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/features/order/domain/menu_item.dart';
import 'package:orderman_flutter/features/order/presentation/order_controller.dart';
import 'package:orderman_flutter/features/payment/domain/bill_splitter.dart';
import 'package:orderman_flutter/features/payment/presentation/payment_controller.dart';
import 'package:orderman_flutter/features/payment/presentation/payment_screen.dart';
import 'package:orderman_flutter/shared/widgets/phoenix_page_scaffold.dart';
import 'package:orderman_flutter/shared/widgets/phoenix_touch.dart';

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
    final controller = ref.read(orderControllerProvider(tableNumber).notifier);
    final activeSeat = ref.watch(
      orderControllerProvider(tableNumber).select((value) => value.activeSeat),
    );
    final items = ref.watch(
      orderControllerProvider(tableNumber).select((value) => value.items),
    );

    return PhoenixPageScaffold(
      title: 'Tisch $tableNumber',
      subtitle:
          '${BrandingConfig.current.shortBrandName} • Kellner: $waiterName • Sitzplatz $activeSeat',
      headerActions: [
        PhoenixPrimaryAction(
          onPressed: items.isEmpty
              ? null
              : () {
                  final session = PaymentSession(
                    tableNumber: tableNumber,
                    items: items
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
          child: const Text('Zahlung'),
        ),
      ],
      body: _OrderLayout(
        tableNumber: tableNumber,
        waiterName: waiterName,
        controller: controller,
        showModifierDialog: _showModifierDialog,
        showDiscountDialog: _showDiscountDialog,
        showStornoDialog: _showStornoDialog,
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

class _OrderLayout extends ConsumerWidget {
  const _OrderLayout({
    required this.tableNumber,
    required this.waiterName,
    required this.controller,
    required this.showModifierDialog,
    required this.showDiscountDialog,
    required this.showStornoDialog,
  });

  final int tableNumber;
  final String waiterName;
  final OrderController controller;
  final Future<String?> Function(BuildContext context) showModifierDialog;
  final Future<double?> Function(BuildContext context, String title)
      showDiscountDialog;
  final Future<_StornoDialogResult?> Function(BuildContext context)
      showStornoDialog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderControllerProvider(tableNumber));

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        final useSplitView = constraints.maxWidth >= 1180 ||
            (isLandscape && constraints.maxWidth >= 980);
        final cartPanel = _CartPanel(
          state: state,
          onSelectSeat: (seat) {
            HapticFeedback.selectionClick();
            controller.setActiveSeat(seat);
          },
          onAssignSeat: PhoenixTouchFeedback.wrap(
            controller.assignSelectedItemToActiveSeat,
          )!,
          onSelectItem: (index) {
            HapticFeedback.selectionClick();
            controller.selectCartIndex(index);
          },
          onDecreaseQuantity: PhoenixTouchFeedback.wrap(
            controller.decreaseSelectedQuantity,
          )!,
          onIncreaseQuantity: PhoenixTouchFeedback.wrap(
            controller.increaseSelectedQuantity,
          )!,
          onMultiplyBy2: PhoenixTouchFeedback.wrap(
            () => controller.multiplySelectedQuantity(2),
          )!,
          onMultiplyBy3: PhoenixTouchFeedback.wrap(
            () => controller.multiplySelectedQuantity(3),
          )!,
          onStorno: () async {
            HapticFeedback.heavyImpact();
            final result = await showStornoDialog(context);
            if (result == null) {
              return;
            }
            controller.voidSelectedItem(
              reason: result.reason,
              note: result.note,
            );
          },
          onModifier: () async {
            HapticFeedback.mediumImpact();
            final text = await showModifierDialog(context);
            if (text != null) {
              controller.applyModifierToSelected(text);
            }
          },
          onItemDiscount: () async {
            HapticFeedback.mediumImpact();
            final value = await showDiscountDialog(context, 'Artikelrabatt %');
            if (value != null) {
              controller.applyDiscountToSelected(value);
            }
          },
          onOrderDiscount: () async {
            HapticFeedback.mediumImpact();
            final value = await showDiscountDialog(context, 'Gesamtrabatt %');
            if (value != null) {
              controller.applyOrderDiscount(value);
            }
          },
          onPriceLevel: (value) {
            HapticFeedback.selectionClick();
            controller.applyPriceLevelToSelected(value);
          },
          onSend: () async {
            HapticFeedback.heavyImpact();
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
        );

        final menuPanel = _MenuPanel(
          state: state,
          onSelectCategory: (category) {
            HapticFeedback.selectionClick();
            controller.selectCategory(category);
          },
          onAddItem: (item) {
            HapticFeedback.mediumImpact();
            controller.addItem(item);
          },
        );

        if (useSplitView) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 440, child: cartPanel),
              const SizedBox(width: 20),
              Expanded(child: menuPanel),
            ],
          );
        }

        return Column(
          children: [
            Expanded(flex: 11, child: menuPanel),
            const SizedBox(height: 16),
            Expanded(flex: 10, child: cartPanel),
          ],
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Warenkorb', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var seat = 1; seat <= 6; seat++)
                  ChoiceChip(
                    label: Text('S$seat'),
                    selected: state.activeSeat == seat,
                    onSelected: (_) => onSelectSeat(seat),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  ),
              ],
            ),
            const SizedBox(height: 12),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Text(
              'Zwischensumme: ${state.subtotal.toStringAsFixed(2)} €',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (state.orderDiscountPercent > 0)
              Text(
                'Gesamtrabatt: ${state.orderDiscountPercent.toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            Text(
              'Total: ${state.total.toStringAsFixed(2)} €',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            if (state.selectedCartIndex != null)
              DropdownButtonFormField<String>(
                initialValue: state.items[state.selectedCartIndex!].priceLevel,
                decoration: const InputDecoration(labelText: 'Preisstufe'),
                menuMaxHeight: 360,
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
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: PhoenixTonalAction(
                    onPressed: onDecreaseQuantity,
                    child: const Text('- Menge'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PhoenixTonalAction(
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
                  child: PhoenixTonalAction(
                    onPressed: onMultiplyBy2,
                    child: const Text('x2'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PhoenixTonalAction(
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
                  child: PhoenixTonalAction(
                    onPressed: onAssignSeat,
                    child: const Text('Sitz zuweisen'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PhoenixTonalAction(
                    onPressed: onStorno,
                    child: const Text('Storno'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PhoenixTonalAction(
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
                  child: PhoenixTonalAction(
                    onPressed: onItemDiscount,
                    child: const Text('Artikelrabatt'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PhoenixTonalAction(
                    onPressed: onOrderDiscount,
                    child: const Text('Gesamtrabatt'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: PhoenixPrimaryAction(
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
    final crossAxisCount = switch (state.menuItems.length) {
      <= 6 => 2,
      <= 12 => 3,
      _ => MediaQuery.sizeOf(context).width >= 1366 ? 4 : 3,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final category in state.categories)
                  ChoiceChip(
                    label: Text(category),
                    selected: category == state.selectedCategory,
                    onSelected: (_) {
                      onSelectCategory(category);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 108,
                ),
                itemCount: state.menuItems.length,
                itemBuilder: (context, index) {
                  final item = state.menuItems[index];
                  return PhoenixTonalAction(
                    onPressed: () => onAddItem(item),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.price.toStringAsFixed(2)} €',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
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
