import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messaging_app/app/routes/app_pages.dart';

class OtpController extends GetxController {
  // للتحكم في حقل إدخال Pinput
  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();

  // متغيرات الحالة
  var isLoading = false.obs;
  var isOtpError = false.obs;

  // متغيرات مؤقت إعادة الإرسال
  var isResendEnabled = false.obs;
  var resendTimer = 30.obs;
  late Timer _timer;

  // هذا هو الرمز الصحيح للمحاكاة
  final String correctOtp = "222222";

  @override
  void onInit() {
    super.onInit();
    startResendTimer(); // بدء المؤقت عند فتح الشاشة
  }

  @override
  void onClose() {
    _timer.cancel(); // إلغاء المؤقت لمنع تسرب الذاكرة
    otpController.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }

  // دالة لبدء مؤقت إعادة الإرسال
  void startResendTimer() {
    isResendEnabled.value = false;
    resendTimer.value = 30; // إعادة تعيين المؤقت إلى 30 ثانية
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        isResendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  // دالة لإعادة إرسال الرمز
  void resendOtp() {
    // هنا يمكنك وضع منطق إعادة إرسال الرمز الفعلي
    Get.snackbar("OTP", "A new code has been sent.");
    startResendTimer(); // إعادة تشغيل المؤقت
  }

  // دالة التحقق من الرمز
  void verifyOtp(String pin) async {
    isOtpError.value = false; // إخفاء أي خطأ سابق
    isLoading.value = true;

    // محاكاة انتظار للتحقق
    await Future.delayed(const Duration(seconds: 1));

    if (pin == correctOtp) {
      // إذا كان الرمز صحيحًا
      Get.offAllNamed(Routes.LOGIN); // انتقل إلى الشاشة الرئيسية
    } else {
      // إذا كان الرمز خاطئًا
      isOtpError.value = true;
    }

    isLoading.value = false;
  }
}