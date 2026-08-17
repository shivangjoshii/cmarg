import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/predictor_data_model.dart';
import '../../../routes/app_routes.dart';
import '../../../../core/utils/app_toast.dart';

class PredictorController extends GetxController {
  final fullNameController = TextEditingController(text: "Pawan");
  final mobileController = TextEditingController(text: "09279812411");
  final emailController = TextEditingController(
    text: "info.shivangg@gmail.com",
  );
  final scoreController = TextEditingController(text: "620");

  var selectedExamType = "NEET UG".obs;
  var selectedYear = "2026".obs;
  var selectedState = "Bihar".obs;
  var scoreValue = 620.0.obs;
  var isLoading = false.obs;

  final List<String> examTypes = ["NEET UG", "NEET PG", "MDS"];
  final List<String> years = ["2026", "2025", "2024"];
  final List<String> states = [
    "Bihar",
    "Delhi",
    "Maharashtra",
    "Karnataka",
    "Uttar Pradesh",
    "West Bengal",
  ];

  void setScoreFromSlider(double val) {
    scoreValue.value = val;
    scoreController.text = val.toInt().toString();
  }

  void setScoreFromText(String val) {
    final parsed = double.tryParse(val);
    if (parsed != null && parsed >= 0 && parsed <= 720) {
      scoreValue.value = parsed;
    }
  }

  void submitPrediction() async {
    final name = fullNameController.text.trim();
    final mobile = mobileController.text.trim();
    final email = emailController.text.trim();
    final score = scoreValue.value.toInt();

    if (name.isEmpty || mobile.isEmpty || email.isEmpty) {
      AppToast.error(
        "Required Fields",
        "Please complete all fields to calculate prediction.",
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 900));
    isLoading.value = false;

    Get.back(); // Dismiss bottom sheet

    final inputData = PredictorInputData(
      examType: selectedExamType.value,
      fullName: name,
      mobileNo: mobile,
      email: email,
      year: selectedYear.value,
      state: selectedState.value,
      score: score,
    );

    Get.toNamed(Routes.PREDICTOR_RESULT, arguments: inputData);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    scoreController.dispose();
    super.onClose();
  }
}
