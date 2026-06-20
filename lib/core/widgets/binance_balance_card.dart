import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../theme/app_typography.dart';
import '../utils/formatters.dart';

/// Balance display card with hide/show toggle.
class BinanceBalanceCard extends StatelessWidget {
  final double totalBalance;
  final double btcBalance;
  final bool isHidden;
  final VoidCallback? onToggleVisibility;
  final String currency;

  const BinanceBalanceCard({
    super.key,
    required this.totalBalance,
    required this.btcBalance,
    this.isHidden = false,
    this.onToggleVisibility,
    this.currency = 'USD',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondaryBackground,
            AppColors.cardBackground.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with eye toggle
          Row(
            children: [
              Text(
                'Estimated Balance',
                style: AppTypography.caption,
              ),
              AppSpacing.horizontalSm,
              GestureDetector(
                onTap: onToggleVisibility,
                child: Icon(
                  isHidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textTertiary,
                  size: 18,
                ),
              ),
            ],
          ),
          AppSpacing.verticalMd,

          // Total balance
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isHidden ? '****' : Formatters.formatPrice(totalBalance),
                style: AppTypography.balanceLarge,
              ),
              AppSpacing.horizontalSm,
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  currency,
                  style: AppTypography.caption.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.verticalXs,

          // BTC equivalent
          Text(
            isHidden ? '≈ **** BTC' : '≈ ${btcBalance.toStringAsFixed(8)} BTC',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
