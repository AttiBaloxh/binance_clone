import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/app_typography.dart';

/// Custom AppBar matching Binance's flat dark design.
class BinanceAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool showBack;
  final VoidCallback? onBackPressed;
  final Widget? leading;
  final Color? backgroundColor;
  final double elevation;

  const BinanceAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.showBack = false,
    this.onBackPressed,
    this.leading,
    this.backgroundColor,
    this.elevation = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.darkBackground,
      elevation: elevation,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              onPressed: onBackPressed ?? () => Navigator.maybePop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: AppColors.textPrimary,
              ),
            )
          : leading,
      title: titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: AppTypography.heading3,
                )
              : null),
      centerTitle: showBack,
      actions: actions,
    );
  }
}
