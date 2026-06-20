import 'package:flutter/material.dart';

/// Global navigation service for navigating without BuildContext.
/// Useful for deep linking and navigation from services/providers.
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  static BuildContext? get context => navigatorKey.currentContext;
}
