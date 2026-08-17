import 'package:get/get.dart';
import '../../../data/services/security_service.dart';
import '../../../routes/app_routes.dart';
import '../../../../core/utils/app_toast.dart';

class DashboardController extends GetxController {
  final RxInt currentTabIndex = 0.obs;
  DateTime? lastPressedTime;

  void changeTab(int index) {
    currentTabIndex.value = index;
  }

  bool handleBackPress() {
    if (currentTabIndex.value != 0) {
      currentTabIndex.value = 0;
      return false;
    }

    final now = DateTime.now();
    if (lastPressedTime == null ||
        now.difference(lastPressedTime!) > const Duration(seconds: 2)) {
      lastPressedTime = now;
      AppToast.info("Exit App", "Press back again to exit the app");
      return false;
    }
    return true;
  }

  void logout() async {
    await SecurityService.clearAuth();
    AppToast.info("Logged Out", "Signed out successfully");
    Get.offAllNamed(Routes.AUTH);
  }
}
