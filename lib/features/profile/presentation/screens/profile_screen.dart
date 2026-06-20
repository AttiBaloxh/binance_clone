import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/binance_app_bar.dart';
import '../../../../core/widgets/binance_card.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';

/// Profile screen with user info, verification, security, referral.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: const BinanceAppBar(title: 'Profile', showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User header
          BinanceCard(
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primaryYellow.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.primaryYellow,
                    size: 28,
                  ),
                ),
                AppSpacing.horizontalLg,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Binance User',
                        style: AppTypography.heading3,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'user@binance.com',
                        style: AppTypography.caption,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.green.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.verified, size: 12, color: AppColors.green),
                                const SizedBox(width: 4),
                                Text(
                                  'Verified',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: AppColors.green,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppSpacing.horizontalSm,
                          Text(
                            'UID: 123456789',
                            style: AppTypography.caption.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.qr_code, color: AppColors.textTertiary, size: 24),
              ],
            ),
          ),

          AppSpacing.verticalLg,

          // Verification
          _buildSectionCard(
            icon: Icons.verified_user_outlined,
            iconColor: AppColors.green,
            title: 'Verification',
            subtitle: 'Identity Verified',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Lv. 2',
                style: AppTypography.labelSmall.copyWith(color: AppColors.green),
              ),
            ),
          ),

          AppSpacing.verticalSm,

          // Security
          _buildSectionCard(
            icon: Icons.security_outlined,
            iconColor: AppColors.primaryYellow,
            title: 'Security Center',
            subtitle: '2FA enabled · Password set',
          ),

          AppSpacing.verticalSm,

          // Referral
          _buildSectionCard(
            icon: Icons.card_giftcard_outlined,
            iconColor: AppColors.primaryYellowLight,
            title: 'Referral Program',
            subtitle: 'Invite friends, earn crypto',
          ),

          AppSpacing.verticalSm,

          // Payment methods
          _buildSectionCard(
            icon: Icons.payment_outlined,
            iconColor: AppColors.textSecondary,
            title: 'Payment Methods',
            subtitle: 'Manage your payment methods',
          ),

          AppSpacing.verticalSm,

          // Settings
          _buildSectionCard(
            icon: Icons.settings_outlined,
            iconColor: AppColors.textSecondary,
            title: 'Settings',
            subtitle: 'App preferences',
            onTap: () => context.pushNamed(RouteNames.settings),
          ),

          AppSpacing.verticalXxl,

          // Logout
          TextButton(
            onPressed: () {
              context.read<AuthProvider>().logout();
              context.goNamed(RouteNames.login);
            },
            child: Text(
              'Log Out',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          AppSpacing.verticalXxxl,
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return BinanceCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          AppSpacing.horizontalLg,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.caption),
              ],
            ),
          ),
          if (trailing != null) trailing,
          AppSpacing.horizontalSm,
          const Icon(Icons.chevron_right, color: AppColors.textDisabled, size: 20),
        ],
      ),
    );
  }
}
