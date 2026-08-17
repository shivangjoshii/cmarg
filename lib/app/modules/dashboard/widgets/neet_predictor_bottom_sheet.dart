import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../predictor/controllers/predictor_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../../core/global_widgets/app_loader.dart';

class NeetPredictorBottomSheet extends StatelessWidget {
  const NeetPredictorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<PredictorController>()
        ? Get.find<PredictorController>()
        : Get.put(PredictorController());

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF101726) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: EdgeInsets.only(
        top: 12,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            Center(
              child: Container(
                height: 4,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Header Pill & Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEA580C).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.bolt_rounded,
                        size: 14,
                        color: Color(0xFFEA580C),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "AI Powered Predictor",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFEA580C),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            const SizedBox(height: 12),

            RichText(
              text: TextSpan(
                text: "Predict Your ",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                  letterSpacing: -0.5,
                ),
                children: const [
                  TextSpan(
                    text: "NEET Rank",
                    style: TextStyle(color: Color(0xFFEA580C)),
                  ),
                  TextSpan(text: "\n& MBBS College Chances"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Exam Type Switcher Tabs
            Obx(
              () => Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: controller.examTypes.map((type) {
                    final isSelected =
                        controller.selectedExamType.value == type;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          controller.selectedExamType.value = type;
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFEA580C)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: const Color(
                                        0xFFEA580C,
                                      ).withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            type,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.5,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Input Fields
            _buildField(
              context: context,
              label: "Full Name",
              icon: Icons.person_outline_rounded,
              controller: controller.fullNameController,
              isDark: isDark,
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildField(
                    context: context,
                    label: "Mobile No.",
                    icon: Icons.phone_outlined,
                    controller: controller.mobileController,
                    isDark: isDark,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildField(
                    context: context,
                    label: "Email",
                    icon: Icons.email_outlined,
                    controller: controller.emailController,
                    isDark: isDark,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    label: "Year",
                    icon: Icons.calendar_today_outlined,
                    value: controller.selectedYear,
                    items: controller.years,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildDropdown(
                    label: "State",
                    icon: Icons.location_on_outlined,
                    value: controller.selectedState,
                    items: controller.states,
                    isDark: isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // NEET Score Slider & Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "NEET Score (out of 720)",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Obx(
                  () => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEA580C).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${controller.scoreValue.value.toInt()} / 720",
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w900,
                        fontSize: 13.5,
                        color: Color(0xFFEA580C),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Obx(
              () => SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xFFEA580C),
                  inactiveTrackColor: isDark
                      ? AppColors.darkBorder
                      : const Color(0xFFE2E8F0),
                  thumbColor: const Color(0xFFEA580C),
                  overlayColor: const Color(0xFFEA580C).withOpacity(0.2),
                  trackHeight: 6,
                ),
                child: Slider(
                  value: controller.scoreValue.value,
                  min: 0,
                  max: 720,
                  divisions: 720,
                  onChanged: (val) => controller.setScoreFromSlider(val),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Submit Button
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEA580C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.submitPrediction,
                  child: controller.isLoading.value
                      ? const AppLoader(color: Colors.white)
                      : Text(
                          "${controller.selectedExamType.value} Predictor",
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required BuildContext context,
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1.2,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isDark
              ? AppColors.darkTextPrimary
              : AppColors.lightTextPrimary,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.5,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
          prefixIcon: Icon(icon, size: 18, color: const Color(0xFFEA580C)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required RxString value,
    required List<String> items,
    required bool isDark,
  }) {
    return Obx(
      () => Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFFEA580C)),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value.value,
                  isExpanded: true,
                  dropdownColor: isDark ? AppColors.darkCard : Colors.white,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                  items: items
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (newVal) {
                    if (newVal != null) value.value = newVal;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
