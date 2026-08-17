import 'package:cmarg/app/data/services/connectivity_service.dart';
import 'package:cmarg/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/global_widgets/app_loader.dart';

class NoInternetView extends StatefulWidget {
  const NoInternetView({super.key});

  @override
  State<NoInternetView> createState() => _NoInternetViewState();
}

class _NoInternetViewState extends State<NoInternetView> {
  bool _isChecking = false;

  void _handleRetry() async {
    setState(() => _isChecking = true);
    await Future.delayed(const Duration(milliseconds: 600));
    final connectivity = Get.find<ConnectivityService>();
    await connectivity.retryConnection();
    if (mounted) setState(() => _isChecking = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.wifi_off_rounded,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),

                const SizedBox(height: 32),

                const Text(
                  "Connection Lost",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ).animate().fadeIn(delay: 200.ms),

                const SizedBox(height: 10),

                Text(
                  "We cannot detect an active internet connection. Please check your mobile data or Wi-Fi settings.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.5,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                    height: 1.45,
                  ),
                ).animate().fadeIn(delay: 350.ms),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _isChecking ? null : _handleRetry,
                    child: _isChecking
                        ? const AppLoader(color: Colors.white)
                        : const Text(
                            "Try Again",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
