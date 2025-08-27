import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/assets.dart';
import '../../../core/values/strings.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<Offset> _logoAnimation;

  late AnimationController _textController;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    // تحريك اللوغو من الأسفل ببطء
    _logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _logoAnimation = Tween<Offset>(
      begin: Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOut,
    ));

    // ظهور النص تدريجي ببطء
    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    // تسلسل الحركة
    _logoController.forward().then((_) {
      _textController.forward();
      // إبقاء الشاشة لمدة 3 ثواني إضافية بعد ظهور كل شيء
      Future.delayed(Duration(seconds: 3), () {
        // هنا يمكنك الانتقال للصفحة الرئيسية أو أي وظيفة أخرى
        // مثال: Get.offNamed('/home');
      });
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();

    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: Stack(
        children: [
          // الخلفية ثابتة
          Positioned.fill(
            child: Opacity(
              opacity: 0.12,
              child: Image.asset(
                AppAssets.pattern,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // اللوغو والنص
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SlideTransition(
                  position: _logoAnimation,
                  child: Image.asset(AppAssets.logo, width: 160, height: 160),
                ),
                SizedBox(height: 14),
                FadeTransition(
                  opacity: _textAnimation,
                  child: Column(
                    children: [
                      Text(
                        AppStrings.splashQuote,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        AppStrings.version,
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
