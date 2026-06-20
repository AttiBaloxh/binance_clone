import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../theme/app_typography.dart';
import '../utils/formatters.dart';
import 'mini_chart.dart';

/// Compact market card for horizontal scrolling sections.
class BinanceMarketCard extends StatelessWidget {
  final String symbol;
  final String pair;
  final double price;
  final double changePercent;
  final List<double>? chartData;
  final VoidCallback? onTap;

  const BinanceMarketCard({
    super.key,
    required this.symbol,
    required this.pair,
    required this.price,
    required this.changePercent,
    this.chartData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = changePercent >= 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: AppSpacing.paddingAllLg,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: AppRadius.borderRadiusMedium,
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Symbol & Pair
            Row(
              children: [
                Text(
                  symbol,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '/$pair',
                  style: AppTypography.caption,
                ),
              ],
            ),
            AppSpacing.verticalSm,

            // Price
            Text(
              Formatters.formatPrice(price),
              style: AppTypography.price,
            ),
            AppSpacing.verticalXs,

            // Change %
            Text(
              Formatters.formatPercentage(changePercent),
              style: AppTypography.percentageChange.copyWith(
                color: isPositive ? AppColors.green : AppColors.red,
              ),
            ),
            AppSpacing.verticalSm,

            // Mini chart
            if (chartData != null && chartData!.isNotEmpty)
              SizedBox(
                height: 24,
                width: double.infinity,
                child: MiniChart(
                  data: chartData!,
                  color: isPositive ? AppColors.green : AppColors.red,
                  strokeWidth: 1.2,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
