import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  final RxBool isConnected = true.obs;

  Timer? _offlineGraceTimer;
  bool _isOnNoInternetScreen = false;

  @override
  void onInit() {
    super.onInit();
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    final results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    bool hasConnection = results.any((result) => result != ConnectivityResult.none);

    if (!hasConnection && isConnected.value) {
      isConnected.value = false;
      _showNoInternetSnackbar();
      _startOfflineTimeout();
    } else if (hasConnection && !isConnected.value) {
      isConnected.value = true;
      _offlineGraceTimer?.cancel();

      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }

      if (_isOnNoInternetScreen) {
        _isOnNoInternetScreen = false;
        Get.back();
      }
    }
  }

  void _startOfflineTimeout() {
    _offlineGraceTimer?.cancel();
    _offlineGraceTimer = Timer(const Duration(minutes: 1), () {
      if (!isConnected.value && !_isOnNoInternetScreen) {
        _isOnNoInternetScreen = true;
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
        Get.toNamed(Routes.NO_INTERNET);
      }
    });
  }

  void _showNoInternetSnackbar() {
    Get.rawSnackbar(
      messageText: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.wifi_off_rounded, color: Colors.white, size: 20),
              SizedBox(width: 12),
              Text(
                'No Internet Connection',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary,
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(days: 1),
      isDismissible: false,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  Future<void> retryConnection() async {
    final results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);
  }

  @override
  void onClose() {
    _subscription.cancel();
    _offlineGraceTimer?.cancel();
    super.onClose();
  }
}