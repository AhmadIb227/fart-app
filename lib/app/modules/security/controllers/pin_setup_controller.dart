import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:messaging_app/app/routes/app_pages.dart';

class PinSetupController extends GetxController {
  final storage = GetStorage();

  void savePin(String pin) async {
    // Here you would typically hash the PIN before saving
    await storage.write('user_pin', pin);
    await storage.write('is_pin_enabled', true);

    Get.snackbar('Success', 'Your PIN has been saved securely.');
    await Future.delayed(const Duration(seconds: 1));
    Get.offAllNamed(Routes.LOGIN); // Navigate to home
  }
}
