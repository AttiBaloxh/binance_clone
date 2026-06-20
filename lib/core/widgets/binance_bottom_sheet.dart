import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../theme/app_typography.dart';

/// Show a Binance-styled modal bottom sheet.
Future<T?> showBinanceBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  bool isDismissible = true,
  bool enableDrag = true,
  bool isScrollControlled = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    isScrollControlled: isScrollControlled,
    backgroundColor: AppColors.secondaryBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: AppRadius.topLarge,
    ),
    builder: (context) => _BinanceBottomSheetContent(
      title: title,
      child: child,
    ),
  );
}

class _BinanceBottomSheetContent extends StatelessWidget {
  final String? title;
  final Widget child;

  const _BinanceBottomSheetContent({
    this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textDisabled,
                borderRadius: AppRadius.borderRadiusCircular,
              ),
            ),
            if (title != null) ...[
              AppSpacing.verticalLg,
              Padding(
                padding: AppSpacing.paddingHorizontalLg,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title!, style: AppTypography.heading3),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.textTertiary,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.divider),
            ],
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}
