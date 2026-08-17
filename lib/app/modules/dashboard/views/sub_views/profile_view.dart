import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_colors.dart';
import '../../controllers/dashboard_controller.dart';

class ProfileView extends GetView<DashboardController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppColors.error),
            onPressed: controller.logout,
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Applicant Account & Documents",
          style: TextStyle(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}