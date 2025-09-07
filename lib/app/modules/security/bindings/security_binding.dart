import 'package:get/get.dart';
import '../controllers/fingerprint_controller.dart';
import '../controllers/pin_setup_controller.dart'; // إضافة جديدة

class SecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FingerprintController>(() => FingerprintController());
    Get.lazyPut<PinSetupController>(() => PinSetupController()); // إضافة جديدة
  }
}
