import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/theme/app_colors.dart';

class AppToast {
  static void success(String title, String message) {
    _showSnackbar(title, message, AppColors.success, Icons.check_circle_outline_rounded);
  }

  static void error(String title, String message) {
    _showSnackbar(title, message, AppColors.error, Icons.error_outline_rounded);
  }

  static void info(String title, String message) {
    _showSnackbar(title, message, AppColors.info, Icons.info_outline_rounded);
  }

  static void _showSnackbar(String title, String message, Color indicatorColor, IconData icon) {
    Get.rawSnackbar(
      titleText: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 14),
      ),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12),
      ),
      icon: Icon(icon, color: indicatorColor, size: 24),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 14,
      backgroundColor: const Color(0xFF1E293B).withOpacity(0.96),
      barBlur: 20,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}