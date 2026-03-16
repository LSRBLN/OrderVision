enum UserRole { waiter, admin }

class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.pin,
    required this.role,
    required this.allowedTableNumbers,
  });

  final String id;
  final String name;
  final String pin;
  final UserRole role;
  final List<int> allowedTableNumbers;

  bool get isAdmin => role == UserRole.admin;
}
