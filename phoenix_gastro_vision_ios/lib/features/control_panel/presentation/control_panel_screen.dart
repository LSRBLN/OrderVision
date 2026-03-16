import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/core/config/production_config.dart';
import 'package:orderman_flutter/core/database/isar_service.dart';
import 'package:orderman_flutter/core/theme/phoenix_branding.dart';
import 'package:orderman_flutter/features/auth/domain/user_model.dart';
import 'package:orderman_flutter/features/auth/presentation/auth_providers.dart';
import 'package:orderman_flutter/features/payment/data/tse_service.dart';
import 'package:orderman_flutter/features/payment/presentation/payment_controller.dart';
import 'package:orderman_flutter/shared/widgets/phoenix_page_scaffold.dart';
import 'package:orderman_flutter/shared/widgets/phoenix_touch.dart';

class ControlPanelState {
  ControlPanelState({
    this.territory = 'Hauptbereich',
    this.message,
    this.productionMode = false,
    this.lastBackupPath,
    this.lastRestorePath,
    this.tseStatus =
        const TseStatus(isAvailable: false, message: 'TSE wird geprüft …'),
  });

  final String territory;
  final String? message;
  final bool productionMode;
  final String? lastBackupPath;
  final String? lastRestorePath;
  final TseStatus tseStatus;

  ControlPanelState copyWith({
    String? territory,
    String? message,
    bool clearMessage = false,
    bool? productionMode,
    String? lastBackupPath,
    String? lastRestorePath,
    TseStatus? tseStatus,
  }) {
    return ControlPanelState(
      territory: territory ?? this.territory,
      message: clearMessage ? null : (message ?? this.message),
      productionMode: productionMode ?? this.productionMode,
      lastBackupPath: lastBackupPath ?? this.lastBackupPath,
      lastRestorePath: lastRestorePath ?? this.lastRestorePath,
      tseStatus: tseStatus ?? this.tseStatus,
    );
  }
}

final controlPanelControllerProvider =
    NotifierProvider<ControlPanelController, ControlPanelState>(
  ControlPanelController.new,
);

class ControlPanelController extends Notifier<ControlPanelState> {
  @override
  ControlPanelState build() {
    Future<void>.microtask(_loadHealthStatus);
    return ControlPanelState(
      productionMode: ProductionConfig.isProductionMode,
    );
  }

  void setTerritory(String territory) {
    state = state.copyWith(territory: territory);
  }

  Future<void> createBackup() async {
    final path = await IsarService.instance.exportJsonBackup();
    state = state.copyWith(
      lastBackupPath: path,
      message: 'JSON-Backup erstellt: $path',
    );
  }

  Future<void> restoreBackup() async {
    final path = state.lastBackupPath;
    if (path == null || path.isEmpty) {
      state = state.copyWith(
        message: 'Kein Backup vorhanden. Bitte zuerst Backup erstellen.',
      );
      return;
    }

    final result = await IsarService.instance.restoreJsonBackup(path);
    state = state.copyWith(
      lastRestorePath: path,
      message: result,
    );
  }

  Future<void> clearAllData() async {
    await IsarService.instance.clearAll();
    state = state.copyWith(message: 'Alle lokalen Daten wurden gelöscht.');
  }

  void setProductionMode(bool value) {
    state = state.copyWith(
      productionMode: value,
      message: value
          ? 'Produktionsmodus aktiviert. Training ist deaktiviert.'
          : 'Trainingsmodus aktiviert. Keine Live-Freigabe.',
    );
  }

  Future<void> _loadHealthStatus() async {
    final tseStatus = await ref.read(tseServiceProvider).checkStatus();
    state = state.copyWith(tseStatus: tseStatus);
  }
}

class ControlPanelScreen extends ConsumerWidget {
  const ControlPanelScreen({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panelState = ref.watch(controlPanelControllerProvider);
    final panelController = ref.read(controlPanelControllerProvider.notifier);

    return PhoenixPageScaffold(
      title: BrandingConfig.current.shortBrandName,
      subtitle:
          '${BrandingConfig.current.texts.controlPanelSubtitle} for ${user.name}',
      headerActions: [
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: panelState.territory,
            items: const [
              DropdownMenuItem(
                  value: 'Hauptbereich', child: Text('Hauptbereich')),
              DropdownMenuItem(value: 'Terrasse', child: Text('Terrasse')),
              DropdownMenuItem(value: 'Bar', child: Text('Bar')),
            ],
            onChanged: (value) {
              if (value != null) {
                panelController.setTerritory(value);
              }
            },
          ),
        ),
        PhoenixPrimaryAction(
          onPressed: () {
            ref.read(authControllerProvider.notifier).logout();
            context.go('/login');
          },
          icon: const Icon(Icons.logout),
          child: const Text('Logout'),
        ),
      ],
      body: Column(
        children: [
          if (panelState.message != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: MaterialBanner(
                content: Text(panelState.message!),
                actions: [
                  TextButton(
                    onPressed: () =>
                        panelController.setTerritory(panelState.territory),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: 0,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard_customize_outlined),
                      selectedIcon: Icon(Icons.dashboard_customize),
                      label: Text('Übersicht'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Willkommen, ${user.name}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Aktives Territorium: ${panelState.territory}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${BrandingConfig.current.shortBrandName} Betriebsstatus',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      panelState.productionMode
                                          ? 'Produktionsmodus aktiv'
                                          : 'Trainingsmodus aktiv',
                                    ),
                                    Text(
                                      'TSE: ${panelState.tseStatus.message}',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Switch.adaptive(
                                value: panelState.productionMode,
                                activeThumbColor: PhoenixBranding.gold,
                                activeTrackColor: PhoenixBranding.gold
                                    .withValues(alpha: 0.35),
                                onChanged: panelController.setProductionMode,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 1.5,
                            children: [
                              _PanelTile(
                                icon: Icons.table_restaurant,
                                title: 'Tischplan',
                                subtitle: 'Tische, Status, Öffnen',
                                onTap: () => context.go('/floor-plan'),
                              ),
                              _PanelTile(
                                icon: Icons.flash_on,
                                title: 'Bestellung (schnell)',
                                subtitle: 'Direkt zu Tisch 1',
                                onTap: () => context.go('/floor-plan'),
                              ),
                              _PanelTile(
                                icon: Icons.print,
                                title: 'Drucker-Einstellungen',
                                subtitle: 'Bluetooth / WiFi / Testdruck',
                                onTap: () => context.go('/printer-settings'),
                              ),
                              _PanelTile(
                                icon: Icons.restaurant_menu,
                                title: 'Menü-Verwaltung',
                                subtitle: 'Kategorien, Preise und Rabattflags',
                                onTap: () => context.go('/menu-management'),
                              ),
                              _PanelTile(
                                icon: Icons.credit_score,
                                title: 'Zahlung & TSE',
                                subtitle: panelState.tseStatus.isAvailable
                                    ? 'TSE verbunden, Zahlungsfluss bereit'
                                    : 'TSE prüfen und Zahlungsstatus öffnen',
                                onTap: () => context.go('/reports'),
                              ),
                              _PanelTile(
                                icon: Icons.people_alt_outlined,
                                title: 'Benutzerverwaltung',
                                subtitle: 'Rollen und Kellner',
                                onTap: () => context.go('/users'),
                              ),
                              _PanelTile(
                                icon: Icons.settings_suggest_outlined,
                                title: 'System-Settings',
                                subtitle: 'Logout, Training, Backup',
                                onTap: () => context.go('/system-settings'),
                              ),
                              if (user.isAdmin)
                                _PanelTile(
                                  icon: Icons.backup_outlined,
                                  title: 'Backup exportieren',
                                  subtitle: panelState.lastBackupPath == null
                                      ? 'Isar → JSON exportieren'
                                      : 'Letztes Backup: ${panelState.lastBackupPath}',
                                  onTap: panelController.createBackup,
                                ),
                              if (user.isAdmin)
                                _PanelTile(
                                  icon: Icons.restore_outlined,
                                  title: 'Backup wiederherstellen',
                                  subtitle: panelState.lastRestorePath == null
                                      ? 'Letztes JSON-Backup einspielen'
                                      : 'Wiederhergestellt: ${panelState.lastRestorePath}',
                                  onTap: panelController.restoreBackup,
                                ),
                              if (user.isAdmin)
                                _PanelTile(
                                  icon: Icons.delete_forever_outlined,
                                  title: 'Daten löschen',
                                  subtitle: 'Lokale Offline-Daten zurücksetzen',
                                  onTap: panelController.clearAllData,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PanelTile extends StatelessWidget {
  const _PanelTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36),
              const SizedBox(height: 16),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(subtitle),
            ],
          ),
        ),
      ),
    );
  }
}
