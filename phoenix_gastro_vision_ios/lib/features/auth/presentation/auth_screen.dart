import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/core/branding/branding_config.dart';
import 'package:orderman_flutter/core/constants/app_constants.dart';
import 'package:orderman_flutter/features/auth/presentation/auth_providers.dart';
import 'package:orderman_flutter/features/auth/presentation/pin_pad_widget.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _LoginView(
                state: state,
                onDigitTap: controller.addDigit,
                onBackspaceTap: controller.removeLastDigit,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView({
    required this.state,
    required this.onDigitTap,
    required this.onBackspaceTap,
  });

  final AuthState state;
  final ValueChanged<String> onDigitTap;
  final VoidCallback onBackspaceTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                BrandingConfig.current.fullBrandName,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                BrandingConfig.current.texts.loginPrompt,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                BrandingConfig.current.company.legalName,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              if (state.errorMessage != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(state.errorMessage!),
                ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: PinPadWidget(
                enteredPinLength: state.enteredPin.length,
                pinLength: AppConstants.pinLength,
                isLoading: state.isLoading,
                onDigitTap: onDigitTap,
                onBackspaceTap: onBackspaceTap,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
