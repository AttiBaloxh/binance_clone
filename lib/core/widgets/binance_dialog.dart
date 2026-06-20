import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../theme/app_typography.dart';
import 'binance_button.dart';

/// Show a Binance-styled dialog.
Future<T?> showBinanceDialog<T>({
  required BuildContext context,
  required String title,
  required String message,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool isDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: isDismissible,
    builder: (context) => _BinanceDialog(
      title: title,
      message: message,
      confirmText: confirmText ?? 'Confirm',
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
    ),
  );
}

class _BinanceDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const _BinanceDialog({
    required this.title,
    required this.message,
    required this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderRadiusLarge,
      ),
      child: Padding(
        padding: AppSpacing.paddingAllXxl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: AppTypography.heading3),
            AppSpacing.verticalMd,
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalXxl,
            Row(
              children: [
                if (cancelText != null) ...[
                  Expanded(
                    child: BinanceButton(
                      text: cancelText!,
                      variant: BinanceButtonVariant.secondary,
                      onPressed: () {
                        onCancel?.call();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  AppSpacing.horizontalMd,
                ],
                Expanded(
                  child: BinanceButton(
                    text: confirmText,
                    onPressed: () {
                      onConfirm?.call();
                      Navigator.pop(context, true);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
