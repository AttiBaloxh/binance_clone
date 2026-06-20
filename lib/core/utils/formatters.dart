import 'package:intl/intl.dart';

/// Financial and general-purpose formatters.
class Formatters {
  Formatters._();

  // ──────────────────────────────────────
  // Currency Formatting
  // ──────────────────────────────────────

  /// Format price with appropriate decimal places.
  /// e.g., 67,543.21 or 0.00001234
  static String formatPrice(double price) {
    if (price >= 1000) {
      return NumberFormat('#,##0.00').format(price);
    } else if (price >= 1) {
      return NumberFormat('0.00').format(price);
    } else if (price >= 0.01) {
      return NumberFormat('0.0000').format(price);
    } else {
      return NumberFormat('0.00000000').format(price);
    }
  }

  /// Format USD amount with $ sign.
  static String formatUsd(double amount) {
    if (amount >= 1000000000) {
      return '\$${(amount / 1000000000).toStringAsFixed(2)}B';
    } else if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(2)}M';
    } else if (amount >= 1000) {
      return '\$${NumberFormat('#,##0.00').format(amount)}';
    } else {
      return '\$${amount.toStringAsFixed(2)}';
    }
  }

  /// Format balance with 8 decimal places (crypto standard).
  static String formatCryptoBalance(double amount) {
    return NumberFormat('0.00000000').format(amount);
  }

  /// Format large number with abbreviation (K, M, B).
  static String abbreviateNumber(double number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(2)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K';
    }
    return number.toStringAsFixed(2);
  }

  // ──────────────────────────────────────
  // Percentage Formatting
  // ──────────────────────────────────────

  /// Format percentage with sign and 2 decimals.
  /// e.g., +5.23% or -2.41%
  static String formatPercentage(double value) {
    final sign = value >= 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(2)}%';
  }

  // ──────────────────────────────────────
  // Date/Time Formatting
  // ──────────────────────────────────────

  static String formatDate(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy HH:mm').format(dateTime);
  }

  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return formatDate(dateTime);
  }

  // ──────────────────────────────────────
  // Wallet Address
  // ──────────────────────────────────────

  /// Truncate wallet address for display.
  /// e.g., 0x1234...abcd
  static String truncateAddress(String address, {int start = 6, int end = 4}) {
    if (address.length <= start + end) return address;
    return '${address.substring(0, start)}...${address.substring(address.length - end)}';
  }
}
