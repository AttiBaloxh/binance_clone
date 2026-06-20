import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../theme/app_typography.dart';

/// Binance-styled button with multiple variants.
///
/// Variants:
/// - primary: Yellow background (default)
/// - secondary: Outlined with border
/// - buy: Green background for buy actions
/// - sell: Red background for sell actions
/// - ghost: Text-only, no background
enum BinanceButtonVariant { primary, secondary, buy, sell, ghost }

class BinanceButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final BinanceButtonVariant variant;
  final bool isLoading;
  final bool isExpanded;
  final IconData? icon;
  final double height;

  const BinanceButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = BinanceButtonVariant.primary,
    this.isLoading = false,
    this.isExpanded = true,
    this.icon,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpanded ? double.infinity : null,
      height: height,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (variant) {
      case BinanceButtonVariant.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryYellow,
            foregroundColor: AppColors.darkBackground,
            disabledBackgroundColor: AppColors.primaryYellow.withValues(
              alpha: 0.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusSmall,
            ),
          ),
          child: _buildChild(AppColors.darkBackground),
        );
      case BinanceButtonVariant.secondary:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            side: const BorderSide(color: AppColors.border, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusSmall,
            ),
          ),
          child: _buildChild(AppColors.textPrimary),
        );
      case BinanceButtonVariant.buy:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusSmall,
            ),
          ),
          child: _buildChild(AppColors.white),
        );
      case BinanceButtonVariant.sell:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderRadiusSmall,
            ),
          ),
          child: _buildChild(AppColors.white),
        );
      case BinanceButtonVariant.ghost:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          child: _buildChild(AppColors.primaryYellow),
        );
    }
  }

  Widget _buildChild(Color textColor) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTypography.button.copyWith(
              color: textColor,
              fontSize: 12,
            ),
          ),
        ],
      );
    }

    return Text(text, style: AppTypography.button.copyWith(color: textColor));
  }
}
