import 'package:cmarg/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Skip",
              style: TextStyle(color: AppColors.lightTextSecondary),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              "Discover Top Global\nMedical Universities",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 12),
            Text(
              "Explore MCI/FMGE recognized MBBS programs in Bangladesh, Nepal, Russia, Kazakhstan, and more with ISO-certified mentorship.",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.lightTextSecondary,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
