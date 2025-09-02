import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messaging_app/app/widgets/shap/right_concave_corner_clipper.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/values/strings.dart';
import '../controllers/add_friend_controller.dart';

class AddFriendView extends GetView<AddFriendController> {
  const AddFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AddFriendController());

    final double headerH = 110.h;
    final double headerRadius = 50.r;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================== الهيدر ==================
            SizedBox(
              height: headerH,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: headerH,
                    decoration: BoxDecoration(
                      gradient: AppColors.greenGradient,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(headerRadius),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  // تعبئة الزاوية
                  Positioned(
                    right: 0,
                    bottom: -0.5.h,
                    child: SizedBox(
                      width: 37.w,
                      height: 45.h,
                      child: ClipPath(
                        clipper: const RightConcaveCornerClipper(),
                        child: Container(
                          color: const Color.fromARGB(255, 11, 80, 78),
                        ),
                      ),
                    ),
                  ),

                  // زر رجوع
                  Positioned(
                    left: 16.w,
                    top: 30.h,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(22.r),
                      onTap: Get.back,
                      child: Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(22.r),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0F0D0A2C),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // العنوان
                  Positioned.fill(
                    child: Align(
                      alignment: const Alignment(0, -0.05),
                      child: Text(
                        AppStrings.addFriend,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // ================== حقل الإدخال ==================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(() {
                return Container(
                  constraints: BoxConstraints(minHeight: 56.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: const Color(0xFFD0D1DB),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // اختيار الدولة
                      InkWell(
                        onTap: () => c.pickCountry(context),
                        borderRadius: BorderRadius.circular(6.r),
                        child: Container(
                          height: 24.h,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            children: [
                              Text(
                                c.flagEmoji.value,
                                style: TextStyle(fontSize: 18.sp),
                              ),
                              SizedBox(width: 6.w),
                              Icon(
                                Icons.expand_more,
                                size: 20.w,
                                color: AppColors.neutral900,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 12.w),
                      Container(
                        width: 1,
                        height: 24.h,
                        color: const Color(0xFFD0D1DB),
                      ),
                      SizedBox(width: 12.w),

                      // الهاتف
                      Expanded(
                        child: TextField(
                          controller: c.phoneCtrl,
                          keyboardType: TextInputType.phone,
                          onSubmitted: (_) => c.submit(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.neutral900,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Phone Number',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: const Color(0xFF2C2D3A).withOpacity(0.30),
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      SizedBox(width: 12.w),
                      Text(
                        '(${c.dialCode.value})',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF9A9BB1),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            // ================== الاقتراحات ==================
            Obx(() {
              final items = controller.suggestions;
              if (items.isEmpty) return SizedBox(height: 12.h);

              return Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: const Color(0xFFD0D1DB),
                      width: 1,
                    ),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => SizedBox(height: 4.h),
                    itemBuilder: (_, i) {
                      final cu = items[i];
                      return _SuggestionTile(
                        name: cu.name,
                        phone: cu.phone,
                        onTap: () => controller.fillFromSuggestion(cu),
                      );
                    },
                  ),
                ),
              );
            }),

            // زر إرسال
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: controller.submit,
                  child: const Text(
                    'Add Friend',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionTile extends StatelessWidget {
  final String name;
  final String phone;
  final VoidCallback onTap;

  const _SuggestionTile({
    required this.name,
    required this.phone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6.r),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
        child: Row(
          children: [
            // أيقونة placeholder (يمكنك استبدالها بصورة)
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F3),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 16,
                color: Color(0xFF2C2D3A),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.neutral900,
                  fontWeight: FontWeight.w600, // SemiBold ~ 600
                ),
              ),
            ),
            Text(
              phone,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF9A9BB1), // neutral-300
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
