import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/services/storage_service.dart';
import 'app/core/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // تهيئة التخزين
  Get.put(StorageService()); // تسجيل الخدمة
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Onboarding App',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundGray,
        primaryColor: AppColors.primaryGreen,
        fontFamily: 'Roboto',
      ),
    );
  }
}
