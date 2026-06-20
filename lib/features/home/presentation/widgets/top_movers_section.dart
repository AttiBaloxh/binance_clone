import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/binance_coin_tile.dart';
import '../../../../core/widgets/binance_tab_bar.dart';
import '../providers/home_provider.dart';

/// Top movers section with Gainers/Losers/Trending tabs.
class TopMoversSection extends StatelessWidget {
  const TopMoversSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return Container(
          color: AppColors.darkBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header with tabs
              Padding(
                padding: AppSpacing.paddingHorizontalLg,
                child: Text('Top Movers', style: AppTypography.heading3),
              ),
              AppSpacing.verticalMd,

              BinanceTabBar(
                tabs: const ['🔥 Gainers', '📉 Losers', '📊 Trending'],
                selectedIndex: provider.marketTabIndex,
                onTabChanged: provider.setMarketTab,
                style: TabBarStyle.pill,
              ),

              AppSpacing.verticalSm,

              // Column headers
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text('Name', style: AppTypography.caption),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Chart',
                        style: AppTypography.caption,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Price / Change',
                        style: AppTypography.caption,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: AppColors.divider, height: 1),

              // Coin list
              ...provider.activeMarketList.take(5).map((coin) {
                return BinanceCoinTile(
                  symbol: coin.symbol,
                  name: coin.name,
                  price: coin.price,
                  changePercent: coin.changePercent,
                  chartData: coin.sparkline,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
