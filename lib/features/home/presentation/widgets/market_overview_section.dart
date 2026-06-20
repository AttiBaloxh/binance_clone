import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/binance_market_card.dart';
import '../providers/home_provider.dart';

/// Market overview section showing top 2 coins (BTC, ETH) and horizontal scroll.
class MarketOverviewSection extends StatelessWidget {
  const MarketOverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        final coins = provider.topCoins;
        if (coins.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppSpacing.paddingHorizontalLg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Market Overview', style: AppTypography.heading3),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.verticalSm,
            SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: AppSpacing.paddingHorizontalLg,
                itemCount: coins.length.clamp(0, 8),
                separatorBuilder: (_, __) => AppSpacing.horizontalMd,
                itemBuilder: (context, index) {
                  final coin = coins[index];
                  return BinanceMarketCard(
                    symbol: coin.symbol,
                    pair: 'USDT',
                    price: coin.price,
                    changePercent: coin.changePercent,
                    chartData: coin.sparkline,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
