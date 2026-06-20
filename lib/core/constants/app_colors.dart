import 'package:flutter/material.dart';

/// Binance-inspired color palette.
/// All colors are defined as constants for consistent usage
/// across the entire application.
class AppColors {
  AppColors._();

  // ──────────────────────────────────────
  // Primary Brand Colors
  // ──────────────────────────────────────
  static const Color primaryYellow = Color(0xFFF0B90B);
  static const Color primaryYellowDark = Color(0xFFD4A307);
  static const Color primaryYellowLight = Color(0xFFFCD535);

  // ──────────────────────────────────────
  // Background Colors
  // ──────────────────────────────────────
  static const Color darkBackground = Color(0xFF0B0E11);
  static const Color secondaryBackground = Color(0xFF1E2329);
  static const Color cardBackground = Color(0xFF2B3139);
  static const Color surfaceBackground = Color(0xFF181A20);
  static const Color inputBackground = Color(0xFF2B3139);
  static const Color elevatedBackground = Color(0xFF333B44);

  // ──────────────────────────────────────
  // Semantic Colors
  // ──────────────────────────────────────
  static const Color green = Color(0xFF03A66D);
  static const Color greenLight = Color(0xFF0ECB81);
  static const Color greenDark = Color(0xFF02854E);
  static const Color red = Color(0xFFF6465D);
  static const Color redLight = Color(0xFFFF707E);
  static const Color redDark = Color(0xFFCF304A);

  // ──────────────────────────────────────
  // Text Colors
  // ──────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFFEAECEF);
  static const Color textSecondary = Color(0xFFB7BDC6);
  static const Color textTertiary = Color(0xFF848E9C);
  static const Color textDisabled = Color(0xFF5E6673);
  static const Color textLink = Color(0xFFF0B90B);

  // ──────────────────────────────────────
  // Border & Divider Colors
  // ──────────────────────────────────────
  static const Color border = Color(0xFF2B3139);
  static const Color borderLight = Color(0xFF333B44);
  static const Color divider = Color(0xFF2B3139);

  // ──────────────────────────────────────
  // Overlay & Shadow
  // ──────────────────────────────────────
  static const Color overlay = Color(0x80000000);
  static const Color shadow = Color(0x40000000);

  // ──────────────────────────────────────
  // Chart-specific Colors
  // ──────────────────────────────────────
  static const Color chartGreen = Color(0xFF03A66D);
  static const Color chartRed = Color(0xFFF6465D);
  static const Color chartLine = Color(0xFFF0B90B);
  static const Color chartGrid = Color(0xFF2B3139);

  // ──────────────────────────────────────
  // Gradient Presets
  // ──────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryYellow, primaryYellowLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [greenDark, green],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient redGradient = LinearGradient(
    colors: [redDark, red],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [darkBackground, secondaryBackground],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
