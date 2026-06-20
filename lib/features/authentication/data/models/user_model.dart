import '../../domain/entities/user_entity.dart';

/// User data transfer object — maps between API/JSON and domain entity.
class UserModel {
  final String id;
  final String email;
  final String? phone;
  final String? displayName;
  final bool isVerified;
  final bool has2FA;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.email,
    this.phone,
    this.displayName,
    this.isVerified = false,
    this.has2FA = false,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      displayName: json['displayName'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      has2FA: json['has2FA'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'displayName': displayName,
      'isVerified': isVerified,
      'has2FA': has2FA,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      phone: phone,
      displayName: displayName,
      isVerified: isVerified,
      has2FA: has2FA,
      createdAt: createdAt,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      phone: entity.phone,
      displayName: entity.displayName,
      isVerified: entity.isVerified,
      has2FA: entity.has2FA,
      createdAt: entity.createdAt,
    );
  }
}
