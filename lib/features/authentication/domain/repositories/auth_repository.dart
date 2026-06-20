import '../entities/user_entity.dart';

/// Abstract auth repository — domain contract.
abstract class AuthRepository {
  Future<UserEntity> login({required String email, required String password});
  Future<UserEntity> register({
    required String email,
    required String password,
    String? referralCode,
  });
  Future<bool> verifyOtp({required String email, required String otp});
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<UserEntity?> getCurrentUser();
}
