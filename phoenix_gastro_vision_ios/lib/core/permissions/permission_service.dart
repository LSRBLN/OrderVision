import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

enum AppPermissionType {
  bluetoothConnect,
  bluetoothScan,
  locationWhenInUse,
  localNetwork,
}

class PermissionRequirement {
  const PermissionRequirement({
    required this.type,
    required this.status,
    required this.isGranted,
  });

  final AppPermissionType type;
  final PermissionStatus status;
  final bool isGranted;
}

class PermissionRequestResult {
  const PermissionRequestResult({
    required this.requirements,
  });

  final List<PermissionRequirement> requirements;

  bool get allGranted => requirements.every((item) => item.isGranted);

  bool get hasPermanentlyDenied =>
      requirements.any((item) => item.status.isPermanentlyDenied);
}

abstract class PermissionService {
  Future<PermissionRequestResult> ensurePrinterPermissions();
  Future<PermissionRequestResult> getPrinterPermissionStatus();
}

class PermissionHandlerService implements PermissionService {
  const PermissionHandlerService();

  @override
  Future<PermissionRequestResult> ensurePrinterPermissions() async {
    final permissions = _printerPermissions;
    final statuses = await permissions.request();
    return PermissionRequestResult(
      requirements: statuses.entries
          .map(
            (entry) => PermissionRequirement(
              type: _mapPermission(entry.key),
              status: entry.value,
              isGranted: entry.value.isGranted || entry.value.isLimited,
            ),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<PermissionRequestResult> getPrinterPermissionStatus() async {
    final requirements = <PermissionRequirement>[];
    for (final permission in _printerPermissions) {
      final status = await permission.status;
      requirements.add(
        PermissionRequirement(
          type: _mapPermission(permission),
          status: status,
          isGranted: status.isGranted || status.isLimited,
        ),
      );
    }

    return PermissionRequestResult(requirements: requirements);
  }

  List<Permission> get _printerPermissions {
    if (Platform.isIOS) {
      return <Permission>[
        Permission.bluetooth,
        Permission.locationWhenInUse,
      ];
    }

    if (!Platform.isAndroid) {
      return const <Permission>[];
    }

    return <Permission>[
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.locationWhenInUse,
    ];
  }

  AppPermissionType _mapPermission(Permission permission) {
    if (permission == Permission.bluetooth) {
      return AppPermissionType.bluetoothConnect;
    }
    if (permission == Permission.bluetoothConnect) {
      return AppPermissionType.bluetoothConnect;
    }
    if (permission == Permission.bluetoothScan) {
      return AppPermissionType.bluetoothScan;
    }
    return AppPermissionType.locationWhenInUse;
  }
}
