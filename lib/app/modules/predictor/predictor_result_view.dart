import 'dart:ui';
import 'package:cmarg/app/modules/predictor/models/predictor_data_model.dart';
import 'package:cmarg/app/routes/app_routes.dart';
import 'package:cmarg/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../../core/utils/pdf_generator.dart';

class PredictorResultView extends StatelessWidget {
  const PredictorResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final rawArgs = Get.arguments;
    final PredictorInputData data = rawArgs is Map
        ? rawArgs['data']
        : rawArgs as PredictorInputData;
    final bool isUnlocked = rawArgs is Map
        ? (rawArgs['isUnlocked'] ?? false)
        : false;

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
        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          isUnlocked ? "Full Comprehensive Report" : "NEET ${data.year} Report",
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w800,
            fontSize: 17,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        actions: [
          if (isUnlocked)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.verified_rounded,
                    color: AppColors.success,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "PREMIUM",
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 3D Elevated Candidate Card
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(0.02),
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF1E1B4B), const Color(0xFF111827)]
                        : [const Color(0xFF5A2CEE), const Color(0xFF4318B4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.18),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.35),
                              width: 1.5,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.fullName,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "${data.state} • ${data.year} Intake",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(12),
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
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildHeroScoreItem(
                            "NEET SCORE",
                            "${data.score}/720",
                            AppColors.accent,
                          ),
                          Container(
                            height: 24,
                            width: 1,
                            color: Colors.white24,
                          ),
                          _buildHeroScoreItem(
                            "PREDICTED AIR",
                            "#$predictedAIR",
                            Colors.white,
                          ),
                          Container(
                            height: 24,
                            width: 1,
                            color: Colors.white24,
                          ),
                          _buildHeroScoreItem(
                            "PERCENTILE",
                            "${percentile.toStringAsFixed(2)}%",
                            Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Download Report Button (Only when Unlocked)
            if (isUnlocked) ...[
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.picture_as_pdf_rounded, size: 20),
                  label: const Text(
                    "Download Official PDF Report Card",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () => PdfReportGenerator.generateAndDownloadReport(
                    data,
                    predictedAIR,
                    percentile,
                  ),
                ),
              ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95)),
              const SizedBox(height: 20),
            ],

            // Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Eligible Medical Colleges",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  isUnlocked
                      ? "30+ Results Unlocked"
                      : "10-Year Cutoff Matched",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11.5,
                    color: isUnlocked
                        ? AppColors.success
                        : (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Base Qualified Colleges
            _buildCollegeCard(
              name: "Patna Medical College & Hospital (PMCH)",
              location: "Patna, Bihar",
              quota: "State Quota • 85%",
              matchBadge: "96% High Match",
              badgeColor: AppColors.success,
              feeInfo: "₹ 1.2 Lakh / Year",
              cutoffRank: "Closing AIR: 4,520",
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            _buildCollegeCard(
              name: "Dhaka National Medical College",
              location: "Dhaka, Bangladesh",
              quota: "NMC Recognized MBBS Direct",
              matchBadge: "Guaranteed Admission",
              badgeColor: AppColors.primary,
              feeInfo: "₹ 32 Lakh Total Package",
              cutoffRank: "Direct Merit Desk",
              isDark: isDark,
            ),
            const SizedBox(height: 12),

            // Conditional View: Unlocked Full List VS Blurred Curiosity Mask
            if (isUnlocked) ...[
              _buildCollegeCard(
                name: "All India Institute of Medical Sciences (AIIMS)",
                location: "New Delhi",
                quota: "AIQ 15% Central Counseling",
                matchBadge: "Competitive Match",
                badgeColor: AppColors.warning,
                feeInfo: "₹ 6,850 / Year",
                cutoffRank: "Closing AIR: 65",
                isDark: isDark,
              ),
              const SizedBox(height: 12),
              _buildCollegeCard(
                name: "Kazakh National Medical University",
                location: "Almaty, Kazakhstan",
                quota: "NMC • WHO • Ministry Approved",
                matchBadge: "Direct Seat Allotment",
                badgeColor: AppColors.success,
                feeInfo: "₹ 18.5 Lakh Full Course",
                cutoffRank: "Eligibility: Qualifying NEET",
                isDark: isDark,
              ),
              const SizedBox(height: 12),
              _buildCollegeCard(
                name: "Kasturba Medical College (KMC)",
                location: "Manipal, Karnataka",
                quota: "Deemed University Management",
                matchBadge: "High Probability",
                badgeColor: AppColors.primary,
                feeInfo: "₹ 17.8 Lakh / Year",
                cutoffRank: "Closing AIR: 42,100",
                isDark: isDark,
              ),
            ] else ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        children: [
                          _buildGhostCollegeCard(
                            name:
                                "All India Institute of Medical Sciences (AIIMS)",
                            location: "New Delhi",
                            quota: "AIQ 15% Central Counseling",
                            matchBadge: "Competitive Match",
                            badgeColor: AppColors.warning,
                            feeInfo: "₹ 6,850 / Year",
                            cutoffRank: "Closing AIR: 65",
                            isDark: isDark,
                          ),
                          const SizedBox(height: 12),
                          _buildGhostCollegeCard(
                            name: "Kazakh National Medical University",
                            location: "Almaty, Kazakhstan",
                            quota: "NMC • WHO • Ministry Approved",
                            matchBadge: "Direct Seat Allotment",
                            badgeColor: AppColors.success,
                            feeInfo: "₹ 18.5 Lakh Full Course",
                            cutoffRank: "Eligibility: Qualifying NEET",
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                (isDark
                                        ? AppColors.darkBackground
                                        : AppColors.lightBackground)
                                    .withOpacity(0.1),
                                (isDark
                                        ? AppColors.darkBackground
                                        : AppColors.lightBackground)
                                    .withOpacity(0.85),
                                (isDark
                                    ? AppColors.darkBackground
                                    : AppColors.lightBackground),
                              ],
                              stops: const [0.0, 0.40, 0.75],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkSurface : Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder,
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.accent.withOpacity(0.18),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.lock_person_rounded,
                                    size: 18,
                                    color: AppColors.accent,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "28+ More Colleges & Cutoffs Hidden",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Unlock complete fee breakups, round-wise cutoffs, and download your personalized report card.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 11.5,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {
                                  Get.toNamed(Routes.PLANS, arguments: data);
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Want Complete Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Icon(Icons.arrow_forward_rounded, size: 16),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 50),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  ' Powered by',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                    letterSpacing: 0.3,
                  ),
                ),

                Text(
                  'CareerMarg',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroScoreItem(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.5,
            fontWeight: FontWeight.w900,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCollegeCard({
    required String name,
    required String location,
    required String quota,
    required String matchBadge,
    required Color badgeColor,
    required String feeInfo,
    required String cutoffRank,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 13,
                          color: AppColors.lightTextSecondary,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          location,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11.5,
                            color: AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  matchBadge,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: badgeColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.payments_outlined,
                      size: 14,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      feeInfo,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
                Text(
                  cutoffRank,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGhostCollegeCard({
    required String name,
    required String location,
    required String quota,
    required String matchBadge,
    required Color badgeColor,
    required String feeInfo,
    required String cutoffRank,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.darkCard : Colors.white).withOpacity(0.6),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  matchBadge,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: badgeColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  feeInfo,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                Text(
                  cutoffRank,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
