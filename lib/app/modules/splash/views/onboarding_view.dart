import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/values/assets.dart';
import '../../../core/values/strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../services/storage_service.dart';
import '../../../routes/app_routes.dart';

// Clipper للانحناء المقعر في أعلى اللون الأخضر
class TopConcaveCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    // بداية من الزاوية اليسرى السفلية
    path.moveTo(0, size.height);
    
    // خط رأسي إلى بداية الانحناء
    path.lineTo(0, 60);
    
    // انحناء مقعر على شكل U - الجزء الأيسر
    path.quadraticBezierTo(
      size.width * 0.25, 
      0, // قمة الانحناء المقعر
      size.width * 0.5, 
      60,
    );
    
    // انحناء مقعر على شكل U - الجزء الأيمن
    path.quadraticBezierTo(
      size.width * 0.75, 
      0, // قمة الانحناء المقعر
      size.width, 
      60,
    );
    
    // خط إلى الزاوية اليمنى السفلية
    path.lineTo(size.width, size.height);
    
    // إغلاق المسار
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class OnboardingController extends GetxController {
  final StorageService storage = Get.find<StorageService>();
  final PageController pageController = PageController();
  final currentPage = 0.obs;
  final isLoadingDone = true.obs; // حالة عرض شاشة Loading_Done

  @override
  void onInit() {
    super.onInit();
    // بعد 3 ثواني، إخفاء شاشة Loading_Done
    Future.delayed(Duration(seconds: 3), () {
      isLoadingDone.value = false;
    });
  }

  void onPageChanged(int idx) => currentPage.value = idx;

  void next() {
    if (currentPage.value < 3) {
      pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
    } else {
      done();
    }
  }

  void skip() {
    storage.setOnboardingSeen();
    Get.offAllNamed(Routes.home);
  }

  void done() {
    storage.setOnboardingSeen();
    Get.offAllNamed(Routes.home);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingView extends StatelessWidget {
  OnboardingView({Key? key}) : super(key: key);

  final OnboardingController controller = Get.put(OnboardingController());

  String _svgForIndex(int i) {
    switch (i) {
      case 0:
        return AppAssets.svgCalls;
      case 1:
        return AppAssets.svgEncrypt;
      case 2:
        return AppAssets.svgCross;
      case 3:
        return AppAssets.svgGroup;
      default:
        return AppAssets.svgCalls;
    }
  }

  // شاشة Loading_Done المعدلة
  Widget _buildLoadingDoneScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // حاوية تحتوي على الصورة والنصوص معاً
            Container(
              width: 200,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // صورة vector.png (مكبرة)
                  Image.asset(
                    'assets/images/vector.png', // تأكد من مسار الصحيح للصورة
                    width: 180,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                  
                  // النصوص في وسط الصورة
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // النص "Stay Connected"
                      Text(
                        'Stay Connected',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGreen,
                          letterSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      // النص "Stay Chatting" باللون الأخضر
                      Text(
                        'Stay Chatting',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryGreen,
                          letterSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 60),
            
            // نص الإصدار
            Text(
              'Version 2.1.0', // تم تحديث رقم الإصدار ليطابق الصورة
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
            
            SizedBox(height: 20),
            
            // مؤشر تحميل دائري
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = AppStrings.onboardingPages;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;
    final isVerySmallScreen = size.height < 600;

    return Obx(() {
      // إذا كانت شاشة Loading_Done معروضة
      if (controller.isLoadingDone.value) {
        return _buildLoadingDoneScreen();
      }

      // وإلا عرض شاشة Onboarding العادية
      return Scaffold(
        body: Stack(
          children: [
            // الخلفية الرمادية (الجزء العلوي)
            Container(
              color: Colors.grey[100],
            ),

            // الخلفية الخضراء مع الانحناء المقعر في الأعلى
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: size.height * 0.35,
              child: ClipPath(
                clipper: TopConcaveCurvedClipper(),
                child: Container(
                  color: AppColors.primaryGreen,
                ),
              ),
            ),

            // الجزء العلوي: المحتوى
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: size.height * 0.65,
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: pages.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (ctx, index) {
                  final p = pages[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: isVerySmallScreen 
                              ? size.height * 0.2 
                              : isSmallScreen 
                                  ? size.height * 0.25 
                                  : size.height * 0.3,
                          child: SvgPicture.asset(
                            _svgForIndex(index),
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: isVerySmallScreen ? 12 : isSmallScreen ? 16 : 24),
                        Text(
                          p['title']!,
                          style: TextStyle(
                            fontSize: isVerySmallScreen ? 18 : isSmallScreen ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGreen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isVerySmallScreen ? 6 : isSmallScreen ? 8 : 12),
                        Text(
                          p['desc']!,
                          style: TextStyle(
                            fontSize: isVerySmallScreen ? 12 : isSmallScreen ? 14 : 16,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // الأزرار داخل الخلفية الخضراء
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: size.height * 0.35,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // زر Get Started - إطار ذهبي
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        bottom: isVerySmallScreen ? 15 : isSmallScreen ? 20 : 25,
                        left: 20,
                        right: 20,
                      ),
                      child: OutlinedButton(
                        onPressed: controller.done,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColors.accentGold,
                          side: BorderSide(color: AppColors.accentGold, width: 2),
                          padding: EdgeInsets.symmetric(
                            vertical: isVerySmallScreen ? 12 : isSmallScreen ? 14 : 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Get started",
                          style: TextStyle(
                            fontSize: isVerySmallScreen ? 16 : isSmallScreen ? 18 : 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    // صف الأزرار (Skip, Indicators, Next)
                    Container(
                      height: isVerySmallScreen ? 40 : isSmallScreen ? 45 : 50,
                      margin: EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // زر Skip
                          TextButton(
                            onPressed: controller.skip,
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isVerySmallScreen ? 12 : isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          // المؤشرات
                          Expanded(
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: controller.pageController,
                                count: pages.length,
                                effect: ExpandingDotsEffect(
                                  activeDotColor: AppColors.accentGold,
                                  dotColor: Colors.white.withOpacity(0.6),
                                  dotHeight: isVerySmallScreen ? 5 : isSmallScreen ? 6 : 8,
                                  dotWidth: isVerySmallScreen ? 5 : isSmallScreen ? 6 : 8,
                                  expansionFactor: 3,
                                  spacing: isVerySmallScreen ? 3 : isSmallScreen ? 4 : 6,
                                ),
                              ),
                            ),
                          ),

                          // زر Next (يظهر في الصفحات الأولى فقط)
                          Obx(() {
                            final idx = controller.currentPage.value;
                            return idx < 3
                                ? GetBuilder<OnboardingController>(
                                    builder: (controller) => InkWell(
                                      onTap: controller.next,
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        width: isVerySmallScreen ? 35 : isSmallScreen ? 40 : 50,
                                        height: isVerySmallScreen ? 35 : isSmallScreen ? 40 : 50,
                                        decoration: BoxDecoration(
                                          color: AppColors.accentGold,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: isVerySmallScreen ? 12 : isSmallScreen ? 14 : 16,
                                          color: AppColors.primaryGreen,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(width: isVerySmallScreen ? 35 : isSmallScreen ? 40 : 50);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}