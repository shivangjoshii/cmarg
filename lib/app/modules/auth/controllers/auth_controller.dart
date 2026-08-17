import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/services/security_service.dart';
import '../../../routes/app_routes.dart';
import '../../../../core/utils/app_toast.dart';

class AuthController extends GetxController {
  final TextEditingController phoneController = TextEditingController();

  // 6-digit OTP configuration
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());

  var isLoading = false.obs;
  var isSuccess = false.obs;
  var timerSeconds = 30.obs;
  Timer? _timer;

  @override
  void onClose() {
    phoneController.dispose();
    for (var c in otpControllers) {
      c.dispose();
    }
    for (var f in otpFocusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }

  void startResendTimer() {
    timerSeconds.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void sendOtp() async {
    final phone = phoneController.text.trim();
    if (phone.length != 10) {
      AppToast.error(
        "Invalid Number",
        "Please enter a valid 10-digit mobile number",
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1200)); // API simulation
    isLoading.value = false;

    startResendTimer();
    AppToast.success("OTP Sent", "Use demo 6-digit code: 123456");
    Get.toNamed(Routes.OTP);
  }

  // Handle precise backspace navigation when a box is already empty
  KeyEventResult handleOtpKey(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (otpControllers[index].text.isEmpty && index > 0) {
        otpControllers[index - 1].clear();
        otpFocusNodes[index - 1].requestFocus();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        otpFocusNodes[index + 1].requestFocus();
      }
    }

    // Auto submit when all 6 digits are typed
    if (otpControllers.every((c) => c.text.isNotEmpty)) {
      verifyOtp();
    }
  }

  void verifyOtp() async {
    final otp = otpControllers.map((e) => e.text).join();
    if (otp.length != 6) {
      AppToast.error(
        "Incomplete Code",
        "Please enter the complete 6-digit OTP",
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 1200)); // API simulation

    if (otp == "123456") {
      isLoading.value = false;
      isSuccess.value = true;
      await SecurityService.saveToken("mock_jwt_careermarg_token_9921");

      // Delay for success check animation before entering Dashboard
      await Future.delayed(const Duration(milliseconds: 900));
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      isLoading.value = false;
      AppToast.error(
        "Invalid Code",
        "The OTP entered is incorrect. Try 123456",
      );
    }
  }
}
