import '../entities/coin_entity.dart';
import '../entities/news_entity.dart';

/// Home repository interface.
abstract class HomeRepository {
  Future<List<CoinEntity>> getTopCoins();
  Future<List<CoinEntity>> getTopGainers();
  Future<List<CoinEntity>> getTopLosers();
  Future<List<CoinEntity>> getTrending();
  Future<List<NewsEntity>> getNews();
}
