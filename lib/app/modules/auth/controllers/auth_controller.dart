import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../data/services/security_service.dart';

class AuthController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final List<TextEditingController> otpControllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> otpFocusNodes = List.generate(4, (_) => FocusNode());

  var isLoading = false.obs;
  var isOtpSent = false.obs;
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
      AppToast.error("Invalid Number", "Please enter a valid 10-digit mobile number");
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 900)); // API Simulation
    isLoading.value = false;

    isOtpSent.value = true;
    startResendTimer();
    AppToast.success("OTP Sent", "A 4-digit code was sent to +91 $phone (Use 1234)");
  }

  void verifyOtp() async {
    final otp = otpControllers.map((e) => e.text).join();
    if (otp.length != 4) {
      AppToast.error("Incomplete Code", "Please enter the complete 4-digit OTP");
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 900)); // API Simulation

    if (otp == "1234") {
      await SecurityService.saveToken("mock_jwt_careermarg_token_9921");
      isLoading.value = false;
      AppToast.success("Success", "Welcome to CareerMarg!");
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      isLoading.value = false;
      AppToast.error("Invalid Code", "The OTP code entered is incorrect. Try 1234");
    }
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
    if (otpControllers.every((c) => c.text.isNotEmpty)) {
      verifyOtp();
    }
  }
}