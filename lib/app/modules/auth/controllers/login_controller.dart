import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:messaging_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  // Reactive state variables
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  // Form key to manage form state
  final formKey = GlobalKey<FormState>();

  // Declare controllers as 'late'
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var rememberMe = false.obs;

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Initialize controllers here, before they are ever used
    emailController = TextEditingController();
    passwordController = TextEditingController();

    if (storage.read('email') != null) {
      emailController.text = storage.read('email');
      rememberMe.value = true;
    }
  }

  @override
  void onClose() {
    // Dispose of controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      try {
        isLoading.value = true;
        await Future.delayed(const Duration(seconds: 2));

        if (emailController.text == "test@test.com" &&
            passwordController.text == "123456") {
          // --- بداية التعديلات ---

          // 1. أوقف التحميل أولاً
          isLoading.value = false;

          if (rememberMe.value) {
            await storage.write('email', emailController.text);
          } else {
            await storage.remove('email');
          }

          Get.snackbar(
            "Login Success",
            "Welcome back!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
          );

          // 2. استخدم toNamed بدلاً من offAllNamed للسماح بالرجوع
          Get.toNamed(Routes.OTP);

          // --- نهاية التعديلات ---
        } else {
          throw "Incorrect email or password";
        }
      } catch (error) {
        Get.snackbar(
          "Login Failed",
          error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
        );
      } finally {
        // 3. تأكد من إيقاف التحميل أيضًا في حالة الفشل أو الخطأ
        if (isLoading.value) {
          isLoading.value = false;
        }
      }
    }
  }
}
