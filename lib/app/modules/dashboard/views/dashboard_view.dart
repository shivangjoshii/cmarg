import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/neet_predictor_bottom_sheet.dart';
import 'sub_views/home_view.dart';
import 'sub_views/universities_view.dart';
import 'sub_views/counseling_view.dart';
import 'sub_views/profile_view.dart';
import '../../../theme/app_colors.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        final shouldExit = controller.handleBackPress();
        if (shouldExit) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        body: Stack(
          children: [
            Obx(
              () => IndexedStack(
                index: controller.currentTabIndex.value,
                children: const [
                  HomeView(),
                  UniversitiesView(),
                  CounselingView(),
                  ProfileView(),
                ],
              ),
            ),

            // Liquid Glass Floating Dock
            Positioned(
              bottom: 20,
              left: 16,
              right: 0,
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          height: 64,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF131826).withOpacity(0.85)
                                : Colors.white.withOpacity(0.90),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withOpacity(0.12)
                                  : Colors.black.withOpacity(0.06),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.4 : 0.08,
                                ),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              _buildTabItem(
                                0,
                                Icons.home_rounded,
                                Icons.home_outlined,
                                'Home',
                                isDark,
                              ),
                              _buildTabItem(
                                1,
                                Icons.school_rounded,
                                Icons.school_outlined,
                                'Colleges',
                                isDark,
                              ),
                              _buildTabItem(
                                2,
                                Icons.support_agent_rounded,
                                Icons.support_agent_outlined,
                                'Counseling',
                                isDark,
                              ),
                              _buildTabItem(
                                3,
                                Icons.person_rounded,
                                Icons.person_outline_rounded,
                                'Profile',
                                isDark,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // AI NEET Pill with Aurora Glow
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Get.bottomSheet(
                        const NeetPredictorBottomSheet(),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        bottomLeft: Radius.circular(32),
                        topRight: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          height: 64,
                          width: 78,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFE25822),
                                Color(0xFFEA580C),
                              ], // Official Orange Gradient
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32),
                              bottomLeft: Radius.circular(32),
                              topRight: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.35),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFEA580C).withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                    Icons.auto_awesome_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  )
                                  .animate(
                                    onPlay: (c) => c.repeat(reverse: true),
                                  )
                                  .scale(
                                    begin: const Offset(0.9, 0.9),
                                    end: const Offset(1.2, 1.2),
                                    duration: 900.ms,
                                    curve: Curves.easeInOut,
                                  )
                                  .shimmer(
                                    duration: 1600.ms,
                                    color: Colors.amberAccent,
                                  ),
                              const SizedBox(height: 3),
                              const Text(
                                "AI NEET",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(
    int index,
    IconData activeIcon,
    IconData inactiveIcon,
    String label,
    bool isDark,
  ) {
    return Obx(() {
      final isSelected = controller.currentTabIndex.value == index;

      return Expanded(
        child: GestureDetector(
          onTap: () {
            if (!isSelected) {
              HapticFeedback.lightImpact();
              controller.changeTab(index);
            }
          },
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark
                        ? AppColors.primary.withOpacity(0.22)
                        : AppColors.primary.withOpacity(0.1))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.18 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    isSelected ? activeIcon : inactiveIcon,
                    size: 20,
                    color: isSelected
                        ? AppColors.primary
                        : (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary),
                  ),
                ),
                const SizedBox(height: 3),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 180),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 9.5,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.primary
                        : (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary),
                  ),
                  child: Text(label),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
