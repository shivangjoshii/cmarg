import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/onboarding_item_model.dart';
import '../../../data/services/security_service.dart';
import '../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  final List<OnboardingSlide> slides = [
    OnboardingSlide(
      title: "India's Smart NEET & MBBS Admission Platform",
      card1Title: "ISO 9001:2015",
      card1Subtitle: "Certified counseling guidance since 2006.",
      card2Tag: "VERIFIED ADMISSIONS",
      card2Text: "Access verified cut-offs, fee structures & quotas.",
      card2Subtext: "NMC • WHO • Ministry Approved",
      statsCount: "50K+",
      statsLabel: "Students Guided",
      statsSub: "Across 14+ Countries",
      card4Text: "Top Medical Specialists",
      card4Tag: "Expert Panel",
      card4Image:
          "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&q=80&w=600",
    ),
    OnboardingSlide(
      title: "AI Powered NEET College Predictor",
      card1Title: "Instant Match",
      card1Subtitle: "Predict top government & private colleges by rank.",
      card2Tag: "ALGORITHM 2.0",
      card2Text: "Smart calculation on past 10 years cutoff matrix.",
      card2Subtext: "All India & State Quotas",
      statsCount: "5000+",
      statsLabel: "Listed Colleges",
      statsSub: "Realtime Matrix",
      card4Text: "Accurate Projections",
      card4Tag: "AI Engine",
      card4Image:
          "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&q=80&w=600",
    ),
    OnboardingSlide(
      title: "Study MBBS Abroad with Zero Hassle",
      card1Title: "Global Direct",
      card1Subtitle: "Bangladesh, Nepal, Russia, Kazakhstan & more.",
      card2Tag: "FULL VISA ASSIST",
      card2Text: "NMC recognized institutes with low budget tuition.",
      card2Subtext: "Direct Campus Coordination",
      statsCount: "20+",
      statsLabel: "Years Experience",
      statsSub: "Global Presence",
      card4Text: "MCI / FMGE Training",
      card4Tag: "MCI Certified",
      card4Image:
          "https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&q=80&w=600",
    ),
    OnboardingSlide(
      title: "1-on-1 Personalized Medical Mentorship",
      card1Title: "Post-Admission",
      card1Subtitle: "We stay with you throughout your complete course.",
      card2Tag: "ACTIVE DOCTOR CARE",
      card2Text: "Connect with doctors & mentors for ongoing guidance.",
      card2Subtext: "24/7 Student Desk",
      statsCount: "4.8/5",
      statsLabel: "Student Rating",
      statsSub: "100% Trust Index",
      card4Text: "Verified Mentors",
      card4Tag: "1-on-1 Direct",
      card4Image:
          "https://images.unsplash.com/photo-1582750433449-648ed127bb54?auto=format&fit=crop&q=80&w=600",
    ),
  ];

  Future<void> _completeOnboarding() async {
    await SecurityService.setOnboardingSeen();
    Get.offNamed(Routes.AUTH);
  }

  void onNext() {
    if (currentPage.value < slides.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _completeOnboarding();
    }
  }

  void onSkip() {
    _completeOnboarding();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
