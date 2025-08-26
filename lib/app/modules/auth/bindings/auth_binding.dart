// In auth_binding.dart
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../controllers/otp_controller.dart'; // استيراد الكنترولر الجديد

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<OtpController>(() => OtpController()); // إضافة الكنترولر الجديد
  }
}
