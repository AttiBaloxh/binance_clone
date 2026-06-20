/// API configuration constants.
class ApiConstants {
  ApiConstants._();

  // Base URL (mock — swap for real Binance API in production)
  static const String baseUrl = 'https://api.binance.com';
  static const String wsUrl = 'wss://stream.binance.com:9443/ws';

  // Timeouts
  static const int connectTimeout = 15000; // ms
  static const int receiveTimeout = 15000; // ms
  static const int sendTimeout = 10000; // ms

  // Endpoints
  static const String ticker24h = '/api/v3/ticker/24hr';
  static const String klines = '/api/v3/klines';
  static const String depth = '/api/v3/depth';
  static const String trades = '/api/v3/trades';
  static const String exchangeInfo = '/api/v3/exchangeInfo';
  static const String tickerPrice = '/api/v3/ticker/price';

  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
}
