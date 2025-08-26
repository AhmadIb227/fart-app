import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../routes/app_routes.dart';
import '../../../services/storage_service.dart';

class ProfileSetupController extends GetxController {
  final Rx<File?> avatarFile = Rx<File?>(null);
  final TextEditingController nameController = TextEditingController();
  final RxBool canContinue = false.obs;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      avatarFile.value = File(picked.path);
      await StorageService.setString(StorageService.kAvatarPath, picked.path);
    }
  }

  void onNameChanged(String v) {
    canContinue.value = v.trim().isNotEmpty;
  }

  Future<void> onContinue() async {
    final name = nameController.text.trim();
    if (name.isNotEmpty) {
      await StorageService.setString(StorageService.kUserName, name);
    }
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  void onInit() {
    final savedPath = StorageService.getString(StorageService.kAvatarPath);
    final savedName = StorageService.getString(StorageService.kUserName);
    if (savedPath != null) avatarFile.value = File(savedPath);
    if (savedName != null) {
      nameController.text = savedName;
      canContinue.value = true;
    }
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
