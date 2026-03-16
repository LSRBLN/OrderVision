import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/core/system/system_status_providers.dart';

class PhoenixStatusHeader extends ConsumerWidget {
  const PhoenixStatusHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions = const <Widget>[],
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onlineStatus = ref.watch(onlineStatusProvider);
    final batteryStatus = ref.watch(batteryStatusProvider);
    final printerStatus = ref.watch(printerStatusProvider);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 12,
              spacing: 16,
              children: [
                if (leading != null)
                  leading!
                else
                  _BrandChip(config: BrandingConfig.current),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 220),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title,
                          style: Theme.of(context).textTheme.headlineSmall),
                      if (subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            subtitle!,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                    ],
                  ),
                ),
                _StatusChip(info: onlineStatus),
                _StatusChip(info: batteryStatus),
                _AsyncStatusChip(info: printerStatus),
                const SpacerWidget(),
                ...actions,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandChip extends StatelessWidget {
  const _BrandChip({required this.config});

  final BrandingConfig config;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.22),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              config.logoAssetPng,
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                config.shortBrandName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                config.texts.statusHeaderLabel,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AsyncStatusChip extends StatelessWidget {
  const _AsyncStatusChip({required this.info});

  final AsyncValue<DeviceStatusInfo> info;

  @override
  Widget build(BuildContext context) {
    return info.when(
      data: (value) => _StatusChip(info: value),
      loading: () => const _StatusChip(
        info: DeviceStatusInfo(
          label: 'Printer…',
          icon: 'print',
          severity: DeviceStatusSeverity.neutral,
        ),
      ),
      error: (_, __) => const _StatusChip(
        info: DeviceStatusInfo(
          label: 'Printer error',
          icon: 'print_disabled',
          severity: DeviceStatusSeverity.warning,
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.info});

  final DeviceStatusInfo info;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tone = switch (info.severity) {
      DeviceStatusSeverity.good => colorScheme.primary,
      DeviceStatusSeverity.warning => colorScheme.tertiary,
      DeviceStatusSeverity.critical => colorScheme.error,
      DeviceStatusSeverity.neutral => colorScheme.outline,
    };

    return Tooltip(
      message: info.detail ?? info.label,
      child: Chip(
        avatar: Icon(_iconFor(info.icon), size: 20),
        label: Text(info.label),
        side: BorderSide(color: tone.withValues(alpha: 0.32)),
        backgroundColor: tone.withValues(alpha: 0.14),
      ),
    );
  }

  IconData _iconFor(String icon) {
    return switch (icon) {
      'wifi' => Icons.wifi,
      'wifi_off' => Icons.wifi_off,
      'battery_unknown' => Icons.battery_unknown,
      'print' => Icons.print,
      'print_disabled' => Icons.print_disabled,
      _ => Icons.info_outline,
    };
  }
}

class SpacerWidget extends StatelessWidget {
  const SpacerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 12);
  }
}
