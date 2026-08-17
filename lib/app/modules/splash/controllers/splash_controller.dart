import 'package:get/get.dart';
import '../../../data/services/security_service.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _handleBoot();
  }

  void _handleBoot() async {
    await Future.delayed(const Duration(seconds: 2));

    final bool seenOnboarding = await SecurityService.hasSeenOnboarding();
    final String? token = await SecurityService.getToken();

    if (!seenOnboarding) {
      Get.offNamed(Routes.ONBOARDING);
    } else if (token != null && token.isNotEmpty) {
      Get.offNamed(Routes.DASHBOARD);
    } else {
      Get.offNamed(Routes.AUTH);
    }
  }
}