import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/binance_app_bar.dart';
import '../../../../core/widgets/binance_button.dart';
import '../../../../core/widgets/binance_tab_bar.dart';
import '../../../../core/widgets/binance_text_field.dart';

/// Full trading screen with chart, order book, and trading panel.
class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  String _selectedPair = 'BTC/USDT';
  String _selectedTimeframe = '1H';
  int _orderTypeIndex = 0; // 0: Limit, 1: Market, 2: Stop Limit
  bool _isBuy = true;
  final _priceController = TextEditingController(text: '67,543.21');
  final _amountController = TextEditingController();
  double _sliderValue = 0;

  final _timeframes = ['1m', '5m', '15m', '1H', '4H', '1D', '1W'];
  final _orderTypes = ['Limit', 'Market', 'Stop Limit'];

  // Generate mock candle data
  List<_CandleData> get _candles {
    final random = Random(42);
    final candles = <_CandleData>[];
    double open = 67000;
    for (var i = 0; i < 40; i++) {
      final change = (random.nextDouble() - 0.48) * 300;
      final close = open + change;
      final high = [open, close].reduce(max) + random.nextDouble() * 150;
      final low = [open, close].reduce(min) - random.nextDouble() * 150;
      candles.add(_CandleData(open, high, low, close));
      open = close;
    }
    return candles;
  }

  // Generate mock order book
  List<_OrderBookEntry> get _bids {
    final random = Random(1);
    return List.generate(8, (i) {
      final price = 67543.21 - (i * 5.0) - random.nextDouble() * 3;
      final amount = 0.01 + random.nextDouble() * 2;
      return _OrderBookEntry(price, amount);
    });
  }

  List<_OrderBookEntry> get _asks {
    final random = Random(2);
    return List.generate(8, (i) {
      final price = 67548.50 + (i * 5.0) + random.nextDouble() * 3;
      final amount = 0.01 + random.nextDouble() * 2;
      return _OrderBookEntry(price, amount);
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: BinanceAppBar(
        titleWidget: GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_selectedPair, style: AppTypography.heading3),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.textSecondary),
              AppSpacing.horizontalMd,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '+2.34%',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.candlestick_chart_outlined, size: 22, color: AppColors.textSecondary),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, size: 22, color: AppColors.textSecondary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ─── Candlestick Chart ───
            _buildChart(),

            // ─── Timeframe Selector ───
            _buildTimeframeSelector(),

            const Divider(color: AppColors.divider, height: 1),

            // ─── Order Book ───
            _buildOrderBook(),

            const Divider(color: AppColors.divider, height: 1),

            // ─── Trading Panel ───
            _buildTradingPanel(),

            AppSpacing.verticalXxxl,
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    final candles = _candles;
    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        size: Size.infinite,
        painter: _CandlestickPainter(candles: candles),
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _timeframes.length,
        itemBuilder: (context, index) {
          final tf = _timeframes[index];
          final isSelected = tf == _selectedTimeframe;
          return GestureDetector(
            onTap: () => setState(() => _selectedTimeframe = tf),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryYellow.withValues(alpha: 0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                tf,
                style: AppTypography.labelSmall.copyWith(
                  color: isSelected ? AppColors.primaryYellow : AppColors.textTertiary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderBook() {
    final bids = _bids;
    final asks = _asks.reversed.toList();
    final maxBidAmount = bids.map((e) => e.amount).reduce(max);
    final maxAskAmount = asks.map((e) => e.amount).reduce(max);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Book', style: AppTypography.label.copyWith(fontWeight: FontWeight.w600)),
              Row(
                children: [
                  _obToggle(Icons.view_headline, true),
                  _obToggle(Icons.align_vertical_bottom, false),
                  _obToggle(Icons.align_vertical_top, false),
                ],
              ),
            ],
          ),
          AppSpacing.verticalSm,

          // Headers
          Row(
            children: [
              Expanded(child: Text('Price(USDT)', style: AppTypography.caption)),
              Expanded(child: Text('Amount(BTC)', style: AppTypography.caption, textAlign: TextAlign.right)),
            ],
          ),
          AppSpacing.verticalXs,

          // Asks (sells) - displayed top, reversed
          ...asks.take(6).map((entry) => _buildOrderRow(entry, false, maxAskAmount)),

          // Spread
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '67,543.21',
                  style: AppTypography.price.copyWith(color: AppColors.green, fontSize: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  '≈ \$67,543.21',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),

          // Bids (buys)
          ...bids.take(6).map((entry) => _buildOrderRow(entry, true, maxBidAmount)),
        ],
      ),
    );
  }

  Widget _obToggle(IconData icon, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Icon(icon, size: 18, color: selected ? AppColors.textPrimary : AppColors.textDisabled),
    );
  }

  Widget _buildOrderRow(_OrderBookEntry entry, bool isBid, double maxAmount) {
    final ratio = entry.amount / maxAmount;
    return SizedBox(
      height: 24,
      child: Stack(
        children: [
          Align(
            alignment: isBid ? Alignment.centerLeft : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: ratio.clamp(0.05, 1.0),
              child: Container(
                color: (isBid ? AppColors.green : AppColors.red).withValues(alpha: 0.1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    Formatters.formatPrice(entry.price),
                    style: AppTypography.priceSmall.copyWith(
                      color: isBid ? AppColors.green : AppColors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    entry.amount.toStringAsFixed(5),
                    style: AppTypography.priceSmall.copyWith(fontSize: 12),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTradingPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Buy / Sell toggle
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isBuy = true),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: _isBuy ? AppColors.green : AppColors.cardBackground,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Buy',
                        style: AppTypography.button.copyWith(
                          color: _isBuy ? AppColors.white : AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isBuy = false),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: !_isBuy ? AppColors.red : AppColors.cardBackground,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Sell',
                        style: AppTypography.button.copyWith(
                          color: !_isBuy ? AppColors.white : AppColors.textTertiary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          AppSpacing.verticalLg,

          // Order type selector
          BinanceTabBar(
            tabs: _orderTypes,
            selectedIndex: _orderTypeIndex,
            onTabChanged: (i) => setState(() => _orderTypeIndex = i),
            style: TabBarStyle.pill,
          ),

          AppSpacing.verticalLg,

          // Price input (not for Market order)
          if (_orderTypeIndex != 1) ...[
            BinanceTextField(
              label: 'Price',
              hint: '0.00',
              controller: _priceController,
              keyboardType: TextInputType.number,
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Text('USDT', style: TextStyle(color: AppColors.textTertiary, fontSize: 13)),
              ),
            ),
            AppSpacing.verticalMd,
          ],

          // Amount input
          BinanceTextField(
            label: 'Amount',
            hint: '0.00',
            controller: _amountController,
            keyboardType: TextInputType.number,
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Text('BTC', style: TextStyle(color: AppColors.textTertiary, fontSize: 13)),
            ),
          ),

          AppSpacing.verticalMd,

          // Percentage slider
          Row(
            children: [
              for (final pct in [25, 50, 75, 100])
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _sliderValue = pct / 100),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: _sliderValue >= pct / 100
                            ? (_isBuy ? AppColors.green : AppColors.red).withValues(alpha: 0.2)
                            : AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          '$pct%',
                          style: AppTypography.labelSmall.copyWith(
                            color: _sliderValue >= pct / 100
                                ? (_isBuy ? AppColors.green : AppColors.red)
                                : AppColors.textTertiary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          AppSpacing.verticalLg,

          // Available balance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Available', style: AppTypography.caption),
              Text(
                _isBuy ? '10,000.00 USDT' : '0.15000000 BTC',
                style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),

          AppSpacing.verticalLg,

          // Action button
          BinanceButton(
            text: _isBuy ? 'Buy BTC' : 'Sell BTC',
            variant: _isBuy ? BinanceButtonVariant.buy : BinanceButtonVariant.sell,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// ─── Data Models ───

class _CandleData {
  final double open, high, low, close;
  const _CandleData(this.open, this.high, this.low, this.close);
  bool get isBullish => close >= open;
}

class _OrderBookEntry {
  final double price, amount;
  const _OrderBookEntry(this.price, this.amount);
}

// ─── Candlestick Painter ───

class _CandlestickPainter extends CustomPainter {
  final List<_CandleData> candles;

  _CandlestickPainter({required this.candles});

  @override
  void paint(Canvas canvas, Size size) {
    if (candles.isEmpty) return;

    final allValues = candles.expand((c) => [c.high, c.low]);
    final minPrice = allValues.reduce(min);
    final maxPrice = allValues.reduce(max);
    final range = maxPrice - minPrice;
    if (range == 0) return;

    final candleWidth = (size.width / candles.length) * 0.7;
    final spacing = size.width / candles.length;

    // Grid lines
    final gridPaint = Paint()
      ..color = AppColors.chartGrid.withValues(alpha: 0.3)
      ..strokeWidth = 0.5;

    for (var i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (var i = 0; i < candles.length; i++) {
      final candle = candles[i];
      final x = i * spacing + spacing / 2;

      final highY = size.height - ((candle.high - minPrice) / range * size.height);
      final lowY = size.height - ((candle.low - minPrice) / range * size.height);
      final openY = size.height - ((candle.open - minPrice) / range * size.height);
      final closeY = size.height - ((candle.close - minPrice) / range * size.height);

      final color = candle.isBullish ? AppColors.chartGreen : AppColors.chartRed;

      // Wick
      final wickPaint = Paint()
        ..color = color
        ..strokeWidth = 1;
      canvas.drawLine(Offset(x, highY), Offset(x, lowY), wickPaint);

      // Body
      final bodyPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      final top = candle.isBullish ? closeY : openY;
      final bottom = candle.isBullish ? openY : closeY;
      final bodyHeight = (bottom - top).abs().clamp(1.0, size.height);
      canvas.drawRect(
        Rect.fromLTWH(x - candleWidth / 2, top, candleWidth, bodyHeight),
        bodyPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CandlestickPainter oldDelegate) => true;
}
