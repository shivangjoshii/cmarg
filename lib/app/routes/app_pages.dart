import 'package:cmarg/app/modules/auth/bindings/auth_binding.dart';
import 'package:cmarg/app/modules/auth/views/auth_view.dart';
import 'package:cmarg/app/modules/auth/views/otp_view.dart';
import 'package:cmarg/app/modules/network/no_internet_view.dart';
import 'package:cmarg/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:cmarg/app/modules/onboarding/views/onboarding_view.dart';
import 'package:cmarg/app/modules/splash/bindings/splash_binding.dart';
import 'package:cmarg/app/modules/splash/views/splash_view.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.NO_INTERNET,
      page: () => const NoInternetView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.OTP,
      page: () => const OtpView(),
      transition: Transition.cupertino,
    ),
  ];
}
