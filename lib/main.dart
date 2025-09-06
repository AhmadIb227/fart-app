import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/services/storage_service.dart';
import 'app/core/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة التخزين المحلي
  await GetStorage.init();
  
  // تسجيل خدمة التخزين في GetX
  Get.put(StorageService());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Onboarding App',
      debugShowCheckedModeBanner: false,
      
      // أول صفحة
      initialRoute: Routes.splash,

      // جميع الصفحات من AppPages
      getPages: AppPages.pages,

      // الثيم العام
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundGray,
        primaryColor: AppColors.primaryGreen,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
    );
  }
}
