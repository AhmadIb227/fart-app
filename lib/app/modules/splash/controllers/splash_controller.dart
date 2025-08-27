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
    // إظهار تدريجي للشعار
    Future.delayed(Duration(milliseconds: 200), () {
      logoVisible.value = true;
    });

    // حركة بسيطة للنمط (تغيير offset كل فترة)
    _timer = Timer.periodic(Duration(milliseconds: 80), (t) {
      patternOffset += 0.5;
      if (patternOffset > 6) patternOffset = 0;
      update(); // لإعادة بناء view عبر GetBuilder أو Obx مع قيم بسيطة
    });

    // الانتقال بعد 3 ثواني
    Future.delayed(Duration(seconds: 3), () {
      if (storage.isFirstLaunch()) {
        Get.offAllNamed(Routes.onboarding);
      } else {
        Get.offAllNamed(Routes.home);
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
