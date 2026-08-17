import 'package:cmarg/app/modules/predictor/models/predictor_data_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/plan_model.dart';
import '../../../routes/app_routes.dart';
import '../../../../core/utils/app_toast.dart';

class PlansController extends GetxController {
  var selectedCategory = 'UG'.obs;

  final List<SubscriptionPlanModel> allPlans = [
    SubscriptionPlanModel(
      id: 'plan_rank_499',
      title: 'Rank Predictor',
      tag: 'Rank',
      originalPrice: '₹999',
      price: 499,
      discountPercentage: 'Save 50%',
      isMostPopular: false,
      category: 'UG',
      features: [
        'Predict Your Exact NEET Rank',
        'Plan Your Counselling Strategy',
        'Estimate Your Rank Before Result',
        'Close Estimate to Final Result',
        'Assists in State & AIQ Counselling',
        'Plan Admission With Pre-Result Data',
      ],
    ),
    SubscriptionPlanModel(
      id: 'plan_essential_1999',
      title: 'Essential Guidance Pack',
      tag: 'Essential',
      originalPrice: '₹3999',
      price: 1999,
      discountPercentage: 'Save 50%',
      isMostPopular: true,
      category: 'UG',
      features: [
        '24×7 Real-Time Cutoff Alerts',
        'Full Rank Predictor Access',
        'College Predictor Access',
        'Regular Counselling Updates & Matrix',
        'Score-Based College Suggestions',
        'College Comparison Tool',
        'Quota-Wise Cut-off Analysis',
        'Payment is Non-Refundable',
      ],
    ),
    SubscriptionPlanModel(
      id: 'plan_smart_2999',
      title: 'Smart Counselling Pro',
      tag: 'Smart',
      originalPrice: '₹5999',
      price: 2999,
      discountPercentage: 'Save 50%',
      isMostPopular: false,
      category: 'UG',
      features: [
        'Essential Guidance Pack Included',
        'Online Choice List Creation',
        'Allotment Data from Previous Years',
        'Custom Choice List During Counselling',
        '50 FREE College Predictions Available',
        'Create Your Wishlist of Colleges',
        'Payment is Non-Refundable',
      ],
    ),
    SubscriptionPlanModel(
      id: 'plan_premium_10000',
      title: 'Premium Counselling Plus',
      tag: 'Premium',
      originalPrice: '₹20000',
      price: 10000,
      discountPercentage: 'Save 50%',
      isMostPopular: false,
      category: 'UG',
      features: [
        'Smart Counselling Pro Package Included',
        'Choice List Provided for Every Round',
        'Dedicated 1-on-1 Doctor Mentor Support',
        'Form & Choice Submission Guidance',
        'Abroad MBBS Direct Admission Support',
        'Applicable for All India & State Quotas',
        'Payment is Non-Refundable',
      ],
    ),
    SubscriptionPlanModel(
      id: 'plan_pg_smart_4999',
      title: 'NEET PG Clinical Pack',
      tag: 'PG Pro',
      originalPrice: '₹9999',
      price: 4999,
      discountPercentage: 'Save 50%',
      isMostPopular: true,
      category: 'PG',
      features: [
        'MD/MS Clinical Seat Matrix',
        'DNB & CPS Seat Availability Alerts',
        'State-Wise Bond Condition Index',
        'Direct Speciality Mentor Allocation',
      ],
    ),
  ];

  List<SubscriptionPlanModel> get currentPlans =>
      allPlans.where((p) => p.category == selectedCategory.value).toList();

  void toggleCategory(String cat) {
    HapticFeedback.selectionClick();
    selectedCategory.value = cat;
  }

  void handlePaymentSuccess(SubscriptionPlanModel plan, String paymentId) {
    AppToast.success(
      "Plan Activated",
      "${plan.title} is now active (ID: $paymentId)",
    );

    Get.back(); // Pop from plans
    final currentArgs = Get.arguments;
    if (currentArgs is PredictorInputData) {
      Get.offNamed(
        Routes.PREDICTOR_RESULT,
        arguments: {'data': currentArgs, 'isUnlocked': true},
      );
    }
  }
}
