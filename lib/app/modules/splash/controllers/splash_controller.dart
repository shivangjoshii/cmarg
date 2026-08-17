import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _handleBoot();
  }

  void _handleBoot() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offNamed(Routes.ONBOARDING);
  }
}