import 'dart:ui';
import 'package:cmarg/app/modules/predictor/models/predictor_data_model.dart';
import 'package:cmarg/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class PredictorResultView extends StatelessWidget {
  const PredictorResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final PredictorInputData data = Get.arguments as PredictorInputData;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final int predictedAIR = ((720 - data.score) * 450 + 120).clamp(1, 240000);
    final double percentile = (100 - (predictedAIR / 240000 * 100)).clamp(
      50.0,
      99.98,
    );

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Prediction Report",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEA580C), Color(0xFFC2410C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEA580C).withOpacity(0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.fullName,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          data.examType,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "State: ${data.state} • Year: ${data.year}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 12,
                    ),
                  ),
                  const Divider(color: Colors.white24, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMetric("NEET SCORE", "${data.score}/720"),
                      _buildMetric("PREDICTED AIR", "#$predictedAIR"),
                      _buildMetric(
                        "PERCENTILE",
                        "${percentile.toStringAsFixed(2)}%",
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),

            const SizedBox(height: 28),

            const Text(
              "Eligible Medical Colleges",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 12),

            // Top Visible Qualifying College
            _buildCollegeCard(
              name: "Patna Medical College (PMCH)",
              location: "Patna, Bihar",
              quota: "State Quota • 85%",
              chance: "98% High Chance",
              isDark: isDark,
            ),
            const SizedBox(height: 12),

            // Blurred Colleges with Unlock Overlay
            Stack(
              children: [
                Column(
                  children: [
                    _buildCollegeCard(
                      name: "All India Institute of Medical Sciences (AIIMS)",
                      location: "New Delhi",
                      quota: "AIQ • 15%",
                      chance: "Competitive",
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    _buildCollegeCard(
                      name: "Dhaka National Medical College",
                      location: "Dhaka, Bangladesh",
                      quota: "NMC Recognized MBBS Direct",
                      chance: "Guaranteed Admission",
                      isDark: isDark,
                    ),
                  ],
                ),

                // Frosted Glass Overlay with CTA
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              (isDark ? AppColors.darkBackground : Colors.white)
                                  .withOpacity(0.55),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFEA580C,
                                ).withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.lock_rounded,
                                color: Color(0xFFEA580C),
                                size: 26,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "28+ More Colleges Hidden",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Unlock detailed seat matrix, fees & counseling assistance.",
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEA580C),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () {
                                Get.snackbar(
                                  "Counselor Support",
                                  "A CareerMarg counselor is connecting with you.",
                                );
                              },
                              child: const Text(
                                "Want Complete Details",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String title, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          val,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildCollegeCard({
    required String name,
    required String location,
    required String quota,
    required String chance,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  chance,
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: AppColors.lightTextSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                location,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.lightTextSecondary,
                ),
              ),
              const Spacer(),
              Text(
                quota,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
