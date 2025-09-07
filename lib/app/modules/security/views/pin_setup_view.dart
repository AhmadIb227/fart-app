import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../controllers/pin_setup_controller.dart';

class PinSetupView extends GetView<PinSetupController> {
  const PinSetupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set PIN Security'),
        backgroundColor: const Color(0xFF1B4332),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Create a secure PIN',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'This PIN will be used to access your account.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              Pinput(
                length: 6,
                obscureText: true,
                onCompleted: (pin) => controller.savePin(pin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
