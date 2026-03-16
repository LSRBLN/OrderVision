import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';
import 'package:orderman_flutter/core/permissions/permission_service.dart';
import 'package:orderman_flutter/features/printer/data/printer_repository.dart';
import 'package:orderman_flutter/features/printer/data/real_printer_service.dart';
import 'package:orderman_flutter/features/printer/domain/printer_service.dart';
import 'package:uuid/uuid.dart';

class PrinterSettingsState {
  const PrinterSettingsState({
    this.isLoading = false,
    this.isSaving = false,
    this.discoveredDevices = const <PrinterDevice>[],
    this.savedProfiles = const <PrinterProfile>[],
    this.message,
    this.permissionsGranted = false,
  });

  final bool isLoading;
  final bool isSaving;
  final List<PrinterDevice> discoveredDevices;
  final List<PrinterProfile> savedProfiles;
  final String? message;
  final bool permissionsGranted;

  PrinterSettingsState copyWith({
    bool? isLoading,
    bool? isSaving,
    List<PrinterDevice>? discoveredDevices,
    List<PrinterProfile>? savedProfiles,
    String? message,
    bool clearMessage = false,
    bool? permissionsGranted,
  }) {
    return PrinterSettingsState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      discoveredDevices: discoveredDevices ?? this.discoveredDevices,
      savedProfiles: savedProfiles ?? this.savedProfiles,
      message: clearMessage ? null : (message ?? this.message),
      permissionsGranted: permissionsGranted ?? this.permissionsGranted,
    );
  }
}

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return const PermissionHandlerService();
});

final printerRepositoryProvider = Provider<PrinterRepository>((ref) {
  if (IsarService.instance.isReady) {
    return IsarPrinterRepository(IsarService.instance);
  }
  return InMemoryPrinterRepository();
});

final printerServiceProvider = Provider<PrinterService>((ref) {
  return RealPrinterService(
    permissionService: ref.read(permissionServiceProvider),
    printerRepository: ref.read(printerRepositoryProvider),
  );
});

final printerSettingsControllerProvider =
    NotifierProvider<PrinterSettingsController, PrinterSettingsState>(
  PrinterSettingsController.new,
);

class PrinterSettingsController extends Notifier<PrinterSettingsState> {
  final Uuid _uuid = const Uuid();

  @override
  PrinterSettingsState build() {
    Future<void>.microtask(load);
    return const PrinterSettingsState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearMessage: true);
    final permissionStatus =
        await ref.read(permissionServiceProvider).getPrinterPermissionStatus();
    final profiles = await ref.read(printerRepositoryProvider).loadProfiles();
    state = state.copyWith(
      isLoading: false,
      savedProfiles: profiles,
      permissionsGranted: permissionStatus.allGranted,
    );
  }

  Future<void> scanBluetoothPrinters() async {
    state = state.copyWith(isLoading: true, clearMessage: true);
    final devices =
        await ref.read(printerServiceProvider).discoverBluetoothPrinters();
    final permissionStatus =
        await ref.read(permissionServiceProvider).getPrinterPermissionStatus();
    state = state.copyWith(
      isLoading: false,
      discoveredDevices: devices,
      permissionsGranted: permissionStatus.allGranted,
      message: devices.isEmpty
          ? 'Keine Bluetooth-Drucker gefunden oder Berechtigungen fehlen.'
          : '${devices.length} Bluetooth-Drucker gefunden.',
    );
  }

  Future<void> saveBluetoothPrinter({
    required PrinterDevice device,
    required bool isKitchenPrinter,
    required bool isReceiptPrinter,
  }) async {
    state = state.copyWith(isSaving: true, clearMessage: true);
    final profile = PrinterProfile(
      id: _uuid.v4(),
      name: device.name,
      connectionType: PrinterConnectionType.bluetooth,
      bluetoothAddress: device.address,
      isDefault: true,
      isKitchenPrinter: isKitchenPrinter,
      isReceiptPrinter: isReceiptPrinter,
    );
    await ref.read(printerRepositoryProvider).saveProfile(profile);
    await load();
    state = state.copyWith(
      isSaving: false,
      message: 'Bluetooth-Drucker ${device.name} gespeichert.',
    );
  }

  Future<void> saveNetworkPrinter({
    required String name,
    required String ipAddress,
    required int port,
    required bool isKitchenPrinter,
    required bool isReceiptPrinter,
  }) async {
    state = state.copyWith(isSaving: true, clearMessage: true);
    final profile = PrinterProfile(
      id: _uuid.v4(),
      name: name,
      connectionType: PrinterConnectionType.network,
      ipAddress: ipAddress,
      port: port,
      isDefault: true,
      isKitchenPrinter: isKitchenPrinter,
      isReceiptPrinter: isReceiptPrinter,
    );
    await ref.read(printerRepositoryProvider).saveProfile(profile);
    await load();
    state = state.copyWith(
      isSaving: false,
      message: 'Netzwerkdrucker $name gespeichert.',
    );
  }

  Future<void> deleteProfile(String profileId) async {
    await ref.read(printerRepositoryProvider).deleteProfile(profileId);
    await load();
    state = state.copyWith(message: 'Druckerprofil entfernt.');
  }

  Future<PrintResult> printKitchenTest() {
    return ref.read(printerServiceProvider).printKitchenTicket(
          const KitchenTicketData(
            tableNumber: 7,
            waiterName: 'Testkellner',
            items: <KitchenTicketItem>[
              KitchenTicketItem(quantity: 2, name: 'Burger'),
              KitchenTicketItem(
                  quantity: 1, name: 'Pommes', note: 'Extra knusprig'),
            ],
          ),
        );
  }

  Future<PrintResult> printReceiptTest() {
    return ref.read(printerServiceProvider).printGuestReceipt(
          const GuestReceiptData(
            tableNumber: 7,
            waiterName: 'Testkellner',
            totalAmount: 28.40,
            qrData: 'https://orderman.local/receipt/test',
            items: <GuestReceiptItem>[
              GuestReceiptItem(quantity: 2, name: 'Burger', unitPrice: 9.50),
              GuestReceiptItem(quantity: 1, name: 'Pommes', unitPrice: 4.20),
              GuestReceiptItem(quantity: 1, name: 'Cola', unitPrice: 5.20),
            ],
          ),
        );
  }
}
