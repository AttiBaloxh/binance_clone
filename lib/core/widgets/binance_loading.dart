import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/app_typography.dart';

/// Binance-styled loading indicators.
class BinanceLoading extends StatelessWidget {
  final double size;
  final Color? color;
  final String? message;

  const BinanceLoading({
    super.key,
    this.size = 32,
    this.color,
    this.message,
  });

  /// Full-screen loading overlay.
  const BinanceLoading.fullScreen({
    super.key,
    this.size = 40,
    this.color,
    this.message = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    final indicator = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppColors.primaryYellow,
        ),
      ),
    );

    if (message != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            indicator,
            const SizedBox(height: 16),
            Text(
              message!,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      );
    }

    return Center(child: indicator);
  }
}

/// Inline loading dot animation.
class BinanceLoadingDots extends StatefulWidget {
  const BinanceLoadingDots({super.key});

  @override
  State<BinanceLoadingDots> createState() => _BinanceLoadingDotsState();
}

class _BinanceLoadingDotsState extends State<BinanceLoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final delay = index * 0.2;
            final opacity = ((_controller.value - delay) % 1.0).clamp(0.0, 1.0);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.primaryYellow.withValues(alpha: 0.3 + (opacity * 0.7)),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}
