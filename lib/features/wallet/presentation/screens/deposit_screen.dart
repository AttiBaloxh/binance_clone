import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/binance_app_bar.dart';

/// Deposit screen with coin selection and address display.
class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: const BinanceAppBar(title: 'Deposit', showBack: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coin selector
            _SelectorRow(label: 'Coin', value: 'BTC  Bitcoin'),
            AppSpacing.verticalLg,
            _SelectorRow(label: 'Network', value: 'Bitcoin (BTC)'),
            AppSpacing.verticalXxl,

            // QR placeholder
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(Icons.qr_code_2, size: 160, color: AppColors.darkBackground),
                ),
              ),
            ),
            AppSpacing.verticalXxl,

            // Address
            Text('Deposit Address', style: AppTypography.label),
            AppSpacing.verticalSm,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
                      style: AppTypography.bodyMedium.copyWith(fontSize: 13),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.copy, size: 20, color: AppColors.primaryYellow),
                  ),
                ],
              ),
            ),

            AppSpacing.verticalLg,

            // Warning
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryYellow.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber, color: AppColors.primaryYellow, size: 20),
                  AppSpacing.horizontalSm,
                  Expanded(
                    child: Text(
                      'Send only BTC to this address. Sending any other coin may result in permanent loss.',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectorRow extends StatelessWidget {
  final String label;
  final String value;

  const _SelectorRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Text(label, style: AppTypography.caption),
            const Spacer(),
            Text(value, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
            AppSpacing.horizontalSm,
            const Icon(Icons.chevron_right, size: 20, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
