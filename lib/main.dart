import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/core/theme/app_colors.dart';
import 'app/core/theme/app_text_styles.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fart App',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundGray,
            primaryColor: AppColors.primaryGreen,
            textTheme: AppTextStyles.textTheme,
            useMaterial3: true,
          ),
          // فتح التطبيق مباشرة على صفحة Register
          initialRoute: AppRoutes.profileSetup,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
