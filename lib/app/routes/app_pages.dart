// In lib/app/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:messaging_app/app/modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/otp_view.dart';


part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage( // الصفحة الجديدة
      name: Routes.OTP,
      page: () => const OtpView(),
      binding: AuthBinding(),
    ),
  ];
}
