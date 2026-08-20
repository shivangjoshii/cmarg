import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/neet_predictor_bottom_sheet.dart';
import '../../../profile/views/profile_setup_view.dart';
import '../../../../routes/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../../core/utils/app_toast.dart';

class ProfileView extends GetView<DashboardController> {
  const ProfileView({super.key});

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
            // 1. Signature Curvy Header with Integrated Hero Card
            _buildCurvedHeader(context, isDark),

            // 2. Main Content Surface
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),

                  // Admission & Counselling Section
                  _buildSectionTitle("Admission & Counselling", isDark),
                  const SizedBox(height: 10),
                  _buildUnifiedCard(
                    isDark: isDark,
                    items: [
                      _MinimalRowItem(
                        icon: Icons.edit_note_rounded,
                        title: "Student Profile Setup",
                        trailingText: "85% Done",
                        onTap: () => Get.to(
                          () => const ProfileSetupView(),
                          transition: Transition.cupertino,
                        ),
                      ),
                      _MinimalRowItem(
                        icon: Icons.speed_rounded,
                        title: "NEET Scorecard & Rank",
                        trailingText: "AIR #54,120",
                        onTap: () {
                          Get.bottomSheet(
                            const NeetPredictorBottomSheet(),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          );
                        },
                      ),
                      _MinimalRowItem(
                        icon: Icons.apartment_rounded,
                        title: "Shortlisted Medical Colleges",
                        trailingText: "3 Saved",
                        onTap: () => controller.changeTab(1),
                      ),
                      _MinimalRowItem(
                        icon: Icons.support_agent_rounded,
                        title: "Doctor Mentor Consultation",
                        trailingText: "1 Active",
                        onTap: () => controller.changeTab(2),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // Documents & Subscriptions Section
                  _buildSectionTitle("Documents & Orders", isDark),
                  const SizedBox(height: 10),
                  _buildUnifiedCard(
                    isDark: isDark,
                    items: [
                      _MinimalRowItem(
                        icon: Icons.folder_outlined,
                        title: "Verification Vault",
                        trailingText: "4 Files",
                        onTap: () =>
                            AppToast.info("Vault", "Document vault opened."),
                      ),
                      _MinimalRowItem(
                        icon: Icons.workspace_premium_outlined,
                        title: "Membership & Invoices",
                        trailingText: "Essential Pack",
                        onTap: () => Get.toNamed(Routes.PLANS),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // Support & Settings Section
                  _buildSectionTitle("General & Support", isDark),
                  const SizedBox(height: 10),
                  _buildUnifiedCard(
                    isDark: isDark,
                    items: [
                      _MinimalRowItem(
                        icon: Icons.chat_bubble_outline_rounded,
                        title: "Admission Helpdesk",
                        trailingText: "24×7 Active",
                        onTap: () => AppToast.info(
                          "Support",
                          "Connecting to counsellor desk...",
                        ),
                      ),
                      _MinimalRowItem(
                        icon: Icons.shield_outlined,
                        title: "Terms & Privacy Policy",
                        onTap: () => AppToast.info(
                          "CareerMarg",
                          "Opening terms of service.",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Sign Out Action
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.error,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                            color: isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.logout_rounded, size: 17),
                      label: const Text(
                        "Sign Out",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () => _showLogoutConfirmation(context, isDark),
                    ),
                  ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 1. Signature Curvy Header
  Widget _buildCurvedHeader(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B2E) : const Color(0xFF5A2CEE),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : AppColors.primary).withOpacity(
              0.18,
            ),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Actions Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.4,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showSettingsBottomSheet(context, isDark),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Student Identity Overview
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.16),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
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
                        const Text(
                          "Pawan Kumar",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "NEET UG 2026 • Delhi Domicile",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(
                      () => const ProfileSetupView(),
                      transition: Transition.cupertino,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Score Matrix Strip
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildHeaderStat("SCORE", "600 / 720"),
                    Container(height: 20, width: 1, color: Colors.white24),
                    _buildHeaderStat("AIR PREDICTED", "#54,120"),
                    Container(height: 20, width: 1, color: Colors.white24),
                    _buildHeaderStat("PERCENTILE", "97.45%"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: Colors.white60,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        color: isDark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary,
        letterSpacing: 0.2,
      ),
    );
  }

  // Unified Minimalist Card Group
  Widget _buildUnifiedCard({
    required List<_MinimalRowItem> items,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1.2,
        ),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final int index = entry.key;
          final _MinimalRowItem item = entry.value;
          final bool isLast = index == items.length - 1;

          return Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.vertical(
                  top: index == 0 ? const Radius.circular(20) : Radius.zero,
                  bottom: isLast ? const Radius.circular(20) : Radius.zero,
                ),
                onTap: () {
                  HapticFeedback.selectionClick();
                  item.onTap();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item.icon,
                        size: 20,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : const Color(0xFF334155),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary,
                          ),
                        ),
                      ),
                      if (item.trailingText != null) ...[
                        Text(
                          item.trailingText!,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  indent: 50,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showSettingsBottomSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 36,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              "Preferences",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.notifications_active_outlined),
              title: const Text(
                "Counselling Deadline Alerts",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
              ),
              trailing: CupertinoSwitch(
                value: true,
                activeColor: AppColors.primary,
                onChanged: (val) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context, bool isDark) {
    Get.dialog(
      Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 28),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sign Out",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Are you sure you want to sign out of CareerMarg?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.5,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                        controller.logout();
                      },
                      child: const Text(
                        "Sign Out",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MinimalRowItem {
  final IconData icon;
  final String title;
  final String? trailingText;
  final VoidCallback onTap;

  _MinimalRowItem({
    required this.icon,
    required this.title,
    this.trailingText,
    required this.onTap,
  });
}
