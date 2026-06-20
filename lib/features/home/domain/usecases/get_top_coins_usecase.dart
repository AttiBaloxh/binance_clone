import '../entities/coin_entity.dart';
import '../repositories/home_repository.dart';

class GetTopCoinsUseCase {
  final HomeRepository _repository;
  const GetTopCoinsUseCase(this._repository);
  Future<List<CoinEntity>> call() => _repository.getTopCoins();
}
