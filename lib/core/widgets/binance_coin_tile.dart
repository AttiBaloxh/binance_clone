import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../theme/app_typography.dart';
import '../utils/formatters.dart';
import 'mini_chart.dart';

/// Coin list tile: icon, symbol/name, price, change %, mini chart, favorite.
class BinanceCoinTile extends StatelessWidget {
  final String symbol;
  final String name;
  final double price;
  final double changePercent;
  final List<double>? chartData;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final String? iconUrl;

  const BinanceCoinTile({
    super.key,
    required this.symbol,
    required this.name,
    required this.price,
    required this.changePercent,
    this.chartData,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteToggle,
    this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = changePercent >= 0;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Coin icon
            _buildCoinIcon(),
            AppSpacing.horizontalMd,

            // Symbol & Name
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    symbol,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    name,
                    style: AppTypography.caption,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Mini Chart
            if (chartData != null && chartData!.isNotEmpty)
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 28,
                  child: MiniChart(
                    data: chartData!,
                    color: isPositive ? AppColors.green : AppColors.red,
                  ),
                ),
              ),

            AppSpacing.horizontalMd,

            // Price & Change
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Formatters.formatPrice(price),
                    style: AppTypography.priceSmall,
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: (isPositive ? AppColors.green : AppColors.red)
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      Formatters.formatPercentage(changePercent),
                      style: AppTypography.labelSmall.copyWith(
                        color: isPositive ? AppColors.green : AppColors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Favorite
            if (onFavoriteToggle != null) ...[
              AppSpacing.horizontalSm,
              GestureDetector(
                onTap: onFavoriteToggle,
                child: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite
                      ? AppColors.primaryYellow
                      : AppColors.textDisabled,
                  size: 20,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCoinIcon() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.elevatedBackground,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Text(
          symbol.length >= 2 ? symbol.substring(0, 2) : symbol,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.primaryYellow,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
