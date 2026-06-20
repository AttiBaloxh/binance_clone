import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/binance_app_bar.dart';
import '../../../../core/widgets/binance_button.dart';
import '../../../../core/widgets/binance_text_field.dart';

/// Withdraw screen.
class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: const BinanceAppBar(title: 'Withdraw', showBack: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BinanceTextField(label: 'Coin', hint: 'Select coin'),
            AppSpacing.verticalLg,
            const BinanceTextField(
              label: 'Address',
              hint: 'Enter withdraw address',
            ),
            AppSpacing.verticalLg,
            const BinanceTextField(label: 'Network', hint: 'Select network'),
            AppSpacing.verticalLg,
            const BinanceTextField(
              label: 'Amount',
              hint: '0.00',
              keyboardType: TextInputType.number,
            ),
            AppSpacing.verticalSm,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Available: 0.15234500 BTC', style: AppTypography.caption),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Max',
                    style: AppTypography.label.copyWith(
                      color: AppColors.primaryYellow,
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.verticalLg,
            // Fee info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _feeRow('Network Fee', '0.00005 BTC'),
                  _feeRow('Minimum Withdrawal', '0.0001 BTC'),
                  _feeRow('You Will Receive', '≈ 0.15229500 BTC'),
                ],
              ),
            ),
            const Spacer(),
            BinanceButton(text: 'Withdraw', onPressed: () {}),
            AppSpacing.verticalLg,
          ],
        ),
      ),
    );
  }

  static Widget _feeRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.caption),
          Text(value, style: AppTypography.bodyMedium.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}
