import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orderman_flutter/core/theme/phoenix_branding.dart';

class PhoenixTouchFeedback {
  const PhoenixTouchFeedback._();

  static VoidCallback? wrap(
    VoidCallback? onPressed, {
    Future<void> Function()? feedback,
  }) {
    if (onPressed == null) {
      return null;
    }

    return () {
      (feedback ?? HapticFeedback.mediumImpact).call();
      onPressed();
    };
  }
}

class PhoenixPrimaryAction extends StatelessWidget {
  const PhoenixPrimaryAction({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final callback = PhoenixTouchFeedback.wrap(
      onPressed,
      feedback: HapticFeedback.heavyImpact,
    );

    if (icon != null) {
      return FilledButton.icon(
        onPressed: callback,
        icon: icon!,
        label: child,
      );
    }

    return FilledButton(
      onPressed: callback,
      child: child,
    );
  }
}

class PhoenixTonalAction extends StatelessWidget {
  const PhoenixTonalAction({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: PhoenixTouchFeedback.wrap(onPressed),
      style: FilledButton.styleFrom(
        minimumSize: const Size(
          PhoenixBranding.minTouchTarget,
          PhoenixBranding.minTouchTarget,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        textStyle: Theme.of(context).textTheme.labelLarge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: child,
    );
  }
}
