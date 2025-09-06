import 'dart:async';
import 'package:get/get.dart';
import '../../../services/storage_service.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  final StorageService storage = Get.find<StorageService>();

  var logoVisible = false.obs;
  Timer? _timer;
  double patternOffset = 0.0;

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(milliseconds: 200), () {
      logoVisible.value = true;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 80), (t) {
      patternOffset += 0.5;
      if (patternOffset > 6) patternOffset = 0;
      update();
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (storage.isFirstLaunch()) {
        Get.offAllNamed(Routes.onboarding);
      } else {
        Get.offAllNamed(Routes.profile); // ← بدل Home إلى Profile
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
