import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class CounselingView extends StatelessWidget {
  const CounselingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text("1-on-1 Counseling"),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text(
          "Connect with Verified Doctor Mentors",
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