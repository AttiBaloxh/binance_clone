import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Small sparkline chart widget using CustomPainter.
/// Used in coin tiles and market cards.
class MiniChart extends StatelessWidget {
  final List<double> data;
  final Color? color;
  final double strokeWidth;
  final bool showGradient;

  const MiniChart({
    super.key,
    required this.data,
    this.color,
    this.strokeWidth = 1.5,
    this.showGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    final isPositive = data.last >= data.first;
    final chartColor = color ?? (isPositive ? AppColors.green : AppColors.red);

    return CustomPaint(
      size: Size.infinite,
      painter: _MiniChartPainter(
        data: data,
        color: chartColor,
        strokeWidth: strokeWidth,
        showGradient: showGradient,
      ),
    );
  }
}

class _MiniChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;
  final double strokeWidth;
  final bool showGradient;

  _MiniChartPainter({
    required this.data,
    required this.color,
    required this.strokeWidth,
    required this.showGradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final minValue = data.reduce((a, b) => a < b ? a : b);
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final range = maxValue - minValue;
    if (range == 0) return;

    final path = Path();
    final stepX = size.width / (data.length - 1);

    for (var i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - ((data[i] - minValue) / range * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // Gradient fill below the line
    if (showGradient) {
      final gradientPath = Path.from(path);
      gradientPath.lineTo(size.width, size.height);
      gradientPath.lineTo(0, size.height);
      gradientPath.close();

      final gradientPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      canvas.drawPath(gradientPath, gradientPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MiniChartPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
