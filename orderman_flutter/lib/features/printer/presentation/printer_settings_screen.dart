import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/features/printer/presentation/printer_providers.dart';

class PrinterSettingsScreen extends ConsumerStatefulWidget {
  const PrinterSettingsScreen({super.key});

  @override
  ConsumerState<PrinterSettingsScreen> createState() =>
      _PrinterSettingsScreenState();
}

class _PrinterSettingsScreenState extends ConsumerState<PrinterSettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController =
      TextEditingController(text: '9100');

  @override
  void dispose() {
    _nameController.dispose();
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(printerSettingsControllerProvider);
    final controller = ref.read(printerSettingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drucker-Einstellungen'),
        actions: [
          IconButton(
            onPressed:
                state.isLoading ? null : controller.scanBluetoothPrinters,
            icon: const Icon(Icons.bluetooth_searching),
            tooltip: 'Bluetooth-Scan',
          ),
        ],
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
                  actions: const <Widget>[SizedBox.shrink()],
                ),
              ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildBluetoothPanel(context, state, controller),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSavedProfilesPanel(context, state, controller),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 360,
                    child: _buildNetworkPanel(context, state, controller),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBluetoothPanel(
    BuildContext context,
    PrinterSettingsState state,
    PrinterSettingsController controller,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bluetooth-Scan',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              state.permissionsGranted
                  ? 'Berechtigungen vorhanden.'
                  : 'Bluetooth-/Scan-Berechtigungen prüfen.',
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed:
                  state.isLoading ? null : controller.scanBluetoothPrinters,
              icon: const Icon(Icons.search),
              label: const Text('Drucker suchen'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: state.discoveredDevices.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final device = state.discoveredDevices[index];
                        return ListTile(
                          leading: const Icon(Icons.print),
                          title: Text(device.name),
                          subtitle: Text(device.address ?? 'Ohne Adresse'),
                          trailing: Wrap(
                            spacing: 8,
                            children: [
                              FilledButton.tonal(
                                onPressed: state.isSaving
                                    ? null
                                    : () => controller.saveBluetoothPrinter(
                                          device: device,
                                          isKitchenPrinter: true,
                                          isReceiptPrinter: false,
                                        ),
                                child: const Text('Als Küche'),
                              ),
                              FilledButton.tonal(
                                onPressed: state.isSaving
                                    ? null
                                    : () => controller.saveBluetoothPrinter(
                                          device: device,
                                          isKitchenPrinter: false,
                                          isReceiptPrinter: true,
                                        ),
                                child: const Text('Als Rechnung'),
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

  Widget _buildSavedProfilesPanel(
    BuildContext context,
    PrinterSettingsState state,
    PrinterSettingsController controller,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gespeicherte Drucker',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final result = await controller.printKitchenTest();
                    if (!mounted) {
                      return;
                    }
                    messenger.showSnackBar(
                      SnackBar(content: Text(result.message)),
                    );
                  },
                  icon: const Icon(Icons.receipt_long),
                  label: const Text('Test-Küchenbon'),
                ),
                FilledButton.icon(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final result = await controller.printReceiptTest();
                    if (!mounted) {
                      return;
                    }
                    messenger.showSnackBar(
                      SnackBar(content: Text(result.message)),
                    );
                  },
                  icon: const Icon(Icons.point_of_sale),
                  label: const Text('Test-Rechnung'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: state.savedProfiles.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final profile = state.savedProfiles[index];
                  final tags = <String>[
                    if (profile.isKitchenPrinter) 'Küche',
                    if (profile.isReceiptPrinter) 'Rechnung',
                    if (profile.isDefault) 'Standard',
                  ].join(' • ');
                  return ListTile(
                    leading: Icon(
                      profile.isBluetooth ? Icons.bluetooth : Icons.wifi,
                    ),
                    title: Text(profile.name),
                    subtitle: Text(
                      '${profile.isBluetooth ? profile.bluetoothAddress : '${profile.ipAddress}:${profile.port}'}\n$tags',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      onPressed: () => controller.deleteProfile(profile.id),
                      icon: const Icon(Icons.delete_outline),
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

  Widget _buildNetworkPanel(
    BuildContext context,
    PrinterSettingsState state,
    PrinterSettingsController controller,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Netzwerkdrucker',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ipController,
              decoration: const InputDecoration(labelText: 'IP-Adresse'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _portController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Port'),
            ),
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              onPressed: state.isSaving
                  ? null
                  : () => controller.saveNetworkPrinter(
                        name: _nameController.text.trim().isEmpty
                            ? 'WiFi Printer'
                            : _nameController.text.trim(),
                        ipAddress: _ipController.text.trim(),
                        port: int.tryParse(_portController.text.trim()) ?? 9100,
                        isKitchenPrinter: true,
                        isReceiptPrinter: false,
                      ),
              icon: const Icon(Icons.kitchen),
              label: const Text('Als Küchendrucker speichern'),
            ),
            const SizedBox(height: 8),
            FilledButton.tonalIcon(
              onPressed: state.isSaving
                  ? null
                  : () => controller.saveNetworkPrinter(
                        name: _nameController.text.trim().isEmpty
                            ? 'WiFi Printer'
                            : _nameController.text.trim(),
                        ipAddress: _ipController.text.trim(),
                        port: int.tryParse(_portController.text.trim()) ?? 9100,
                        isKitchenPrinter: false,
                        isReceiptPrinter: true,
                      ),
              icon: const Icon(Icons.receipt),
              label: const Text('Als Rechnungsdrucker speichern'),
            ),
          ],
        ),
      ),
    );
  }
}
