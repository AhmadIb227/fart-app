import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:messaging_app/app/routes/app_pages.dart';

enum SupportState { unknown, supported, unsupported }
enum AuthStatus { idle, scanning, success, failed }

class FingerprintController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  final storage = GetStorage();

  var supportState = SupportState.unknown.obs;
  var authStatus = AuthStatus.idle.obs;

  @override
  void onInit() {
    super.onInit();
    auth.isDeviceSupported().then(
          (bool isSupported) => supportState.value =
              isSupported ? SupportState.supported : SupportState.unsupported,
        );
  }

  Future<void> authenticate() async {
    try {
      authStatus.value = AuthStatus.scanning;
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to secure your account',
        options: const AuthenticationOptions(
          stickyAuth: true, // Keep the dialog open on app switch
        ),
      );

      if (didAuthenticate) {
        authStatus.value = AuthStatus.success;
        await storage.write('is_biometric_enabled', true);
        // Wait for a moment so the user can see the success message
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(Routes.LOGIN); // Navigate to the main app screen
      } else {
        authStatus.value = AuthStatus.failed;
      }
    } on PlatformException {
      authStatus.value = AuthStatus.failed;
    }
  }

  void skip() {
    Get.offAllNamed(Routes.LOGIN); // Navigate to home
  }
}