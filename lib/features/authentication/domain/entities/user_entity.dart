/// User entity — clean domain model.
class UserEntity {
  final String id;
  final String email;
  final String? phone;
  final String? displayName;
  final bool isVerified;
  final bool has2FA;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.email,
    this.phone,
    this.displayName,
    this.isVerified = false,
    this.has2FA = false,
    required this.createdAt,
  });
}
