import 'package:flutter/material.dart';

/// Consistent border radius system.
class AppRadius {
  AppRadius._();

  // ──────────────────────────────────────
  // Raw Values
  // ──────────────────────────────────────
  static const double small = 8.0;
  static const double medium = 12.0;
  static const double large = 16.0;
  static const double extraLarge = 24.0;
  static const double circular = 100.0;

  // ──────────────────────────────────────
  // BorderRadius Helpers
  // ──────────────────────────────────────
  static final BorderRadius borderRadiusSmall =
      BorderRadius.circular(small);
  static final BorderRadius borderRadiusMedium =
      BorderRadius.circular(medium);
  static final BorderRadius borderRadiusLarge =
      BorderRadius.circular(large);
  static final BorderRadius borderRadiusExtraLarge =
      BorderRadius.circular(extraLarge);
  static final BorderRadius borderRadiusCircular =
      BorderRadius.circular(circular);

  // ──────────────────────────────────────
  // Top-only radius (for bottom sheets, modals)
  // ──────────────────────────────────────
  static const BorderRadius topLarge = BorderRadius.only(
    topLeft: Radius.circular(large),
    topRight: Radius.circular(large),
  );

  static const BorderRadius topExtraLarge = BorderRadius.only(
    topLeft: Radius.circular(extraLarge),
    topRight: Radius.circular(extraLarge),
  );
}
