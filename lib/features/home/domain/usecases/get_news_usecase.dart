import '../entities/news_entity.dart';
import '../repositories/home_repository.dart';

class GetNewsUseCase {
  final HomeRepository _repository;
  const GetNewsUseCase(this._repository);
  Future<List<NewsEntity>> call() => _repository.getNews();
}
