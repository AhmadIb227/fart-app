import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../controllers/profile_setup_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ProfileSetupController>(() => ProfileSetupController());
  }
}
