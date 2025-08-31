import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messaging_app/app/routes/app_pages.dart';

class OtpController extends GetxController {

  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();

  var isLoading = false.obs;
  var isOtpError = false.obs;

  var isResendEnabled = false.obs;
  var resendTimer = 30.obs;
  late Timer _timer;

  final String correctOtp = "222222";

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

  @override
  void onClose() {
    _timer.cancel();
    otpController.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }

  void startResendTimer() {
    isResendEnabled.value = false;
    resendTimer.value = 30; 
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        isResendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    Get.snackbar("OTP", "A new code has been sent.");
    startResendTimer(); 
  }

  void verifyOtp(String pin) async {
    isOtpError.value = false; 
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    if (pin == correctOtp) {
      Get.toNamed(Routes.FINGERPRINT);
    } else {
      isOtpError.value = true;
    }

    isLoading.value = false;
  }
}