import 'package:flutter/material.dart';
import '../../domain/entities/coin_entity.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/repositories/home_repository.dart';

/// Home provider managing all home screen sections.
class HomeProvider extends ChangeNotifier {
  final HomeRepository _repository;

  HomeProvider({required HomeRepository repository})
      : _repository = repository;

  // State
  bool _isLoading = true;
  String? _error;
  List<CoinEntity> _topCoins = [];
  List<CoinEntity> _topGainers = [];
  List<CoinEntity> _topLosers = [];
  List<CoinEntity> _trending = [];
  List<NewsEntity> _news = [];
  int _marketTabIndex = 0; // 0: Gainers, 1: Losers, 2: Trending

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<CoinEntity> get topCoins => _topCoins;
  List<CoinEntity> get topGainers => _topGainers;
  List<CoinEntity> get topLosers => _topLosers;
  List<CoinEntity> get trending => _trending;
  List<NewsEntity> get news => _news;
  int get marketTabIndex => _marketTabIndex;

  List<CoinEntity> get activeMarketList {
    switch (_marketTabIndex) {
      case 0:
        return _topGainers;
      case 1:
        return _topLosers;
      case 2:
        return _trending;
      default:
        return _topGainers;
    }
  }

  void setMarketTab(int index) {
    _marketTabIndex = index;
    notifyListeners();
  }

  /// Load all home data.
  Future<void> loadHomeData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getTopCoins(),
        _repository.getTopGainers(),
        _repository.getTopLosers(),
        _repository.getTrending(),
        _repository.getNews(),
      ]);

      _topCoins = results[0] as List<CoinEntity>;
      _topGainers = results[1] as List<CoinEntity>;
      _topLosers = results[2] as List<CoinEntity>;
      _trending = results[3] as List<CoinEntity>;
      _news = results[4] as List<NewsEntity>;
      _isLoading = false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  /// Refresh data.
  Future<void> refresh() async {
    await loadHomeData();
  }
}
