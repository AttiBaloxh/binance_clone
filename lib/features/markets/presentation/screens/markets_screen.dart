import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/binance_app_bar.dart';
import '../../../../core/widgets/binance_coin_tile.dart';
import '../../../../core/widgets/binance_tab_bar.dart';
import '../../../../core/widgets/binance_loading.dart';
import '../../../home/presentation/providers/home_provider.dart';

/// Full markets screen with Spot/Futures/New Listings/Watchlist tabs.
class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen>
    with SingleTickerProviderStateMixin {
  int _mainTabIndex = 0;
  int _subTabIndex = 0;
  String _searchQuery = '';
  final _searchController = TextEditingController();
  final Set<String> _favorites = {};

  final _mainTabs = ['Spot', 'Futures', 'New Listings', '⭐ Watchlist'];
  final _subTabs = ['USDT', 'BTC', 'ETH', 'BNB', 'ALTS'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: const BinanceAppBar(
        title: 'Markets',
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.search, color: AppColors.textSecondary),
          ),
        ],
      ),
      body: Column(
        children: [
          // Main tabs
          BinanceTabBar(
            tabs: _mainTabs,
            selectedIndex: _mainTabIndex,
            onTabChanged: (i) => setState(() => _mainTabIndex = i),
            style: TabBarStyle.underline,
          ),

          // Sub tabs (only for Spot)
          if (_mainTabIndex == 0) ...[
            AppSpacing.verticalSm,
            BinanceTabBar(
              tabs: _subTabs,
              selectedIndex: _subTabIndex,
              onTabChanged: (i) => setState(() => _subTabIndex = i),
              style: TabBarStyle.pill,
            ),
          ],

          AppSpacing.verticalSm,

          // Column headers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text('Name', style: AppTypography.caption),
                        const Icon(Icons.unfold_more, size: 14, color: AppColors.textDisabled),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Vol',
                    style: AppTypography.caption,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Price', style: AppTypography.caption),
                        const Icon(Icons.unfold_more, size: 14, color: AppColors.textDisabled),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 28),
              ],
            ),
          ),

          const Divider(color: AppColors.divider, height: 1),

          // Market list
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const BinanceLoading.fullScreen();
                }

                var coins = provider.topCoins;

                // Filter for watchlist
                if (_mainTabIndex == 3) {
                  coins = coins.where((c) => _favorites.contains(c.symbol)).toList();
                  if (coins.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_border,
                            size: 48,
                            color: AppColors.textDisabled,
                          ),
                          AppSpacing.verticalLg,
                          Text(
                            'No favorites yet',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                          AppSpacing.verticalSm,
                          Text(
                            'Tap the star to add coins to watchlist',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    );
                  }
                }

                // Filter by search
                if (_searchQuery.isNotEmpty) {
                  coins = coins.where((c) =>
                    c.symbol.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                    c.name.toLowerCase().contains(_searchQuery.toLowerCase())
                  ).toList();
                }

                return ListView.separated(
                  itemCount: coins.length,
                  separatorBuilder: (_, __) => const Divider(
                    color: AppColors.divider,
                    height: 0.5,
                    indent: 16,
                  ),
                  itemBuilder: (context, index) {
                    final coin = coins[index];
                    return BinanceCoinTile(
                      symbol: coin.symbol,
                      name: coin.name,
                      price: coin.price,
                      changePercent: coin.changePercent,
                      chartData: coin.sparkline,
                      isFavorite: _favorites.contains(coin.symbol),
                      onFavoriteToggle: () {
                        setState(() {
                          if (_favorites.contains(coin.symbol)) {
                            _favorites.remove(coin.symbol);
                          } else {
                            _favorites.add(coin.symbol);
                          }
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
