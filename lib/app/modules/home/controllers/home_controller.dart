import 'dart:io';
import 'package:get/get.dart';
import '../../../services/storage_service.dart';

class HomeController extends GetxController {
  final Rx<File?> avatar = Rx<File?>(null);
  final RxString name = ''.obs;

  @override
  void onInit() {
    final path = StorageService.getString(StorageService.kAvatarPath);
    final n = StorageService.getString(StorageService.kUserName);
    if (path != null) avatar.value = File(path);
    if (n != null) name.value = n;
    super.onInit();
  }
}
