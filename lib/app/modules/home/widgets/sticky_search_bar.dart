import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class HomeStickySearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController searchController;
  final bool isDark;

  HomeStickySearchBarDelegate({
    required this.searchController,
    required this.isDark,
  });

  // minExtent: Height when stuck to the top
  @override
  double get minExtent => 68.0;

  // maxExtent: Height at top resting state (accommodating the 26px overlap)
  @override
  double get maxExtent => 94.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Calculate scroll progress (0.0 at rest, 1.0 when fully stuck to top)
    final double progress = (shrinkOffset / (maxExtent - minExtent)).clamp(
      0.0,
      1.0,
    );

    return Container(
      // Smoothly transition background to solid only when pinning to the top
      color: (isDark ? AppColors.darkBackground : AppColors.lightBackground)
          .withOpacity(progress),
      alignment: Alignment.center,
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1B2234) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.35 : 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_rounded,
              color: AppColors.primary,
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: searchController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: "Search medical colleges, cutoffs, states...",
                  hintStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.tune_rounded,
                color: AppColors.primary,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant HomeStickySearchBarDelegate oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
