import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';

/// Binance-styled card with dark background.
class BinanceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? color;
  final VoidCallback? onTap;
  final Border? border;

  const BinanceCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        color: color ?? AppColors.cardBackground,
        borderRadius: borderRadius ?? AppRadius.borderRadiusMedium,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? AppRadius.borderRadiusMedium,
          splashColor: AppColors.primaryYellow.withValues(alpha: 0.05),
          highlightColor: AppColors.primaryYellow.withValues(alpha: 0.03),
          child: Container(
            padding: padding ?? AppSpacing.cardPadding,
            decoration: border != null
                ? BoxDecoration(
                    border: border,
                    borderRadius: borderRadius ?? AppRadius.borderRadiusMedium,
                  )
                : null,
            child: child,
          ),
        ),
      ),
    );
  }
}
