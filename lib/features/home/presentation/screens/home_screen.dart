import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/binance_loading.dart';
import '../../../../core/widgets/binance_error_view.dart';
import '../providers/home_provider.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/announcement_banner.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/market_overview_section.dart';
import '../widgets/top_movers_section.dart';
import '../widgets/news_section.dart';
import '../widgets/promo_banner_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primaryYellow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "B",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkBackground,
                      ),
                    ),
                  ),
                ),
                AppSpacing.horizontalMd,
                Text(
                  "Binance",
                  style: AppTypography.heading2.copyWith(
                    color: AppColors.primaryYellow,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.notifications_on_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => context.pushNamed(RouteNames.notifications),
                ),
                IconButton(
                  icon: Icon(
                    Icons.person_outline,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => context.pushNamed(RouteNames.profile),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const BinanceLoading.fullScreen();
          }
          if (provider.error != null) {
            return BinanceErrorView(
              message: provider.error!,
              onRetry: () => provider.refresh(),
            );
          }
          return RefreshIndicator(
            color: AppColors.primaryYellow,
            backgroundColor: AppColors.cardBackground,
            onRefresh: provider.refresh,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                HomeSearchBar(),
                AnnouncementBanner(),
                PromoBannerCarousel(),
                SizedBox(
                  height: 8,
                ),
                QuickActionsGrid(),
                SizedBox(
                  height: 16,
                ),
                MarketOverviewSection(),
                SizedBox(
                  height: 8,
                ),
                TopMoversSection(),
                SizedBox(
                  height: 16,
                ),
                NewsSection(),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
