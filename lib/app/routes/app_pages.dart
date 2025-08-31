// In lib/app/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:messaging_app/app/modules/auth/bindings/auth_binding.dart';
import 'package:messaging_app/app/modules/security/bindings/security_binding.dart';
import 'package:messaging_app/app/modules/security/views/fingerprint_view.dart';
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
    GetPage(
      name: Routes.OTP,
      page: () => const OtpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.FINGERPRINT,
      page: () => const FingerprintView(),
      binding: SecurityBinding(),
    ),  
  ];
}
