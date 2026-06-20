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
import '../widgets/otp_verification_sheet.dart';

/// Multi-step registration screen.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _referralController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  int _currentStep = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _referralController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 0 && _emailController.text.isEmpty) return;
    if (_currentStep < 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      referralCode: _referralController.text.isNotEmpty
          ? _referralController.text.trim()
          : null,
    );

    if (success && mounted) {
      // Show OTP verification
      final verified = await showOtpVerificationSheet(
        context: context,
        email: _emailController.text.trim(),
      );

      if (verified == true && mounted) {
        context.goNamed(RouteNames.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              context.goNamed(RouteNames.login);
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Progress indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: List.generate(2, (index) {
                    return Expanded(
                      child: Container(
                        height: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: index <= _currentStep
                              ? AppColors.primaryYellow
                              : AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              AppSpacing.verticalXxl,

              // Pages
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildStep1(),
                    _buildStep2(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Account',
            style: AppTypography.displayMedium,
          ).animate().fadeIn(duration: 400.ms),

          AppSpacing.verticalSm,

          Text(
            'Enter your email to get started',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

          AppSpacing.verticalXxxl,

          BinanceTextField(
            label: 'Email',
            hint: 'Enter your email address',
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
              if (!value.contains('@')) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),

          AppSpacing.verticalLg,

          BinanceTextField(
            label: 'Referral Code (Optional)',
            hint: 'Enter referral code',
            controller: _referralController,
            prefixIcon: const Icon(
              Icons.card_giftcard_outlined,
              color: AppColors.textTertiary,
              size: 20,
            ),
          ),

          AppSpacing.verticalXxxl,

          BinanceButton(
            text: 'Next',
            onPressed: _nextStep,
          ),

          AppSpacing.verticalXxxl,

          // Terms
          Center(
            child: Text.rich(
              TextSpan(
                text: 'By creating an account, you agree to our\n',
                style: AppTypography.caption,
                children: [
                  TextSpan(
                    text: 'Terms of Service',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primaryYellow,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primaryYellow,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set Password',
            style: AppTypography.displayMedium,
          ).animate().fadeIn(duration: 400.ms),

          AppSpacing.verticalSm,

          Text(
            'Create a strong password for your account',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

          AppSpacing.verticalXxxl,

          BinanceTextField(
            label: 'Password',
            hint: 'At least 8 characters',
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
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),

          AppSpacing.verticalLg,

          BinanceTextField(
            label: 'Confirm Password',
            hint: 'Re-enter your password',
            controller: _confirmPasswordController,
            obscureText: true,
            prefixIcon: const Icon(
              Icons.lock_outlined,
              color: AppColors.textTertiary,
              size: 20,
            ),
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),

          AppSpacing.verticalLg,

          // Password requirements
          _buildRequirement(
            'At least 8 characters',
            _passwordController.text.length >= 8,
          ),
          _buildRequirement(
            'Contains uppercase letter',
            _passwordController.text.contains(RegExp(r'[A-Z]')),
          ),
          _buildRequirement(
            'Contains a number',
            _passwordController.text.contains(RegExp(r'[0-9]')),
          ),

          AppSpacing.verticalXxxl,

          Consumer<AuthProvider>(
            builder: (context, auth, _) => BinanceButton(
              text: 'Create Account',
              onPressed: _handleRegister,
              isLoading: auth.isLoading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text, bool met) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            met ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: met ? AppColors.green : AppColors.textDisabled,
          ),
          AppSpacing.horizontalSm,
          Text(
            text,
            style: AppTypography.caption.copyWith(
              color: met ? AppColors.green : AppColors.textDisabled,
            ),
          ),
        ],
      ),
    );
  }
}
