import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/binance_app_bar.dart';
import '../../../../core/widgets/binance_balance_card.dart';
import '../../../../core/widgets/binance_button.dart';
import '../../../../core/widgets/binance_tab_bar.dart';

/// Wallet overview screen.
class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _hideBalance = false;
  int _walletTab = 0;
  final _walletTabs = ['Spot', 'Funding', 'Futures'];

  // Mock wallet data
  final _assets = [
    _WalletAsset('BTC', 'Bitcoin', 0.15234500, 67543.21),
    _WalletAsset('ETH', 'Ethereum', 2.34560000, 3521.87),
    _WalletAsset('BNB', 'BNB', 5.12300000, 612.45),
    _WalletAsset('SOL', 'Solana', 25.00000000, 178.32),
    _WalletAsset('USDT', 'Tether', 5000.00000000, 1.00),
    _WalletAsset('XRP', 'XRP', 1500.00000000, 0.6234),
    _WalletAsset('ADA', 'Cardano', 3000.00000000, 0.4521),
    _WalletAsset('DOGE', 'Dogecoin', 10000.00000000, 0.1567),
  ];

  double get _totalBalance => _assets.fold(0, (sum, a) => sum + a.value);
  double get _totalBtc => _totalBalance / 67543.21;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: BinanceAppBar(
        title: 'Wallet',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.history, color: AppColors.textSecondary),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Balance card
          Padding(
            padding: AppSpacing.paddingHorizontalLg,
            child: BinanceBalanceCard(
              totalBalance: _totalBalance,
              btcBalance: _totalBtc,
              isHidden: _hideBalance,
              onToggleVisibility: () {
                setState(() => _hideBalance = !_hideBalance);
              },
            ),
          ),

          AppSpacing.verticalLg,

          // Action buttons
          Padding(
            padding: AppSpacing.paddingHorizontalLg,
            child: Row(
              children: [
                _actionButton('Deposit', Icons.arrow_downward_rounded, () {
                  context.pushNamed(RouteNames.deposit);
                }),
                AppSpacing.horizontalSm,
                _actionButton('Withdraw', Icons.arrow_upward_rounded, () {
                  context.pushNamed(RouteNames.withdraw);
                }),
                AppSpacing.horizontalSm,
                _actionButton('Transfer', Icons.swap_horiz_rounded, () {
                  context.pushNamed(RouteNames.transfer);
                }),
              ],
            ),
          ),

          AppSpacing.verticalXxl,

          // Wallet tabs
          BinanceTabBar(
            tabs: _walletTabs,
            selectedIndex: _walletTab,
            onTabChanged: (i) => setState(() => _walletTab = i),
            style: TabBarStyle.underline,
          ),
          AppSpacing.verticalSm,

          // Column headers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Asset', style: AppTypography.caption),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Amount',
                    style: AppTypography.caption,
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Value',
                    style: AppTypography.caption,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: AppColors.divider, height: 1),

          // Asset list
          ..._assets.map((asset) => _buildAssetTile(asset)),

          AppSpacing.verticalXxxl,
        ],
      ),
    );
  }

  Widget _actionButton(String label, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: BinanceButton(
        text: label,
        icon: icon,
        variant: BinanceButtonVariant.secondary,
        height: 40,
        onPressed: onTap,
      ),
    );
  }

  Widget _buildAssetTile(_WalletAsset asset) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.elevatedBackground,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  asset.symbol.substring(0, 2),
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primaryYellow,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            AppSpacing.horizontalMd,

            // Symbol & Name
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    asset.symbol,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(asset.name, style: AppTypography.caption),
                ],
              ),
            ),

            // Amount
            Expanded(
              flex: 3,
              child: Text(
                _hideBalance ? '****' : asset.amount.toStringAsFixed(8),
                style: AppTypography.priceSmall.copyWith(fontSize: 13),
                textAlign: TextAlign.right,
              ),
            ),

            // Value
            Expanded(
              flex: 3,
              child: Text(
                _hideBalance ? '****' : Formatters.formatUsd(asset.value),
                style: AppTypography.priceSmall.copyWith(fontSize: 13),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletAsset {
  final String symbol;
  final String name;
  final double amount;
  final double price;

  _WalletAsset(this.symbol, this.name, this.amount, this.price);

  double get value => amount * price;
}
