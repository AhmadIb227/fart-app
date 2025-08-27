import 'package:get/get.dart';
import '../modules/splash/controllers/splash_controller.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splash/views/onboarding_view.dart';
import '../modules/home/views/home_view.dart';
import '../routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashView(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => OnboardingView(),
      binding: BindingsBuilder(() {
        // Onboarding controller created inside view file on first use
      }),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeView(),
    ),
  ];
}
