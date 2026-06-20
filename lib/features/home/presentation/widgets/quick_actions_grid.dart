import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

/// Quick action buttons grid (Deposit, Withdraw, etc.).
class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(Icons.arrow_downward_rounded, 'Deposit', AppColors.primaryYellow),
      _QuickAction(Icons.credit_card, 'Buy Crypto', AppColors.green),
      _QuickAction(Icons.swap_horiz, 'P2P Trading', AppColors.textSecondary),
      _QuickAction(Icons.account_balance, 'Earn', AppColors.primaryYellow),
      _QuickAction(Icons.auto_graph, 'Margin', AppColors.textSecondary),
      _QuickAction(Icons.grid_view_rounded, 'More', AppColors.textSecondary),
    ];

    return Padding(
      padding: AppSpacing.paddingHorizontalLg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions.map((action) {
          return _ActionItem(action: action);
        }).toList(),
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;

  const _QuickAction(this.icon, this.label, this.color);
}

class _ActionItem extends StatelessWidget {
  final _QuickAction action;

  const _ActionItem({required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to respective screens
      },
      child: SizedBox(
        width: 56,
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: action.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                action.icon,
                color: action.color,
                size: 22,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              action.label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
