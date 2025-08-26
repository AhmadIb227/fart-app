import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return const Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: AppColors.greenGradient),
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
    );
  }
}
