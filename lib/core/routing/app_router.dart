import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../../features/authentication/presentation/screens/splash_screen.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/markets/presentation/screens/markets_screen.dart';
import '../../features/trade/presentation/screens/trade_screen.dart';
import '../../features/futures/presentation/screens/futures_screen.dart';
import '../../features/wallet/presentation/screens/wallet_screen.dart';
import '../../features/wallet/presentation/screens/deposit_screen.dart';
import '../../features/wallet/presentation/screens/withdraw_screen.dart';
import '../../features/wallet/presentation/screens/transfer_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../constants/app_colors.dart';

/// Application router configuration using GoRouter.
/// Supports deep linking, shell routes for bottom nav, and auth guards.
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splashPath,
    debugLogDiagnostics: true,
    routes: [
      // ──────────────────────────────────────
      // Auth Routes (outside shell)
      // ──────────────────────────────────────
      GoRoute(
        path: RouteNames.splashPath,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.loginPath,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.registerPath,
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      // ──────────────────────────────────────
      // Main App Shell (with bottom nav)
      // ──────────────────────────────────────
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) =>
            _MainShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.homePath,
            name: RouteNames.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: RouteNames.marketsPath,
            name: RouteNames.markets,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MarketsScreen(),
            ),
          ),
          GoRoute(
            path: RouteNames.tradePath,
            name: RouteNames.trade,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TradeScreen(),
            ),
          ),
          GoRoute(
            path: RouteNames.futuresPath,
            name: RouteNames.futures,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FuturesScreen(),
            ),
          ),
          GoRoute(
            path: RouteNames.walletPath,
            name: RouteNames.wallet,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: WalletScreen(),
            ),
            routes: [
              GoRoute(
                path: 'deposit',
                name: RouteNames.deposit,
                builder: (context, state) => const DepositScreen(),
              ),
              GoRoute(
                path: 'withdraw',
                name: RouteNames.withdraw,
                builder: (context, state) => const WithdrawScreen(),
              ),
              GoRoute(
                path: 'transfer',
                name: RouteNames.transfer,
                builder: (context, state) => const TransferScreen(),
              ),
            ],
          ),
        ],
      ),

      // ──────────────────────────────────────
      // Full-screen routes (outside shell)
      // ──────────────────────────────────────
      GoRoute(
        path: RouteNames.profilePath,
        name: RouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RouteNames.notificationsPath,
        name: RouteNames.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: RouteNames.settingsPath,
        name: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}

/// Main shell widget providing bottom navigation bar.
class _MainShell extends StatelessWidget {
  final Widget child;

  const _MainShell({required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(RouteNames.homePath)) return 0;
    if (location.startsWith(RouteNames.marketsPath)) return 1;
    if (location.startsWith(RouteNames.tradePath)) return 2;
    if (location.startsWith(RouteNames.futuresPath)) return 3;
    if (location.startsWith(RouteNames.walletPath)) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(RouteNames.home);
        break;
      case 1:
        context.goNamed(RouteNames.markets);
        break;
      case 2:
        context.goNamed(RouteNames.trade);
        break;
      case 3:
        context.goNamed(RouteNames.futures);
        break;
      case 4:
        context.goNamed(RouteNames.wallet);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surfaceBackground,
          border: Border(
            top: BorderSide(color: AppColors.border, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex(context),
          onTap: (index) => _onTap(context, index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined),
              activeIcon: Icon(Icons.bar_chart),
              label: 'Markets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz_outlined),
              activeIcon: Icon(Icons.swap_horiz),
              label: 'Trade',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.candlestick_chart_outlined),
              activeIcon: Icon(Icons.candlestick_chart),
              label: 'Futures',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: 'Wallets',
            ),
          ],
        ),
      ),
    );
  }
}
