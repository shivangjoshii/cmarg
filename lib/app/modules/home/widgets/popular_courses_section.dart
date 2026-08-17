import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class PopularCoursesSection extends StatelessWidget {
  final bool isDark;

  const PopularCoursesSection({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> courses = [
      {
        'title': 'MBBS India',
        'duration': '5.5 Yrs',
        'icon': Icons.medical_services_rounded,
        'color': AppColors.primary,
      },
      {
        'title': 'MBBS Abroad',
        'duration': '6 Yrs (NMC)',
        'icon': Icons.public_rounded,
        'color': const Color(0xFF0284C7),
      },
      {
        'title': 'BDS Dental',
        'duration': '5 Yrs',
        'icon': Icons.healing_rounded,
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'MD / MS Clinical',
        'duration': '3 Yrs PG',
        'icon': Icons.biotech_rounded,
        'color': const Color(0xFFEA580C),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Popular Medical Courses",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                "View All",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final course = courses[index];
              return Container(
                width: 140,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkBorder
                        : AppColors.lightBorder,
                    width: 1.2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      course['icon'] as IconData,
                      color: course['color'] as Color,
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course['title'] as String,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    Text(
                      course['duration'] as String,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
