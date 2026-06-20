import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/theme/app_typography.dart';

/// Binance-style search bar.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          // TODO: Navigate to search screen
        },
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: AppRadius.borderRadiusSmall,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: AppColors.textDisabled,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Search coins',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textDisabled,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.qr_code_scanner,
                color: AppColors.textTertiary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
