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
            // Persistent View Layer (Maintains scroll & lifecycle state)
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

            // Docked Liquid Frosted Glass Bottom Navigation Bar
            Positioned(
              bottom: 20,
              left: 16,
              right: 0, // Flush to screen right edge
              child: Row(
                children: [
                  // Main Liquid Glass Tab Bar
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF121826).withOpacity(0.82)
                                : Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withOpacity(0.12)
                                  : Colors.black.withOpacity(0.06),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.35 : 0.08,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildAnimatedNavItem(
                                index: 0,
                                activeIcon: Icons.home_rounded,
                                inactiveIcon: Icons.home_outlined,
                                label: 'Home',
                                isDark: isDark,
                              ),
                              _buildAnimatedNavItem(
                                index: 1,
                                activeIcon: Icons.school_rounded,
                                inactiveIcon: Icons.school_outlined,
                                label: 'Colleges',
                                isDark: isDark,
                              ),
                              _buildAnimatedNavItem(
                                index: 2,
                                activeIcon: Icons.support_agent_rounded,
                                inactiveIcon: Icons.support_agent_outlined,
                                label: 'Counseling',
                                isDark: isDark,
                              ),
                              _buildAnimatedNavItem(
                                index: 3,
                                activeIcon: Icons.person_rounded,
                                inactiveIcon: Icons.person_outline_rounded,
                                label: 'Profile',
                                isDark: isDark,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Docked AI NEET Button (Flush Right Edge)
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
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          height: 60,
                          width: 74,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, Color(0xFF7C3AED)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.28),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Continuous Blinking & Glowing AI Star Icon
                              const Icon(
                                    Icons.auto_awesome_rounded,
                                    color: Color(0xFFFDE047),
                                    size: 20,
                                  )
                                  .animate(
                                    onPlay: (c) => c.repeat(reverse: true),
                                  )
                                  .scale(
                                    begin: const Offset(0.85, 0.85),
                                    end: const Offset(1.2, 1.2),
                                    duration: 800.ms,
                                    curve: Curves.easeInOut,
                                  )
                                  .shimmer(
                                    duration: 1600.ms,
                                    color: Colors.white,
                                  ),
                              const SizedBox(height: 3),
                              const Text(
                                "AI NEET",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 0.2,
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

  Widget _buildAnimatedNavItem({
    required int index,
    required IconData activeIcon,
    required IconData inactiveIcon,
    required String label,
    required bool isDark,
  }) {
    return Obx(() {
      final bool isSelected = controller.currentTabIndex.value == index;

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
            curve: Curves.easeOutBack,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDark
                        ? AppColors.primary.withOpacity(0.24)
                        : AppColors.primary.withOpacity(0.12))
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.15 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    isSelected ? activeIcon : inactiveIcon,
                    size: 19,
                    color: isSelected
                        ? AppColors.primary
                        : (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary),
                  ),
                ),
                const SizedBox(height: 2),
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
