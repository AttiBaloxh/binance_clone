import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';

/// Auto-scrolling promotional banner carousel.
class BinanceBanner extends StatefulWidget {
  final List<BannerItem> items;
  final double height;
  final Duration autoScrollDuration;

  const BinanceBanner({
    super.key,
    required this.items,
    this.height = 120,
    this.autoScrollDuration = const Duration(seconds: 4),
  });

  @override
  State<BinanceBanner> createState() => _BinanceBannerState();
}

class _BinanceBannerState extends State<BinanceBanner> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(widget.autoScrollDuration, () {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % widget.items.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildBannerItem(widget.items[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Page indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.items.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentPage == index ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppColors.primaryYellow
                    : AppColors.textDisabled,
                borderRadius: AppRadius.borderRadiusCircular,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBannerItem(BannerItem item) {
    return Container(
      decoration: BoxDecoration(
        gradient: item.gradient ??
            LinearGradient(
              colors: [
                item.color ?? AppColors.primaryYellow,
                (item.color ?? AppColors.primaryYellow).withValues(alpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        borderRadius: AppRadius.borderRadiusMedium,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          if (item.subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              item.subtitle!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Data model for banner items.
class BannerItem {
  final String title;
  final String? subtitle;
  final Color? color;
  final LinearGradient? gradient;
  final VoidCallback? onTap;

  const BannerItem({
    required this.title,
    this.subtitle,
    this.color,
    this.gradient,
    this.onTap,
  });
}
