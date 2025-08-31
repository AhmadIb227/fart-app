import 'package:get/get.dart';
import '../controllers/fingerprint_controller.dart';

class SecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FingerprintController>(
      () => FingerprintController(),
    );
  }
}