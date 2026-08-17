import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../../../theme/app_colors.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -60,
            right: -60,
            child:
                Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.25, 1.25),
                      duration: 2200.ms,
                    ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 28,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.school_rounded,
                          size: 50,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                    .animate()
                    .scale(duration: 700.ms, curve: Curves.easeOutBack)
                    .shimmer(
                      delay: 500.ms,
                      duration: 1000.ms,
                      color: AppColors.accent.withOpacity(0.4),
                    ),

                const SizedBox(height: 28),

                RichText(
                      text: const TextSpan(
                        text: "Career",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.8,
                        ),
                        children: [
                          TextSpan(
                            text: "Marg",
                            style: TextStyle(color: AppColors.accent),
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 250.ms, duration: 500.ms)
                    .moveY(begin: 12, end: 0, curve: Curves.easeOutCubic),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: const Text(
                    "AI-POWERED NEET & MBBS ADMISSION",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                ).animate().fadeIn(delay: 450.ms, duration: 500.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
