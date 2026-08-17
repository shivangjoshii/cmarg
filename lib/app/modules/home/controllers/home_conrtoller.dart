import 'dart:async';
import 'package:cmarg/app/modules/home/model/college_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 
class HomeController extends GetxController {
  final PageController bannerPageController = PageController();
  final TextEditingController searchController = TextEditingController();

  var currentBannerIndex = 0.obs;
  Timer? _bannerTimer;

  final List<Map<String, String>> banners = [
    {
      'tag': 'NEET 2026 GUIDANCE',
      'title': 'Top Medical Colleges in India',
      'subtitle':
          'Verified cutoffs, seat matrices & round-wise fee structures.',
      'image':
          'https://images.unsplash.com/photo-1562774053-701939374585?w=800&auto=format&fit=crop&q=80',
    },
    {
      'tag': 'STUDY ABROAD',
      'title': 'NMC & WHO Recognized MBBS',
      'subtitle':
          'Direct seat booking in top universities of Bangladesh, Russia & Georgia.',
      'image':
          'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=800&auto=format&fit=crop&q=80',
    },
    {
      'tag': '1-ON-1 COUNSELLING',
      'title': 'AI Rank & Choice Predictor',
      'subtitle':
          'Plan choice filling strategies with top doctors and specialists.',
      'image':
          'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&auto=format&fit=crop&q=80',
    },
  ];

  final List<CollegeModel> featuredColleges = [
    CollegeModel(
      id: 'pmch_patna',
      name: 'Patna Medical College & Hospital (PMCH)',
      location: 'Patna, Bihar',
      type: 'Govt. Medical College',
      rating: '4.8',
      reviewsCount: '240+ Reviews',
      fee: 'INR 1.2 Lakh / yr',
      established: '1925',
      approvedBy: 'NMC & Ministry of Health',
      imageUrl:
          'https://images.unsplash.com/photo-1584515979956-d9f6e5d09982?w=800&auto=format&fit=crop&q=80',
      bannerUrl:
          'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=1200&auto=format&fit=crop&q=80',
      description:
          'One of the premier and oldest medical institutions in North India, PMCH delivers world-class clinical training with over 3,000+ bed capacity across specialty departments.',
      highlights: [
        'Over 200 Annual MBBS Seat Capacity',
        'Direct Govt. Hospital Attached with High OPD Footfall',
        'Extensive PG & Super-Speciality Research Wings',
        'Affordable subsidized tuition fees with hostel infrastructure',
      ],
      coursesOffered: [
        'MBBS (5.5 Yrs)',
        'MD Internal Medicine',
        'MS General Surgery',
        'Diploma in Child Health',
      ],
    ),
    CollegeModel(
      id: 'dhaka_national',
      name: 'Dhaka National Medical College',
      location: 'Dhaka, Bangladesh',
      type: 'NMC Recognized Direct MBBS',
      rating: '4.9',
      reviewsCount: '310+ Reviews',
      fee: 'INR 32 Lakh Total Course',
      established: '1925',
      approvedBy: 'NMC, WHO & BMDC',
      imageUrl:
          'https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=800&auto=format&fit=crop&q=80',
      bannerUrl:
          'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=1200&auto=format&fit=crop&q=80',
      description:
          'A top choice for Indian MBBS aspirants, Dhaka National Medical College follows an identical syllabus to India with English medium instruction and strong FMGE/NExT pass rates.',
      highlights: [
        'Similar Disease Spectrum & Medical Curriculum to India',
        'English Medium Complete Theoretical & Clinical Teaching',
        'NMC & WHO Listed for direct eligibility in India & Abroad',
        'Dedicated Separate Hostel & Mess for Indian Students',
      ],
      coursesOffered: ['MBBS International Batch', 'Clinical Internships'],
    ),
    CollegeModel(
      id: 'kmc_manipal',
      name: 'Kasturba Medical College (KMC)',
      location: 'Manipal, Karnataka',
      type: 'Deemed University (Grade A++)',
      rating: '4.9',
      reviewsCount: '580+ Reviews',
      fee: 'INR 17.8 Lakh / yr',
      established: '1953',
      approvedBy: 'NMC & NIRF Ranked #9',
      imageUrl:
          'https://images.unsplash.com/photo-1592280771190-3e2e4d571952?w=800&auto=format&fit=crop&q=80',
      bannerUrl:
          'https://images.unsplash.com/photo-1571260899304-425eee4c7efc?w=1200&auto=format&fit=crop&q=80',
      description:
          'Consistently ranked among the top 10 medical colleges in India, KMC Manipal boasts cutting-edge simulation labs, global tie-ups, and unmatched academic infrastructure.',
      highlights: [
        'NIRF All India Medical Rank #9',
        'Advanced Simulation Hospital & Robotics Surgical Wings',
        'USMLE, PLAB & NExT Integrated Curriculum Support',
        'State of the Art Global Multi-Disciplinary Campus',
      ],
      coursesOffered: [
        'MBBS',
        'MD Radiodiagnosis',
        'MS Orthopaedics',
        'DM Cardiology',
      ],
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _startBannerAutoPlay();
  }

  void _startBannerAutoPlay() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (bannerPageController.hasClients) {
        int nextIndex = (currentBannerIndex.value + 1) % banners.length;
        bannerPageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
        currentBannerIndex.value = nextIndex;
      }
    });
  }

  @override
  void onClose() {
    _bannerTimer?.cancel();
    bannerPageController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
