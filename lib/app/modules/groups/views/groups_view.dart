import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/values/assets.dart';
import '../../../widgets/chat/app_bottom_nav.dart';
import '../../../widgets/chat/group_card.dart';
import '../controllers/groups_controller.dart';

class GroupsView extends GetView<GroupsController> {
  const GroupsView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(GroupsController());

    // أبعاد من التصميم
    final double headerH = 110.h;
    final double headerRadius = 50.r;
    final double logoW = 59.w;
    final double logoH = 58.h;

    // إنزال الأيقونات للأسفل
    final double iconsTop = 30.h;
    final double actionBtnSize = 36.w;

    return GestureDetector(
      onTap: () {
        c.closeMenu();
        if (c.isSearching.value) FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        // ================== NAV BAR أسفل ==================
        bottomNavigationBar: Obx(
          () => AppBottomNav(
            items: defaultNavItems,
            currentIndex: c.navIndex.value, // 1 = Groups
            onTap: c.onNavTap,
          ),
        ),

        // ================== BODY مع طبقة Overlay للقائمة ==================
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            // الطبقة الأساسية (الهيدر + القائمة)
            Column(
              children: [
                // ================== الهيدر ==================
                SizedBox(
                  height: headerH,
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // خلفية الهيدر
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

                      // تعبئة الزاوية المقعّرة بأسفل يمين الهيدر (ClipPath)
                      Positioned(
                        right: 0,
                        bottom: -0.5.h,
                        child: SizedBox(
                          width: 37.w,
                          height: 45.h,
                          child: ClipPath(
                            clipper: _RightConcaveCornerClipper(),
                            child: Container(
                              color: const Color.fromARGB(255, 11, 80, 78),
                            ),
                          ),
                        ),
                      ),

                      // ===== الحالة العادية (الشعار + البحث + الزائد) =====
                      Obx(() {
                        if (c.isSearching.value) return const SizedBox.shrink();
                        return Stack(
                          children: [
                            // الشعار يسار
                            Positioned(
                              top: iconsTop,
                              left: 16.w,
                              child: SizedBox(
                                width: logoW,
                                height: logoH,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.asset(
                                    AppAssets.logo,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),

                            // أيقونات يمين: بحث + زائد
                            Positioned(
                              top: iconsTop,
                              right: 16.w,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // بحث
                                  InkWell(
                                    borderRadius: BorderRadius.circular(20.r),
                                    onTap: c.onSearchTap,
                                    child: Padding(
                                      padding: EdgeInsets.all(6.w),
                                      child: Icon(
                                        Icons.search,
                                        size: 24.w,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),

                                  // زائد
                                  InkWell(
                                    onTap: c.toggleMenu,
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: SizedBox(
                                      width: actionBtnSize,
                                      height: actionBtnSize,
                                      child: Center(
                                        child: Obx(
                                          () => AnimatedSwitcher(
                                            duration: const Duration(
                                              milliseconds: 200,
                                            ),
                                            transitionBuilder: (child, anim) =>
                                                RotationTransition(
                                                  turns: anim,
                                                  child: ScaleTransition(
                                                    scale: anim,
                                                    child: child,
                                                  ),
                                                ),
                                            child: Icon(
                                              c.isMenuOpen.value
                                                  ? Icons.close
                                                  : Icons.add,
                                              key: ValueKey(c.isMenuOpen.value),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),

                      // ===== وضع البحث: يظهر شريط البحث فقط داخل الهيدر =====
                      Obx(() {
                        if (!c.isSearching.value) {
                          return const SizedBox.shrink();
                        }
                        return Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                bottom: 12.h,
                              ),
                              child: Container(
                                height: 43.h,
                                padding: EdgeInsets.only(
                                  left: 24.w,
                                  right: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: AppColors.neutral900,
                                      size: 20.w,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: TextField(
                                        controller: c.searchCtrl,
                                        autofocus: true,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.neutral900,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          hintText: 'Search groups',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: c.cancelSearch,
                                      child: Icon(
                                        Icons.close,
                                        size: 20.w,
                                        color: AppColors.neutral900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // ================== القائمة ==================
                Expanded(
                  child: Obx(() {
                    if (c.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final list = c.filtered;
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      itemCount: list.length,
                      itemBuilder: (_, i) {
                        final g = list[i];
                        return GroupCard(data: g, onTap: () => c.openGroup(g));
                      },
                    );
                  }),
                ),
              ],
            ),

            // ================== OVERLAY: القائمة المنسدلة فوق كل شيء ==================
            Obx(() {
              if (!c.isMenuOpen.value || c.isSearching.value) {
                return const SizedBox.shrink();
              }
              return Positioned(
                right: 16.w,
                top: iconsTop + actionBtnSize + 10.h,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 200.w,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _MenuItem(
                          icon: Icons.group_outlined,
                          label: 'Create group',
                          onTap: c.onCreateGroup,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// عنصر القائمة
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        height: 56.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Icon(icon, size: 24.w, color: AppColors.neutral900),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutral900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// قصّ الزاوية المنحنية
class _RightConcaveCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();
    path.moveTo(w, 0);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.cubicTo(w * 0.10, h * 0.75, w * 0.35, h * 0.40, w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
