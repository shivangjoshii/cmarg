import 'package:get/get.dart';
import '../../../data/services/security_service.dart';
import '../../../routes/app_routes.dart';
import '../../../../core/utils/app_toast.dart';

class DashboardController extends GetxController {
  void logout() async {
    await SecurityService.clearAuth();
    AppToast.info("Logged Out", "You have been signed out successfully");
    Get.offAllNamed(Routes.AUTH);
  }
}