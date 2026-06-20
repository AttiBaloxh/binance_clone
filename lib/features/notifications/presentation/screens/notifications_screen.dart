import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/binance_app_bar.dart';
import '../../../../core/widgets/binance_tab_bar.dart';

/// Notifications screen with System/Trade/Promo tabs.
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _tabIndex = 0;
  final _tabs = ['System', 'Trade', 'Promotions'];

  final _notifications = [
    _NotificationItem('Login Alert', 'New login from iPhone 15 Pro, New York, US', DateTime.now().subtract(const Duration(hours: 1)), Icons.security, AppColors.primaryYellow),
    _NotificationItem('Deposit Confirmed', '0.05 BTC deposit has been confirmed (6/6 confirmations)', DateTime.now().subtract(const Duration(hours: 3)), Icons.check_circle_outline, AppColors.green),
    _NotificationItem('Order Filled', 'Limit order BUY 0.01 BTC @ 67,200 USDT has been filled', DateTime.now().subtract(const Duration(hours: 5)), Icons.swap_horiz, AppColors.textSecondary),
    _NotificationItem('Price Alert', 'BTC has reached your target price of \$67,500', DateTime.now().subtract(const Duration(hours: 8)), Icons.notifications_active, AppColors.primaryYellow),
    _NotificationItem('System Maintenance', 'Scheduled maintenance on June 5, 2:00 AM - 4:00 AM UTC', DateTime.now().subtract(const Duration(days: 1)), Icons.build_outlined, AppColors.textTertiary),
    _NotificationItem('New Feature', 'Copy Trading is now available! Follow top traders.', DateTime.now().subtract(const Duration(days: 2)), Icons.star_outline, AppColors.primaryYellowLight),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: BinanceAppBar(
        title: 'Notifications',
        showBack: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Read All',
              style: AppTypography.label.copyWith(color: AppColors.primaryYellow),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          BinanceTabBar(
            tabs: _tabs,
            selectedIndex: _tabIndex,
            onTabChanged: (i) => setState(() => _tabIndex = i),
            style: TabBarStyle.underline,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _notifications.length,
              separatorBuilder: (_, __) => const Divider(
                color: AppColors.divider,
                height: 0.5,
                indent: 60,
              ),
              itemBuilder: (context, index) {
                final notif = _notifications[index];
                return _buildNotificationTile(notif);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile(_NotificationItem notif) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: notif.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(notif.icon, color: notif.color, size: 20),
            ),
            AppSpacing.horizontalMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notif.title,
                    style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif.body,
                    style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    Formatters.timeAgo(notif.time),
                    style: AppTypography.caption.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem {
  final String title;
  final String body;
  final DateTime time;
  final IconData icon;
  final Color color;

  _NotificationItem(this.title, this.body, this.time, this.icon, this.color);
}
