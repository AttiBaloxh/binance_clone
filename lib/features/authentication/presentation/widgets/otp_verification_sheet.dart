import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/binance_button.dart';

/// Show OTP verification bottom sheet. Returns true if verified.
Future<bool?> showOtpVerificationSheet({
  required BuildContext context,
  required String email,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.secondaryBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: AppRadius.topLarge,
    ),
    builder: (context) => OtpVerificationSheet(email: email),
  );
}

class OtpVerificationSheet extends StatefulWidget {
  final String email;

  const OtpVerificationSheet({super.key, required this.email});

  @override
  State<OtpVerificationSheet> createState() => _OtpVerificationSheetState();
}

class _OtpVerificationSheetState extends State<OtpVerificationSheet> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  int _resendSeconds = 60;
  Timer? _timer;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  Future<void> _verify() async {
    if (_otp.length != 6) return;

    setState(() => _isVerifying = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
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

          AppSpacing.verticalXxl,

          Text(
            'Verification Code',
            style: AppTypography.heading2,
          ),

          AppSpacing.verticalSm,

          Text(
            'Enter the 6-digit code sent to\n${widget.email}',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),

          AppSpacing.verticalXxxl,

          // OTP fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return SizedBox(
                width: 46,
                height: 52,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: AppTypography.heading2.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  cursorColor: AppColors.primaryYellow,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: AppColors.inputBackground,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.primaryYellow,
                        width: 1.5,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty && index < 5) {
                      _focusNodes[index + 1].requestFocus();
                    }
                    if (value.isEmpty && index > 0) {
                      _focusNodes[index - 1].requestFocus();
                    }
                    setState(() {});
                  },
                ),
              );
            }),
          ),

          AppSpacing.verticalXxxl,

          // Verify button
          BinanceButton(
            text: 'Verify',
            onPressed: _otp.length == 6 ? _verify : null,
            isLoading: _isVerifying,
          ),

          AppSpacing.verticalLg,

          // Resend
          _resendSeconds > 0
              ? Text(
                  'Resend code in ${_resendSeconds}s',
                  style: AppTypography.caption,
                )
              : TextButton(
                  onPressed: () {
                    setState(() => _resendSeconds = 60);
                    _startTimer();
                  },
                  child: Text(
                    'Resend Code',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primaryYellow,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

          AppSpacing.verticalLg,
        ],
      ),
    );
  }
}
