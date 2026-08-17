import 'package:cmarg/app/modules/home/controllers/home_conrtoller.dart';
import 'package:cmarg/app/modules/home/widgets/sticky_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../home/widgets/home_banner_carousel.dart';
import '../../../home/widgets/popular_courses_section.dart';
import '../../../home/widgets/featured_colleges_section.dart';
import '../../../../theme/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<HomeController>()
        ? Get.find<HomeController>()
        : Get.put(HomeController());

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            // 1. Top Header Bar (Scrolls away naturally)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/image.png',
                      height: 28,
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => const Text(
                        "CareerMarg",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                          width: 1.2,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.notifications_none_rounded,
                          size: 19,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                          width: 1.2,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.menu_rounded,
                          size: 19,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Banner Carousel with negative bottom margin to enable overlap
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: -26,
                ), // Pulls the search bar over the banner
                child: HomeBannerCarousel(
                  controller: controller,
                  isDark: isDark,
                ),
              ),
            ),

            // 3. Pinned Sticky Search Bar (Overlaps banner initially, sticks to top when scrolling)
            SliverPersistentHeader(
              pinned: true,
              delegate: HomeStickySearchBarDelegate(
                searchController: controller.searchController,
                isDark: isDark,
              ),
            ),

            // 4. Popular Medical Courses Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: PopularCoursesSection(isDark: isDark),
              ),
            ),

            // 5. Featured Colleges Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: FeaturedCollegesSection(
                  controller: controller,
                  isDark: isDark,
                ),
              ),
            ),

            // Bottom Spacing for Floating Glass Dock
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }
}
