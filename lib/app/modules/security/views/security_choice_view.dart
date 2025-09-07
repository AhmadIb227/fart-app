import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messaging_app/app/routes/app_pages.dart';

class SecurityChoiceView extends StatelessWidget {
  const SecurityChoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.security, size: 80, color: Color(0xFF1B4332)),
              const SizedBox(height: 24),
              const Text(
                'Add Extra Security',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Please choose a security method to protect your account.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                icon: const Icon(Icons.pin),
                label: const Text('Set PIN Security'),
                onPressed: () {
                  Get.toNamed(Routes.PIN_SETUP);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B4332),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.fingerprint),
                label: const Text('Set Fingerprint Security'),
                onPressed: () {
                  Get.toNamed(Routes.FINGERPRINT);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B4332),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  // Navigate to home or main app screen
                  Get.offAllNamed(Routes.LOGIN); // Currently goes back to login
                },
                child: const Text(
                  'Skip for now',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
