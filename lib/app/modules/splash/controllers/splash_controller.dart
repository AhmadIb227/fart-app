import 'dart:async';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    Timer(const Duration(seconds: 1), () {
      Get.offAllNamed(AppRoutes.onboarding);
    });
    super.onReady();
  }
}
