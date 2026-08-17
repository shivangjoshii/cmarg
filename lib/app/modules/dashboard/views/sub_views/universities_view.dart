import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class UniversitiesView extends StatelessWidget {
  const UniversitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text("Colleges & Universities"),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text(
          "5000+ Listed Medical Colleges",
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