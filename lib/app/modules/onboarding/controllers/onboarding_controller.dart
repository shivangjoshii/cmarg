import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
}

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnboardingController>(OnboardingController());
  }
}