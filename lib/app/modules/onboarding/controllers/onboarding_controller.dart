import 'package:cmarg/app/modules/onboarding/model/onboarding_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  final List<OnboardingSlide> slides = [
    OnboardingSlide(
      title: "India's Smart NEET & MBBS Admission Platform",
      card1Title: "ISO 9001:2015",
      card1Subtitle: "Certified medical counseling guidance since 2006.",
      card2Text: "Access verified cut-offs, fee details & admission quotas across India.",
      card3Text: "Top Medical Specialists",
      card3Image: "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&q=80&w=600",
      statsCount: "50K+",
      statsLabel: "Students Guided",
    ),
    OnboardingSlide(
      title: "AI Powered NEET College Predictor",
      card1Title: "Instant Match",
      card1Subtitle: "Predict top government & private colleges by rank.",
      card2Text: "Smart algorithms calculating past 10 years of cutoff matrix.",
      card3Text: "Accurate Results",
      card3Image: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&q=80&w=600",
      statsCount: "5000+",
      statsLabel: "Listed Colleges",
    ),
    OnboardingSlide(
      title: "Study MBBS Abroad with Zero Hassle",
      card1Title: "Global Direct",
      card1Subtitle: "Bangladesh, Nepal, Russia, Kazakhstan, & Philippines.",
      card2Text: "NMC & WHO approved medical institutes with complete visa support.",
      card3Text: "MCI / FMGE Training",
      card3Image: "https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&q=80&w=600",
      statsCount: "20+",
      statsLabel: "Years Experience",
    ),
    OnboardingSlide(
      title: "1-on-1 Personalized Medical Mentorship",
      card1Title: "Post-Admission",
      card1Subtitle: "We stay with you throughout your medical journey.",
      card2Text: "Connect with doctors & mentors for screening tests & guidance.",
      card3Text: "Verified Mentors",
      card3Image: "https://images.unsplash.com/photo-1582750433449-648ed127bb54?auto=format&fit=crop&q=80&w=600",
      statsCount: "4.8/5",
      statsLabel: "Student Rating",
    ),
  ];

  void onNext() {
    if (currentPage.value < slides.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Get.offNamed(Routes.AUTH);
    }
  }

  void onSkip() {
    Get.offNamed(Routes.AUTH);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}