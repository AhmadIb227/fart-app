import 'package:get/get.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splash/views/onboarding_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/profile_setup_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/security/views/pin_setup_view.dart';
import '../modules/security/views/biometric_setup_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingView()),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.profileSetup,
      page: () => const ProfileSetupView(),
      binding: AuthBinding(),
    ),
    GetPage(name: AppRoutes.home, page: () => const HomeView()),
    GetPage(name: AppRoutes.pinSetup, page: () => const PinSetupView()),
    GetPage(
      name: AppRoutes.biometricSetup,
      page: () => const BiometricSetupView(),
    ),
  ];
}
