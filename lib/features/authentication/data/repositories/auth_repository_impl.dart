import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/user_model.dart';

/// Mock implementation of AuthRepository.
/// Simulates API calls with delays for realistic UX.
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource _localDatasource;

  AuthRepositoryImpl(this._localDatasource);

  // Mock user for demonstration
  static final _mockUser = UserModel(
    id: 'usr_binance_001',
    email: 'user@binance.com',
    phone: '+1 234 567 8900',
    displayName: 'Binance User',
    isVerified: true,
    has2FA: true,
    createdAt: DateTime(2024, 1, 15),
  );

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Mock validation
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    // Save login state
    await _localDatasource.saveLoginState(
      userId: _mockUser.id,
      email: email,
    );

    return _mockUser.toEntity();
  }

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    String? referralCode,
  }) async {
    await Future.delayed(const Duration(milliseconds: 2000));

    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    final newUser = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      createdAt: DateTime.now(),
    );

    await _localDatasource.saveLoginState(
      userId: newUser.id,
      email: email,
    );

    return newUser.toEntity();
  }

  @override
  Future<bool> verifyOtp({
    required String email,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // Accept any 6-digit code for mock
    return otp.length == 6;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _localDatasource.clearLoginState();
  }

  @override
  Future<bool> isLoggedIn() async {
    return _localDatasource.isLoggedIn;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    if (_localDatasource.isLoggedIn) {
      return _mockUser.toEntity();
    }
    return null;
  }
}
