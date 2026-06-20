/// Coin entity for the domain layer.
class CoinEntity {
  final String symbol;
  final String name;
  final double price;
  final double changePercent;
  final double volume;
  final double marketCap;
  final List<double> sparkline;

  const CoinEntity({
    required this.symbol,
    required this.name,
    required this.price,
    required this.changePercent,
    this.volume = 0,
    this.marketCap = 0,
    this.sparkline = const [],
  });
}
