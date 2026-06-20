import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/binance_app_bar.dart';
import '../../../../core/widgets/binance_button.dart';
import '../../../../core/widgets/binance_text_field.dart';

/// Transfer between wallets (Spot, Funding, Futures).
class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  String _from = 'Spot';
  String _to = 'Futures';

  void _swapWallets() {
    setState(() {
      final temp = _from;
      _from = _to;
      _to = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: const BinanceAppBar(title: 'Transfer', showBack: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // From/To with swap
            Row(
              children: [
                Expanded(
                  child: _walletSelector('From', _from),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: _swapWallets,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(
                        Icons.swap_horiz,
                        color: AppColors.primaryYellow,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _walletSelector('To', _to),
                ),
              ],
            ),

            AppSpacing.verticalXxl,

            const BinanceTextField(
              label: 'Coin',
              hint: 'Select coin',
            ),
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
                Text('Available: 5,000.00 USDT', style: AppTypography.caption),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Max',
                    style: AppTypography.label.copyWith(color: AppColors.primaryYellow),
                  ),
                ),
              ],
            ),

            const Spacer(),

            BinanceButton(text: 'Confirm Transfer', onPressed: () {}),
            AppSpacing.verticalLg,
          ],
        ),
      ),
    );
  }

  Widget _walletSelector(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.caption),
          const SizedBox(height: 4),
          Text(value, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
