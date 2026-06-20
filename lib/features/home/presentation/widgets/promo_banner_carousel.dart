import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/binance_banner.dart';

/// Promotional banner carousel on the home screen.
class PromoBannerCarousel extends StatelessWidget {
  const PromoBannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: BinanceBanner(
        items: [
          BannerItem(
            title: 'Trade & Earn Up to 500 USDT',
            subtitle: 'Complete tasks and claim your rewards',
            gradient: LinearGradient(
              colors: [
                AppColors.primaryYellow.withValues(alpha: 0.9),
                AppColors.primaryYellowDark,
              ],
            ),
          ),
          const BannerItem(
            title: 'Futures Grand Tournament',
            subtitle: '500,000 USDT prize pool',
            gradient: LinearGradient(
              colors: [Color(0xFF1a6b3c), Color(0xFF03A66D)],
            ),
          ),
          const BannerItem(
            title: 'Binance Earn: Auto-Invest',
            subtitle: 'Start investing with as low as \$1',
            gradient: LinearGradient(
              colors: [Color(0xFF6F3ADB), Color(0xFF9B6BFF)],
            ),
          ),
          const BannerItem(
            title: 'Copy Trading is Live!',
            subtitle: 'Follow top traders automatically',
            gradient: LinearGradient(
              colors: [Color(0xFFE85D04), Color(0xFFFF8C42)],
            ),
          ),
        ],
      ),
    );
  }
}
