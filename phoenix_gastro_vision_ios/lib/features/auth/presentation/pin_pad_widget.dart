import 'package:flutter/material.dart';

class PinPadWidget extends StatelessWidget {
  const PinPadWidget({
    super.key,
    required this.enteredPinLength,
    required this.pinLength,
    required this.isLoading,
    required this.onDigitTap,
    required this.onBackspaceTap,
  });

  final int enteredPinLength;
  final int pinLength;
  final bool isLoading;
  final ValueChanged<String> onDigitTap;
  final VoidCallback onBackspaceTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pinLength,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                index < enteredPinLength ? Icons.circle : Icons.circle_outlined,
                size: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          shrinkWrap: true,
          childAspectRatio: 1.8,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (var i = 1; i <= 9; i++)
              _PinButton(
                label: '$i',
                onPressed: isLoading ? null : () => onDigitTap('$i'),
              ),
            const SizedBox.shrink(),
            _PinButton(
              label: '0',
              onPressed: isLoading ? null : () => onDigitTap('0'),
            ),
            _PinButton(
              icon: Icons.backspace_outlined,
              onPressed: isLoading ? null : onBackspaceTap,
            ),
          ],
        ),
      ],
    );
  }
}

class _PinButton extends StatelessWidget {
  const _PinButton({this.label, this.icon, required this.onPressed});

  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size(96, 56),
        textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      ),
      child: icon != null ? Icon(icon, size: 24) : Text(label ?? ''),
    );
  }
}
