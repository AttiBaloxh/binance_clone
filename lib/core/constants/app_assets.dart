/// Asset paths referenced throughout the application.
class AppAssets {
  AppAssets._();

  // ──────────────────────────────────────
  // Icons
  // ──────────────────────────────────────
  static const String iconsPath = 'assets/icons/';

  // ──────────────────────────────────────
  // Images
  // ──────────────────────────────────────
  static const String imagesPath = 'assets/images/';

  // ──────────────────────────────────────
  // Crypto Icon URL (CoinGecko CDN placeholder)
  // ──────────────────────────────────────
  static String cryptoIcon(String symbol) {
    final name = _symbolToName[symbol.toUpperCase()] ?? symbol.toLowerCase();
    return 'https://assets.coingecko.com/coins/images/1/small/$name.png';
  }

  static const Map<String, String> _symbolToName = {
    'BTC': 'bitcoin',
    'ETH': 'ethereum',
    'BNB': 'binancecoin',
    'SOL': 'solana',
    'XRP': 'ripple',
    'ADA': 'cardano',
    'DOGE': 'dogecoin',
    'DOT': 'polkadot',
    'AVAX': 'avalanche-2',
    'MATIC': 'matic-network',
    'LINK': 'chainlink',
    'UNI': 'uniswap',
    'ATOM': 'cosmos',
    'LTC': 'litecoin',
    'FIL': 'filecoin',
    'NEAR': 'near',
    'APT': 'aptos',
    'ARB': 'arbitrum',
    'OP': 'optimism',
    'SUI': 'sui',
  };
}
