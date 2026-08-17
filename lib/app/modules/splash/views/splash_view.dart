import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../../../../core/global_widgets/app_loader.dart';
import '../../../theme/app_colors.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.1),
              ),
              child: const Icon(Icons.school_rounded, size: 64, color: AppColors.primary),
            ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 24),
            Text(
              "CAREERMARG",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(letterSpacing: 2),
            ).animate().fadeIn(delay: 200.ms).moveY(begin: 10, end: 0),
            const SizedBox(height: 6),
            Text(
              "Your Pathway to Global Medical Education",
              style: Theme.of(context).textTheme.bodyMedium,
            ).animate().fadeIn(delay: 400.ms),
            const SizedBox(height: 48),
            const AppLoader(),
          ],
        ),
      ),
    );
  }
}