import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orderman_flutter/core/constants/app_constants.dart';
import 'package:orderman_flutter/features/auth/data/auth_repository.dart';
import 'package:orderman_flutter/features/auth/domain/user_model.dart';

class AuthState {
  const AuthState({
    this.enteredPin = '',
    this.isLoading = false,
    this.errorMessage,
    this.currentUser,
  });

  final String enteredPin;
  final bool isLoading;
  final String? errorMessage;
  final UserModel? currentUser;

  bool get isAuthenticated => currentUser != null;

  AuthState copyWith({
    String? enteredPin,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    UserModel? currentUser,
    bool clearUser = false,
  }) {
    return AuthState(
      enteredPin: enteredPin ?? this.enteredPin,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      currentUser: clearUser ? null : (currentUser ?? this.currentUser),
    );
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return InMemoryAuthRepository();
});

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  Future<void> addDigit(String digit) async {
    if (state.isLoading || state.enteredPin.length >= AppConstants.pinLength) {
      return;
    }

    final nextPin = '${state.enteredPin}$digit';
    state = state.copyWith(enteredPin: nextPin, clearError: true);

    if (nextPin.length == AppConstants.pinLength) {
      await _loginWithPin(nextPin);
    }
  }

  void removeLastDigit() {
    if (state.isLoading || state.enteredPin.isEmpty) {
      return;
    }

    final nextPin = state.enteredPin.substring(0, state.enteredPin.length - 1);
    state = state.copyWith(enteredPin: nextPin, clearError: true);
  }

  void resetPin() {
    state = state.copyWith(enteredPin: '', clearError: true);
  }

  Future<void> _loginWithPin(String pin) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final repository = ref.read(authRepositoryProvider);
    final user = await repository.loginWithPin(pin);

    if (user == null) {
      state = state.copyWith(
        enteredPin: '',
        isLoading: false,
        errorMessage: 'PIN ungültig. Bitte erneut versuchen.',
        clearUser: true,
      );
      return;
    }

    state = state.copyWith(
      enteredPin: '',
      isLoading: false,
      currentUser: user,
      clearError: true,
    );
  }

  void logout() {
    state = const AuthState();
  }
}
