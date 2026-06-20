import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/binance_app_bar.dart';

/// Settings screen with app preferences.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometrics = true;
  bool _pushNotifications = true;
  bool _priceAlerts = true;
  String _currency = 'USD';
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: const BinanceAppBar(title: 'Settings', showBack: true),
      body: ListView(
        children: [
          // General
          _sectionTitle('General'),
          _settingsTile(
            icon: Icons.language,
            title: 'Language',
            trailing: Text(_language, style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
          ),
          _settingsTile(
            icon: Icons.attach_money,
            title: 'Currency',
            trailing: Text(_currency, style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
          ),
          _settingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Theme',
            trailing: Text('Dark', style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
          ),

          // Security
          _sectionTitle('Security'),
          _settingsSwitch(
            icon: Icons.fingerprint,
            title: 'Biometric Authentication',
            value: _biometrics,
            onChanged: (v) => setState(() => _biometrics = v),
          ),

          // Notifications
          _sectionTitle('Notifications'),
          _settingsSwitch(
            icon: Icons.notifications_outlined,
            title: 'Push Notifications',
            value: _pushNotifications,
            onChanged: (v) => setState(() => _pushNotifications = v),
          ),
          _settingsSwitch(
            icon: Icons.trending_up,
            title: 'Price Alerts',
            value: _priceAlerts,
            onChanged: (v) => setState(() => _priceAlerts = v),
          ),

          // About
          _sectionTitle('About'),
          _settingsTile(
            icon: Icons.info_outline,
            title: 'App Version',
            trailing: Text('1.0.0', style: AppTypography.caption.copyWith(color: AppColors.textDisabled)),
            showArrow: false,
          ),
          _settingsTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
          ),
          _settingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
          ),

          AppSpacing.verticalXxxl,
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.textDisabled,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    bool showArrow = true,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 22),
            AppSpacing.horizontalLg,
            Expanded(
              child: Text(title, style: AppTypography.bodyMedium),
            ),
            if (trailing != null) trailing,
            if (showArrow) ...[
              AppSpacing.horizontalSm,
              const Icon(Icons.chevron_right, color: AppColors.textDisabled, size: 20),
            ],
          ],
        ),
      ),
    );
  }

  Widget _settingsSwitch({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 22),
          AppSpacing.horizontalLg,
          Expanded(
            child: Text(title, style: AppTypography.bodyMedium),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryYellow,
            inactiveTrackColor: AppColors.cardBackground,
          ),
        ],
      ),
    );
  }
}
