import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Register use case — encapsulates registration business logic.
class RegisterUseCase {
  final AuthRepository _repository;

  const RegisterUseCase(this._repository);

  Future<UserEntity> call({
    required String email,
    required String password,
    String? referralCode,
  }) {
    return _repository.register(
      email: email,
      password: password,
      referralCode: referralCode,
    );
  }
}
