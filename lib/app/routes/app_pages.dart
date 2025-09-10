import 'package:get/get.dart';

import '../modules/splash/controllers/splash_controller.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/splash/views/onboarding_view.dart';

import '../modules/profile/views/profile_view.dart';

import '../modules/more/controllers/more_controller.dart';
import '../modules/more/views/more_view.dart';

// الصفحات الجديدة
import '../modules/info/views/terms_view.dart';
import '../modules/info/views/privacy_view.dart';
import '../modules/info/views/about_app_view.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.splash,
      page: () => SplashView(),
      binding: BindingsBuilder.put(() => SplashController()),
    ),
    GetPage(name: Routes.onboarding, page: () => OnboardingView()),
    GetPage(name: Routes.profile, page: () => const ProfileView()),

    // More + الكنترولر
    GetPage(
      name: Routes.more,
      page: () => const MoreView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MoreController>(() => MoreController(), fenix: true);
      }),
    ),

    // المعلومات
    GetPage(name: Routes.terms, page: () => const TermsView()),
    GetPage(name: Routes.privacy, page: () => const PrivacyView()),
    GetPage(name: Routes.aboutApp, page: () => const AboutAppView()),
  ];
}
