import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/binance_app_bar.dart';
import '../../../../core/widgets/binance_button.dart';
import '../../../../core/widgets/binance_card.dart';
import '../../../../core/widgets/binance_tab_bar.dart';

/// Futures trading screen with positions, PNL, leverage.
class FuturesScreen extends StatefulWidget {
  const FuturesScreen({super.key});

  @override
  State<FuturesScreen> createState() => _FuturesScreenState();
}

class _FuturesScreenState extends State<FuturesScreen> {
  int _tabIndex = 0;
  bool _isBuy = true;
  String _marginMode = 'Cross';
  int _leverage = 20;
  final _tabs = ['USDT-M', 'COIN-M'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: BinanceAppBar(
        titleWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('BTCUSDT Perp', style: AppTypography.heading3),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.textSecondary,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              size: 22,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs
            BinanceTabBar(
              tabs: _tabs,
              selectedIndex: _tabIndex,
              onTabChanged: (i) => setState(() => _tabIndex = i),
              style: TabBarStyle.underline,
            ),

            AppSpacing.verticalLg,

            // Price & PNL Header
            _buildPriceHeader(),

            AppSpacing.verticalLg,

            // Margin & Leverage
            _buildMarginLeverage(),

            AppSpacing.verticalLg,

            // Trading Panel
            _buildTradingPanel(),
            const Divider(color: AppColors.divider, height: 32),

            // Positions
            _buildPositions(),

            AppSpacing.verticalXxxl,
          ],
        ),
      ),
    );
  }

  Widget _buildPriceHeader() {
    return Padding(
      padding: AppSpacing.paddingHorizontalLg,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '67,543.21',
                style: AppTypography.balanceLarge.copyWith(
                  color: AppColors.green,
                  fontSize: 24,
                ),
              ),
              Text(
                '≈ \$67,543.21  +2.34%',
                style: AppTypography.caption.copyWith(
                  color: AppColors.green,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _infoRow('Mark Price', '67,548.30'),
              _infoRow('Index Price', '67,542.15'),
              _infoRow('Funding', '0.0100%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text('$label ', style: AppTypography.caption.copyWith(fontSize: 11)),
          Text(value, style: AppTypography.priceSmall.copyWith(fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildMarginLeverage() {
    return Padding(
      padding: AppSpacing.paddingHorizontalLg,
      child: Row(
        children: [
          // Margin mode
          GestureDetector(
            onTap: () {
              setState(() {
                _marginMode = _marginMode == 'Cross' ? 'Isolated' : 'Cross';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                _marginMode,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.primaryYellow,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          AppSpacing.horizontalSm,

          // Leverage
          GestureDetector(
            onTap: _showLeverageDialog,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                '${_leverage}x',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.primaryYellow,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLeverageDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.secondaryBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Adjust Leverage', style: AppTypography.heading3),
                  AppSpacing.verticalXxl,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_leverage}x',
                      style: AppTypography.displayMedium.copyWith(
                        color: AppColors.primaryYellow,
                      ),
                    ),
                  ),
                  AppSpacing.verticalLg,
                  Slider(
                    value: _leverage.toDouble(),
                    min: 1,
                    max: 125,
                    divisions: 124,
                    activeColor: AppColors.primaryYellow,
                    inactiveColor: AppColors.cardBackground,
                    onChanged: (v) {
                      setModalState(() => _leverage = v.round());
                    },
                  ),
                  // Preset buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [1, 5, 10, 20, 50, 75, 125].map((v) {
                      return GestureDetector(
                        onTap: () => setModalState(() => _leverage = v),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _leverage == v
                                ? AppColors.primaryYellow.withValues(alpha: 0.2)
                                : AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${v}x',
                            style: AppTypography.labelSmall.copyWith(
                              color: _leverage == v
                                  ? AppColors.primaryYellow
                                  : AppColors.textTertiary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  AppSpacing.verticalXxl,
                  BinanceButton(
                    text: 'Confirm',
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTradingPanel() {
    return Padding(
      padding: AppSpacing.paddingHorizontalLg,
      child: Column(
        children: [
          // Buy/Sell toggle
          Row(
            children: [
              Expanded(
                child: BinanceButton(
                  text: 'Long',
                  variant: _isBuy
                      ? BinanceButtonVariant.buy
                      : BinanceButtonVariant.secondary,
                  onPressed: () => setState(() => _isBuy = true),
                  height: 48,
                ),
              ),
              AppSpacing.horizontalSm,
              Expanded(
                child: BinanceButton(
                  text: 'Short',
                  variant: !_isBuy
                      ? BinanceButtonVariant.sell
                      : BinanceButtonVariant.secondary,
                  onPressed: () => setState(() => _isBuy = false),
                  height: 48,
                ),
              ),
            ],
          ),
          AppSpacing.verticalLg,

          // Available margin
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Available Margin', style: AppTypography.caption),
              Text(
                '5,000.00 USDT',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          AppSpacing.verticalLg,

          BinanceButton(
            text: _isBuy ? 'Open Long' : 'Open Short',
            variant: _isBuy
                ? BinanceButtonVariant.buy
                : BinanceButtonVariant.sell,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPositions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.paddingHorizontalLg,
          child: Text('Positions (2)', style: AppTypography.heading3),
        ),
        AppSpacing.verticalMd,

        // Mock position 1
        _buildPositionCard(
          symbol: 'BTCUSDT',
          side: 'Long',
          size: '0.05 BTC',
          entryPrice: 65200.00,
          markPrice: 67543.21,
          pnl: 117.16,
          pnlPercent: 3.59,
          leverage: _leverage,
          liquidationPrice: 52100.00,
        ),

        AppSpacing.verticalSm,

        // Mock position 2
        _buildPositionCard(
          symbol: 'ETHUSDT',
          side: 'Short',
          size: '1.5 ETH',
          entryPrice: 3600.00,
          markPrice: 3521.87,
          pnl: 117.20,
          pnlPercent: 2.17,
          leverage: 10,
          liquidationPrice: 4200.00,
        ),
      ],
    );
  }

  Widget _buildPositionCard({
    required String symbol,
    required String side,
    required String size,
    required double entryPrice,
    required double markPrice,
    required double pnl,
    required double pnlPercent,
    required int leverage,
    required double liquidationPrice,
  }) {
    final isLong = side == 'Long';
    final isProfit = pnl >= 0;

    return BinanceCard(
      margin: AppSpacing.paddingHorizontalLg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: (isLong ? AppColors.green : AppColors.red).withValues(
                    alpha: 0.15,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$side ${leverage}x',
                  style: AppTypography.labelSmall.copyWith(
                    color: isLong ? AppColors.green : AppColors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AppSpacing.horizontalSm,
              Text(
                symbol,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${isProfit ? '+' : ''}\$${pnl.toStringAsFixed(2)}',
                style: AppTypography.price.copyWith(
                  color: isProfit ? AppColors.green : AppColors.red,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          AppSpacing.verticalMd,

          // Details grid
          Row(
            children: [
              _detailCol('Size', size),
              _detailCol('Entry', Formatters.formatPrice(entryPrice)),
              _detailCol('Mark', Formatters.formatPrice(markPrice)),
              _detailCol('Liq.', Formatters.formatPrice(liquidationPrice)),
            ],
          ),
          AppSpacing.verticalMd,

          // PNL %
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ROE', style: AppTypography.caption),
              Text(
                '${isProfit ? '+' : ''}${pnlPercent.toStringAsFixed(2)}%',
                style: AppTypography.bodyMedium.copyWith(
                  color: isProfit ? AppColors.green : AppColors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailCol(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.caption.copyWith(fontSize: 11)),
          const SizedBox(height: 2),
          Text(value, style: AppTypography.priceSmall.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
