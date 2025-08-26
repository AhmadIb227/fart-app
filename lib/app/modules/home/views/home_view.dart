import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Obx(() {
          final File? f = controller.avatar.value;
          final n = controller.name.value;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (f != null)
                CircleAvatar(radius: 60, backgroundImage: FileImage(f)),
              const SizedBox(height: 16),
              Text(n.isEmpty ? 'Welcome!' : 'Welcome, $n'),
            ],
          );
        }),
      ),
    );
  }
}
