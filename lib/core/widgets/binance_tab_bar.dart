import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/app_typography.dart';

/// Custom tab bar matching Binance's underline/pill style.
class BinanceTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final bool isScrollable;
  final TabBarStyle style;

  const BinanceTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.isScrollable = false,
    this.style = TabBarStyle.underline,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTabChanged(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: style == TabBarStyle.pill && isSelected
                    ? AppColors.primaryYellow.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: style == TabBarStyle.underline
                    ? Border(
                        bottom: BorderSide(
                          color: isSelected
                              ? AppColors.primaryYellow
                              : Colors.transparent,
                          width: 2,
                        ),
                      )
                    : null,
              ),
              child: Text(
                tabs[index],
                style: isSelected
                    ? AppTypography.tabLabelActive.copyWith(
                        color: style == TabBarStyle.pill
                            ? AppColors.primaryYellow
                            : AppColors.textPrimary,
                      )
                    : AppTypography.tabLabel,
              ),
            ),
          );
        },
      ),
    );
  }
}

enum TabBarStyle { underline, pill }
