import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/core/theme/phoenix_branding.dart';
import 'package:orderman_flutter/features/payment/domain/bill_splitter.dart';
import 'package:orderman_flutter/features/payment/presentation/payment_controller.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({
    super.key,
    required this.session,
  });

  final PaymentSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paymentControllerProvider(session));
    final controller = ref.read(paymentControllerProvider(session).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('${PhoenixBranding.appName} • Tisch ${state.tableNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _PhoenixPaymentHeader(state: state),
            const SizedBox(height: 16),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 420,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Split & Zahlungsfluss',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                ChoiceChip(
                                  label: const Text('Gleichmäßig'),
                                  selected: state.mode == SplitMode.even,
                                  onSelected: (_) =>
                                      controller.selectMode(SplitMode.even),
                                ),
                                ChoiceChip(
                                  label: const Text('Sitzplatz'),
                                  selected: state.mode == SplitMode.seat,
                                  onSelected: (_) =>
                                      controller.selectMode(SplitMode.seat),
                                ),
                                ChoiceChip(
                                  label: const Text('Selektiv'),
                                  selected: state.mode == SplitMode.selective,
                                  onSelected: (_) => controller
                                      .selectMode(SplitMode.selective),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            if (state.mode == SplitMode.even) ...[
                              Text('Gäste: ${state.guests}'),
                              Slider(
                                min: 1,
                                max: 12,
                                divisions: 11,
                                value: state.guests.toDouble(),
                                onChanged: (value) =>
                                    controller.setGuests(value.round()),
                              ),
                            ],
                            if (state.mode == SplitMode.selective) ...[
                              Text(
                                'Positionen wählen',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: ListView(
                                  children: [
                                    for (final item in state.items)
                                      CheckboxListTile(
                                        value: state.selectedItemIds
                                            .contains(item.id),
                                        onChanged: (_) => controller
                                            .toggleSelectiveItem(item.id),
                                        title: Text(item.name),
                                        subtitle: Text(
                                          '${item.total.toStringAsFixed(2)} €',
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ] else
                              const Spacer(),
                            Text(
                              'Zahlungsart',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                for (final method in PaymentMethod.values)
                                  _PaymentMethodChip(
                                    method: method,
                                    selected: state.method == method,
                                    onTap: () =>
                                        controller.selectMethod(method),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.04),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Abschluss-Check',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Zahlungsart: ${_labelForMethod(state.method)}',
                                  ),
                                  Text('TSE: ${state.tseStatusMessage}'),
                                  if (state.tseTransactionId != null)
                                    Text('TSE-ID: ${state.tseTransactionId}'),
                                  if (state.lastTransactionReference != null)
                                    Text(
                                      'Referenz: ${state.lastTransactionReference}',
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: !state.canFinalizePayment
                                    ? null
                                    : () async {
                                        final message =
                                            await controller.completePayment();
                                        if (!context.mounted) {
                                          return;
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text(message)),
                                        );
                                      },
                                icon: const Icon(Icons.verified_outlined),
                                label: Text(
                                  state.canCompleteSelectedPart
                                      ? 'Zahlung final abschließen'
                                      : 'Bereits bezahlt',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Split-Vorschau',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: ListView(
                                children: [
                                  for (final entry
                                      in state.result.parts.asMap().entries)
                                    _SplitPartCard(
                                      part: entry.value,
                                      selected:
                                          state.selectedPartIndex == entry.key,
                                      completed: state.completedPartLabels
                                          .contains(entry.value.label),
                                      onTap: () =>
                                          controller.selectPart(entry.key),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
}

class _PhoenixPaymentHeader extends StatelessWidget {
  const _PhoenixPaymentHeader({required this.state});

  final PaymentState state;

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (state.tseConnectionState) {
      TseConnectionState.connected => PhoenixBranding.success,
      TseConnectionState.error => PhoenixBranding.danger,
      TseConnectionState.unknown => PhoenixBranding.warning,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                PhoenixBranding.logoAssetPng,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    PhoenixBranding.appName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Offen ${state.remainingTotal.toStringAsFixed(2)} € • Bezahlt ${state.completedTotal.toStringAsFixed(2)} €',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: statusColor.withValues(alpha: 0.30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TSE-Status',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(state.tseStatusMessage),
                  if (state.tseSignature != null &&
                      state.tseSignature!.isNotEmpty)
                    Text('Signatur: ${state.tseSignature}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethodChip extends StatelessWidget {
  const _PaymentMethodChip({
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(_labelForMethod(method)),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}

String _labelForMethod(PaymentMethod method) {
  switch (method) {
    case PaymentMethod.cash:
      return 'Bar';
    case PaymentMethod.sumup:
      return 'SumUp';
    case PaymentMethod.nfc:
      return 'NFC';
    case PaymentMethod.paypal:
      return 'PayPal';
    case PaymentMethod.manualCard:
      return 'Manual Card';
  }
}

class _SplitPartCard extends StatelessWidget {
  const _SplitPartCard({
    required this.part,
    required this.selected,
    required this.completed,
    required this.onTap,
  });

  final BillSplitPart part;
  final bool selected;
  final bool completed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: selected ? Theme.of(context).colorScheme.primaryContainer : null,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      part.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  if (selected) const Icon(Icons.check_circle),
                  if (!selected && completed) const Icon(Icons.paid_outlined),
                ],
              ),
              const SizedBox(height: 8),
              if (part.items.isEmpty)
                const Text('Keine Einzelpositionen in dieser Vorschau')
              else
                for (final item in part.items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${item.name} • ${item.total.toStringAsFixed(2)} €',
                    ),
                  ),
              const SizedBox(height: 8),
              Text(
                'Summe: ${part.total.toStringAsFixed(2)} €',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
