import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../routes/app_routes.dart';
import '../controllers/profile_setup_controller.dart';
import '../../../widgets/buttons/primary_button.dart';

class ProfileSetupView extends GetView<ProfileSetupController> {
  const ProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProfileSetupController());

    // طغيان الأخضر كما اتفقنا سابقًا (+120.h)
    final double headerExtra = 120.h;
    final double headerBase = 0.30.sh;
    final double headerH = headerBase + headerExtra;

    final double avatarSize = 140.w;
    final double w = 1.sw;

    // أقطار الدوائر (الفضي + الأبيض)
    final double silverD = w * 1.65;
    final double whiteD = w * 1.72;

    // === الجديد: عكس اتجاه الأقواس للأعلى ===
    // عندما نجعل bottom موجبًا، يدخل جزء من الدائرة "داخل" الهيدر
    // ويظهر قاع الدائرة فقط، فيبدو القوس للأعلى.
    final double silverBottom =
        silverD * 0.22; // اضبط النسب لو أردت قوس أعمق/أخف
    final double whiteBottom = whiteD * 0.30;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // =================== الهيدر ===================
            SizedBox(
              height: headerH + avatarSize * 0.60,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // خلفية خضراء متدرّجة
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: AppColors.greenGradient,
                      ),
                    ),
                  ),

                  // الدائرة البيضاء داخل الهيدر (قوس للأعلى)
                  Positioned(
                    left: (w - whiteD) / 2,
                    right: (w - whiteD) / 2,
                    bottom: whiteBottom,
                    child: Container(
                      width: whiteD,
                      height: whiteD,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // الدائرة الفضية داخل الهيدر فوق البيضاء (قوس للأعلى)
                  Positioned(
                    left: (w - silverD) / 2,
                    right: (w - silverD) / 2,
                    bottom: silverBottom,
                    child: Container(
                      width: silverD,
                      height: silverD,
                      decoration: const BoxDecoration(
                        color: AppColors.silver,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // شريط علوي: Login يسار + Register يمين
                  Positioned(
                    top: 20.h,
                    left: 16.w,
                    right: 16.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimaryButton.capsule(
                          height: 53.h,
                          paddingH: 22.w,
                          gap: 14.w,
                          gradient: AppColors.goldGradient,
                          radius: 28.r,
                          leading: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 22,
                          ),
                          label: 'Login',
                          textStyle: AppTextStyles.button,
                          onPressed: () => Get.offAllNamed(AppRoutes.login),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 6.h, right: 4.w),
                          child: Text('Register', style: AppTextStyles.h1),
                        ),
                      ],
                    ),
                  ),

                  // الأفاتار — ثبّتنا موضعه بتعويض headerExtra حتى لا يهبط
                  Positioned(
                    top: headerH - headerExtra - avatarSize * 0.70,
                    left: 0,
                    right: 0,
                    child: Obx(() {
                      final File? f = c.avatarFile.value;
                      return Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: avatarSize,
                              height: avatarSize,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(.5),
                                radius: avatarSize / 2,
                                backgroundImage: f != null
                                    ? FileImage(f)
                                    : null,
                                child: f == null
                                    ? Icon(
                                        Icons.account_circle,
                                        size: avatarSize * .78,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                            // زر القلم أعلى اليمين
                            Positioned(
                              right: 6.w,
                              top: -8.h,
                              child: GestureDetector(
                                onTap: c.pickImage,
                                child: Container(
                                  width: 42.w,
                                  height: 42.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: AppColors.greenGradient,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x33000000),
                                        blurRadius: 12,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // =================== النموذج ===================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: c.nameController,
                    onChanged: c.onNameChanged,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Color(0xFF2C2D3A),
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14.h,
                        horizontal: 4.w,
                      ),
                      hintText: 'Your Name',
                      hintStyle: TextStyle(
                        fontSize: 24,
                        color: const Color(0xFF2C2D3A).withOpacity(0.3),
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 4, right: 12),
                        child: Icon(
                          Icons.person,
                          size: 32,
                          color: Color(0xFF2C2D3A),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF2C2D3A),
                          width: 3,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF2C2D3A),
                          width: 3,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Obx(() {
                    final enabled = c.canContinue.value;
                    return Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: enabled ? c.onContinue : null,
                        child: Opacity(
                          opacity: enabled ? 1.0 : 0.4,
                          child: Container(
                            width: 60.w,
                            height: 60.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.goldGradient,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0F000000),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
