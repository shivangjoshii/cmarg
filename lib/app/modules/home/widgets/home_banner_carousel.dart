import 'package:cmarg/app/modules/home/controllers/home_conrtoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';

class HomeBannerCarousel extends StatelessWidget {
  final HomeController controller;
  final bool isDark;

  const HomeBannerCarousel({
    super.key,
    required this.controller,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: controller.bannerPageController,
            onPageChanged: (idx) => controller.currentBannerIndex.value = idx,
            itemCount: controller.banners.length,
            itemBuilder: (context, index) {
              final banner = controller.banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        banner['image']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: AppColors.primary),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.92),
                              Colors.black.withOpacity(0.40),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.65, 1.0],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                banner['tag']!,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.darkBackground,
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              banner['title']!,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontSize: 16.5,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              banner['subtitle']!,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        // Indicator Dots
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.banners.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 5,
                width: controller.currentBannerIndex.value == index ? 20 : 6,
                decoration: BoxDecoration(
                  color: controller.currentBannerIndex.value == index
                      ? AppColors.primary
                      : (isDark ? Colors.white24 : Colors.black12),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
