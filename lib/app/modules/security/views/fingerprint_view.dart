import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/fingerprint_controller.dart';

class FingerprintView extends GetView<FingerprintController> {
  const FingerprintView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Fingerprint Security', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'Set Fingerprint Security',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Secure your account with your fingerprint using Registered Biometric',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Spacer(),
            Obx(() => _buildStatusIcon()),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.skip,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text('Skip', style: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.authenticate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B4332),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Continue'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    switch (controller.authStatus.value) {
      case AuthStatus.idle:
        return const Icon(Icons.fingerprint, size: 120, color: Colors.grey);
      case AuthStatus.scanning:
        return const CircularProgressIndicator();
      case AuthStatus.success:
        return const Icon(Icons.check_circle, size: 120, color: Colors.green);
      case AuthStatus.failed:
        return const Icon(Icons.error, size: 120, color: Colors.red);
    }
  }
}