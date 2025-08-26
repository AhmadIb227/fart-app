import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // 1. استيراد الحزمة
import 'app/routes/app_pages.dart';

void main() async {
  // 2. تحويل الدالة إلى async
  await GetStorage.init(); // 3. تهيئة GetStorage

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
