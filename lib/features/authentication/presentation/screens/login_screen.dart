import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/binance_button.dart';
import '../../../../core/widgets/binance_text_field.dart';
import '../providers/auth_provider.dart';
import '../widgets/social_login_buttons.dart';

/// Login screen with email/phone tabs, social login, remember me.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final identifier = _tabController.index == 0
        ? _emailController.text.trim()
        : _phoneController.text.trim();

    final success = await authProvider.login(
      email: identifier,
      password: _passwordController.text,
    );

    if (success && mounted) {
      context.goNamed(RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.verticalXxxl,

                // Header
                Text(
                  'Log In',
                  style: AppTypography.displayMedium,
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

                AppSpacing.verticalSm,

                Text(
                  'Welcome back to Binance',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

                AppSpacing.verticalXxl,

                // Email / Phone tabs
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: AppColors.primaryYellow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelColor: AppColors.darkBackground,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: AppColors.textTertiary,
                    labelStyle: AppTypography.label.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    dividerColor: Colors.transparent,

                    tabs: const [
                      Tab(text: 'Email'),
                      Tab(text: 'Phone'),
                    ],
                    onTap: (_) => setState(() {}),
                  ),
                ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

                AppSpacing.verticalXxl,

                // Input fields
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _tabController.index == 0
                      ? BinanceTextField(
                          key: const ValueKey('email'),
                          label: 'Email',
                          hint: 'Enter your email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: AppColors.textTertiary,
                            size: 20,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        )
                      : BinanceTextField(
                          key: const ValueKey('phone'),
                          label: 'Phone Number',
                          hint: 'Enter your phone number',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            color: AppColors.textTertiary,
                            size: 20,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required';
                            }
                            return null;
                          },
                        ),
                ),

                AppSpacing.verticalLg,

                // Password
                BinanceTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  obscureText: true,
                  prefixIcon: const Icon(
                    Icons.lock_outlined,
                    color: AppColors.textTertiary,
                    size: 20,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),

                AppSpacing.verticalLg,

                // Remember me & Forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Remember me
                    Consumer<AuthProvider>(
                      builder: (context, auth, _) => GestureDetector(
                        onTap: () => auth.setRememberMe(!auth.rememberMe),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: auth.rememberMe,
                                onChanged: (v) =>
                                    auth.setRememberMe(v ?? false),
                                activeColor: AppColors.primaryYellow,
                                checkColor: AppColors.darkBackground,
                                side: const BorderSide(
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ),
                            AppSpacing.horizontalSm,
                            Text(
                              'Remember me',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Forgot password
                    TextButton(
                      onPressed: () {
                        // TODO: Navigate to forgot password
                      },
                      child: Text(
                        'Forgot Password?',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primaryYellow,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                AppSpacing.verticalXxl,

                // Error message
                Consumer<AuthProvider>(
                  builder: (context, auth, _) {
                    if (auth.errorMessage != null) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.red.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: AppColors.red,
                                size: 18,
                              ),
                              AppSpacing.horizontalSm,
                              Expanded(
                                child: Text(
                                  auth.errorMessage!,
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // Login button
                Consumer<AuthProvider>(
                  builder: (context, auth, _) => BinanceButton(
                    text: 'Log In',
                    onPressed: _handleLogin,
                    isLoading: auth.isLoading,
                  ),
                ),

                AppSpacing.verticalXxl,

                // Divider
                Row(
                  children: [
                    const Expanded(
                      child: Divider(color: AppColors.border),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or',
                        style: AppTypography.caption,
                      ),
                    ),
                    const Expanded(
                      child: Divider(color: AppColors.border),
                    ),
                  ],
                ),

                AppSpacing.verticalXxl,

                // Social login
                const SocialLoginButtons(),

                AppSpacing.verticalXxxl,

                // Sign up link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.goNamed(RouteNames.register),
                        child: Text(
                          'Sign Up',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primaryYellow,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                AppSpacing.verticalXxxl,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
