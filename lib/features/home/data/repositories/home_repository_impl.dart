import 'dart:math';
import '../../domain/entities/coin_entity.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/repositories/home_repository.dart';

/// Mock home repository with realistic crypto data.
class HomeRepositoryImpl implements HomeRepository {
  final _random = Random(42);

  List<double> _generateSparkline({int points = 24, double basePrice = 100}) {
    final data = <double>[];
    var current = basePrice;
    for (var i = 0; i < points; i++) {
      current += ((_random.nextDouble() - 0.48) * basePrice * 0.03);
      data.add(current);
    }
    return data;
  }

  @override
  Future<List<CoinEntity>> getTopCoins() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      CoinEntity(symbol: 'BTC', name: 'Bitcoin', price: 67543.21, changePercent: 2.34, volume: 28500000000, marketCap: 1320000000000, sparkline: _generateSparkline(basePrice: 67000)),
      CoinEntity(symbol: 'ETH', name: 'Ethereum', price: 3521.87, changePercent: 1.89, volume: 15200000000, marketCap: 423000000000, sparkline: _generateSparkline(basePrice: 3500)),
      CoinEntity(symbol: 'BNB', name: 'BNB', price: 612.45, changePercent: -0.52, volume: 1800000000, marketCap: 94000000000, sparkline: _generateSparkline(basePrice: 615)),
      CoinEntity(symbol: 'SOL', name: 'Solana', price: 178.32, changePercent: 5.67, volume: 3200000000, marketCap: 78000000000, sparkline: _generateSparkline(basePrice: 170)),
      CoinEntity(symbol: 'XRP', name: 'XRP', price: 0.6234, changePercent: -1.23, volume: 2100000000, marketCap: 34000000000, sparkline: _generateSparkline(basePrice: 0.63)),
      CoinEntity(symbol: 'ADA', name: 'Cardano', price: 0.4521, changePercent: 3.45, volume: 890000000, marketCap: 16000000000, sparkline: _generateSparkline(basePrice: 0.44)),
      CoinEntity(symbol: 'DOGE', name: 'Dogecoin', price: 0.1567, changePercent: 8.91, volume: 1500000000, marketCap: 22000000000, sparkline: _generateSparkline(basePrice: 0.15)),
      CoinEntity(symbol: 'DOT', name: 'Polkadot', price: 7.234, changePercent: -2.18, volume: 450000000, marketCap: 9800000000, sparkline: _generateSparkline(basePrice: 7.3)),
      CoinEntity(symbol: 'AVAX', name: 'Avalanche', price: 38.91, changePercent: 4.56, volume: 680000000, marketCap: 14500000000, sparkline: _generateSparkline(basePrice: 37)),
      CoinEntity(symbol: 'LINK', name: 'Chainlink', price: 15.78, changePercent: 1.34, volume: 520000000, marketCap: 9200000000, sparkline: _generateSparkline(basePrice: 15.5)),
      CoinEntity(symbol: 'MATIC', name: 'Polygon', price: 0.7823, changePercent: -0.87, volume: 410000000, marketCap: 7200000000, sparkline: _generateSparkline(basePrice: 0.79)),
      CoinEntity(symbol: 'UNI', name: 'Uniswap', price: 9.12, changePercent: 2.78, volume: 320000000, marketCap: 5500000000, sparkline: _generateSparkline(basePrice: 8.9)),
      CoinEntity(symbol: 'LTC', name: 'Litecoin', price: 83.45, changePercent: -1.56, volume: 580000000, marketCap: 6200000000, sparkline: _generateSparkline(basePrice: 84)),
      CoinEntity(symbol: 'ATOM', name: 'Cosmos', price: 9.87, changePercent: 3.21, volume: 280000000, marketCap: 3800000000, sparkline: _generateSparkline(basePrice: 9.6)),
      CoinEntity(symbol: 'NEAR', name: 'NEAR Protocol', price: 7.65, changePercent: 6.78, volume: 540000000, marketCap: 8300000000, sparkline: _generateSparkline(basePrice: 7.2)),
      CoinEntity(symbol: 'APT', name: 'Aptos', price: 9.23, changePercent: -3.45, volume: 310000000, marketCap: 4100000000, sparkline: _generateSparkline(basePrice: 9.5)),
      CoinEntity(symbol: 'ARB', name: 'Arbitrum', price: 1.12, changePercent: 4.12, volume: 620000000, marketCap: 3200000000, sparkline: _generateSparkline(basePrice: 1.08)),
      CoinEntity(symbol: 'OP', name: 'Optimism', price: 2.45, changePercent: 2.56, volume: 380000000, marketCap: 2800000000, sparkline: _generateSparkline(basePrice: 2.4)),
      CoinEntity(symbol: 'SUI', name: 'Sui', price: 1.87, changePercent: 12.34, volume: 890000000, marketCap: 2400000000, sparkline: _generateSparkline(basePrice: 1.7)),
      CoinEntity(symbol: 'FIL', name: 'Filecoin', price: 6.12, changePercent: -0.34, volume: 210000000, marketCap: 3100000000, sparkline: _generateSparkline(basePrice: 6.15)),
    ];
  }

  @override
  Future<List<CoinEntity>> getTopGainers() async {
    final coins = await getTopCoins();
    final gainers = coins.where((c) => c.changePercent > 0).toList()
      ..sort((a, b) => b.changePercent.compareTo(a.changePercent));
    return gainers.take(10).toList();
  }

  @override
  Future<List<CoinEntity>> getTopLosers() async {
    final coins = await getTopCoins();
    final losers = coins.where((c) => c.changePercent < 0).toList()
      ..sort((a, b) => a.changePercent.compareTo(b.changePercent));
    return losers.take(10).toList();
  }

  @override
  Future<List<CoinEntity>> getTrending() async {
    final coins = await getTopCoins();
    final trending = List<CoinEntity>.from(coins)
      ..sort((a, b) => b.volume.compareTo(a.volume));
    return trending.take(10).toList();
  }

  @override
  Future<List<NewsEntity>> getNews() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      NewsEntity(id: '1', title: 'Bitcoin Surges Past \$67,000 as Institutional Demand Grows', source: 'CoinDesk', publishedAt: DateTime.now().subtract(const Duration(hours: 2))),
      NewsEntity(id: '2', title: 'Ethereum ETF Approval Expected to Drive Market Rally', source: 'The Block', publishedAt: DateTime.now().subtract(const Duration(hours: 4))),
      NewsEntity(id: '3', title: 'Solana DeFi TVL Reaches All-Time High of \$12 Billion', source: 'Decrypt', publishedAt: DateTime.now().subtract(const Duration(hours: 6))),
      NewsEntity(id: '4', title: 'Binance Launches New Staking Program for BNB Holders', source: 'Binance Blog', publishedAt: DateTime.now().subtract(const Duration(hours: 8))),
      NewsEntity(id: '5', title: 'Federal Reserve Decision Impacts Crypto Markets Globally', source: 'Bloomberg', publishedAt: DateTime.now().subtract(const Duration(hours: 12))),
    ];
  }
}
