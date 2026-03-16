import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/features/printer/presentation/printer_providers.dart';

enum DeviceStatusSeverity {
  good,
  warning,
  critical,
  neutral,
}

class DeviceStatusInfo {
  const DeviceStatusInfo({
    required this.label,
    required this.icon,
    required this.severity,
    this.detail,
  });

  final String label;
  final String icon;
  final DeviceStatusSeverity severity;
  final String? detail;
}

final connectivityStreamProvider = StreamProvider<ConnectivityResult>((ref) {
  final connectivity = Connectivity();
  final controller = StreamController<ConnectivityResult>();

  Future<void>.microtask(() async {
    final initial = await connectivity.checkConnectivity();
    controller.add(initial.firstOrNull ?? ConnectivityResult.none);
  });

  final subscription = connectivity.onConnectivityChanged.listen((results) {
    controller.add(results.firstOrNull ?? ConnectivityResult.none);
  });

  ref.onDispose(() async {
    await subscription.cancel();
    await controller.close();
  });

  return controller.stream;
});

final onlineStatusProvider = Provider<DeviceStatusInfo>((ref) {
  final connectivity = ref.watch(connectivityStreamProvider);
  final result = connectivity.valueOrNull ?? ConnectivityResult.none;
  final isOnline = result != ConnectivityResult.none;

  return DeviceStatusInfo(
    label: isOnline ? 'Online' : 'Offline',
    icon: isOnline ? 'wifi' : 'wifi_off',
    severity:
        isOnline ? DeviceStatusSeverity.good : DeviceStatusSeverity.critical,
    detail: isOnline ? result.name : 'Local mode only',
  );
});

final batteryStatusProvider = Provider<DeviceStatusInfo>((ref) {
  // IMPORTANT: Fallback without extra package to keep step 1 buildable.
  return const DeviceStatusInfo(
    label: 'Battery N/A',
    icon: 'battery_unknown',
    severity: DeviceStatusSeverity.neutral,
    detail: 'Platform fallback active',
  );
});

final printerStatusProvider = FutureProvider<DeviceStatusInfo>((ref) async {
  final profiles = await ref.watch(printerRepositoryProvider).loadProfiles();
  final hasPrinter = profiles.isNotEmpty;

  return DeviceStatusInfo(
    label: hasPrinter ? 'Printer ready' : 'Printer missing',
    icon: hasPrinter ? 'print' : 'print_disabled',
    severity:
        hasPrinter ? DeviceStatusSeverity.good : DeviceStatusSeverity.warning,
    detail: hasPrinter ? '${profiles.length} profile(s)' : 'Configure printer',
  );
});
