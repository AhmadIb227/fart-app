import 'package:get/get.dart';

import '../modules/splash/controllers/splash_controller.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splash/views/onboarding_view.dart';

import '../modules/profile/views/profile_view.dart';

import '../modules/more/views/more_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    // Splash (مطلوبة لأنها initialRoute)
    GetPage(
      name: Routes.splash,
      page: () => SplashView(),
      binding: BindingsBuilder.put(() => SplashController()),
    ),

    // Onboarding
    GetPage(name: Routes.onboarding, page: () => OnboardingView()),

    // Profile
    GetPage(name: Routes.profile, page: () => const ProfileView()),

    // More
    GetPage(name: Routes.more, page: () => const MoreView()),
  ];
}
