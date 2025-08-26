import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoginController());
    return Scaffold(
      body: Center(
        child: Obx(
          () => PrimaryButton(
            label: c.isLoading.value ? 'Loading...' : 'Login',
            onPressed: c.isLoading.value ? null : c.fakeLogin,
          ),
        ),
      ),
    );
  }
}
