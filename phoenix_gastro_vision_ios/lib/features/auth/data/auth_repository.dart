import 'package:orderman_flutter/features/auth/domain/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> loginWithPin(String pin);
}

class InMemoryAuthRepository implements AuthRepository {
  InMemoryAuthRepository()
    : _users = const [
        UserModel(
          id: 'w-001',
          name: 'Max',
          pin: '1234',
          role: UserRole.waiter,
          allowedTableNumbers: [1, 2, 3, 4, 5, 6],
        ),
        UserModel(
          id: 'w-002',
          name: 'Anna',
          pin: '2580',
          role: UserRole.waiter,
          allowedTableNumbers: [7, 8, 9, 10, 11, 12],
        ),
        UserModel(
          id: 'a-001',
          name: 'Manager',
          pin: '0000',
          role: UserRole.admin,
          allowedTableNumbers: [],
        ),
      ];

  final List<UserModel> _users;

  @override
  Future<UserModel?> loginWithPin(String pin) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    for (final user in _users) {
      if (user.pin == pin) {
        return user;
      }
    }
    return null;
  }
}
