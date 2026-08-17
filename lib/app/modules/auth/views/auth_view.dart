import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../../core/global_widgets/app_loader.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Interactive Header
            Container(
              width: double.infinity,
              height: 310,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => controller.isOtpSent.value
                            ? IconButton(
                                onPressed: () =>
                                    controller.isOtpSent.value = false,
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              )
                            : const SizedBox(height: 24),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.16),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "CAREERMARG PORTAL",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => Text(
                          controller.isOtpSent.value
                              ? "Verify Code"
                              : "Let's Get Started",
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Obx(
                        () => Text(
                          controller.isOtpSent.value
                              ? "Enter the 4-digit verification code sent to +91 ${controller.phoneController.text}"
                              : "Enter your mobile number to explore MBBS cut-offs & direct abroad admissions.",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13.5,
                            color: Colors.white.withOpacity(0.8),
                            height: 1.35,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            // Form Card Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Obx(
                () => controller.isOtpSent.value
                    ? _buildOtpSection(context, isDark)
                    : _buildPhoneSection(context, isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneSection(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mobile Number",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              width: 1.2,
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    const Text("🇮🇳", style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 6),
                    Text(
                      "+91",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 24,
                      width: 1,
                      color: isDark
                          ? AppColors.darkBorder
                          : AppColors.lightBorder,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                  decoration: const InputDecoration(
                    hintText: "98765 43210",
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightTextSecondary,
                      letterSpacing: 0,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: controller.isLoading.value ? null : controller.sendOtp,
            child: controller.isLoading.value
                ? const AppLoader(color: Colors.white)
                : const Text(
                    "Get Verification Code",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            "By continuing, you agree to our Terms & Privacy Policy",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.5,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 350.ms);
  }

  Widget _buildOtpSection(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
            (index) => SizedBox(
              width: 64,
              height: 64,
              child: TextField(
                controller: controller.otpControllers[index],
                focusNode: controller.otpFocusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                onChanged: (val) => controller.onOtpChanged(val, index),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark ? AppColors.darkCard : Colors.white,
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.darkBorder
                          : AppColors.lightBorder,
                      width: 1.4,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: controller.isLoading.value ? null : controller.verifyOtp,
            child: controller.isLoading.value
                ? const AppLoader(color: Colors.white)
                : const Text(
                    "Verify & Continue",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Obx(
            () => controller.timerSeconds.value > 0
                ? Text(
                    "Resend code in 00:${controller.timerSeconds.value.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.lightTextSecondary,
                    ),
                  )
                : TextButton(
                    onPressed: controller.sendOtp,
                    child: const Text(
                      "Resend Code",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 350.ms);
  }
}
