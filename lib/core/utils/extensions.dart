import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Useful Dart extensions for cleaner code.

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.red : AppColors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

extension StringExtensions on String {
  /// Capitalize first letter.
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Convert "BTC" to "Bitcoin" style display name.
  String get symbolToName {
    const map = {
      'BTC': 'Bitcoin',
      'ETH': 'Ethereum',
      'BNB': 'BNB',
      'SOL': 'Solana',
      'XRP': 'XRP',
      'ADA': 'Cardano',
      'DOGE': 'Dogecoin',
      'DOT': 'Polkadot',
      'AVAX': 'Avalanche',
      'MATIC': 'Polygon',
      'LINK': 'Chainlink',
      'UNI': 'Uniswap',
      'ATOM': 'Cosmos',
      'LTC': 'Litecoin',
      'FIL': 'Filecoin',
      'NEAR': 'NEAR Protocol',
      'APT': 'Aptos',
      'ARB': 'Arbitrum',
      'OP': 'Optimism',
      'SUI': 'Sui',
      'USDT': 'Tether',
      'USDC': 'USD Coin',
    };
    return map[toUpperCase()] ?? this;
  }
}

extension NumExtensions on num {
  /// Returns green or red color based on value sign.
  Color get changeColor =>
      this >= 0 ? AppColors.green : AppColors.red;

  /// Duration in milliseconds.
  Duration get ms => Duration(milliseconds: toInt());

  /// Duration in seconds.
  Duration get seconds => Duration(seconds: toInt());
}
