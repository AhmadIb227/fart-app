import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messaging_app/app/core/values/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/values/strings.dart';

class AppNavItem {
  final String label;

  // خيار 1: صور
  final String? asset; // صورة الحالة الخاملة
  final String? assetActive; // صورة الحالة النشطة (اختياري)
  final Color? inactiveTint; // تلوين اختياري للصورة الخاملة
  final Color? activeTint; // تلوين اختياري للصورة النشطة

  // خيار 2 (Fallback): IconData (لو ما وفّرت صور)
  final IconData? icon;

  const AppNavItem({
    required this.label,
    this.asset,
    this.assetActive,
    this.inactiveTint,
    this.activeTint,
    this.icon,
  });
}

typedef NavTap = void Function(int index);

class AppBottomNav extends StatelessWidget {
  final List<AppNavItem> items;
  final int currentIndex;
  final NavTap onTap;

  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 100.h,
        padding: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F0D0A2C), // ~6%
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(items.length, (i) {
            final item = items[i];
            final selected = i == currentIndex;
            return selected
                ? _ActiveItem(item: item, onTap: () => onTap(i))
                : _InactiveItem(item: item, onTap: () => onTap(i));
          }),
        ),
      ),
    );
  }
}

class _ActiveItem extends StatelessWidget {
  final AppNavItem item;
  final VoidCallback onTap;
  const _ActiveItem({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        width: 76.w,
        height: 70.h,
        decoration: BoxDecoration(
          gradient: AppColors.navItemGradient, // #032524 → #0B615F
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.translate(
                offset: Offset(0, -12.h),
                child: _buildIcon(selected: true, item: item),
              ),
              SizedBox(height: 6.h),
              // النص يظهر دائماً
              Text(
                item.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InactiveItem extends StatelessWidget {
  final AppNavItem item;
  final VoidCallback onTap;
  const _InactiveItem({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.r),
      onTap: onTap,
      child: SizedBox(
        width: 76.w,
        height: 70.h,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.translate(
                offset: Offset(0, -12.h),
                child: _buildIcon(selected: false, item: item),
              ),
              SizedBox(height: 6.h),
              Text(
                item.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutral900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// يبني أيقونة/صورة 24px وفق الحالة
Widget _buildIcon({required bool selected, required AppNavItem item}) {
  final double sz = 24.w;

  // إن توفّرت صور: نستخدمها
  final String? path = selected
      ? (item.assetActive ?? item.asset)
      : (item.asset ?? item.assetActive);

  if (path != null) {
    return Image.asset(
      path,
      width: sz,
      height: sz,
      fit: BoxFit.contain,
      // لو أردت تلوين نفس الصورة بدل صورتين مختلفتين
      // color: selected ? (item.activeTint ?? Colors.white) : item.inactiveTint,
      // ملاحظة: الـ color يعمل جيداً مع PNG/ SVG أحادية اللون أو شفافة.
    );
  }

  // وإلا fallback إلى IconData
  return Icon(
    item.icon ?? Icons.circle,
    size: sz,
    color: selected ? Colors.white : AppColors.neutral900,
  );
}

// نسخة افتراضية — يمكنك تعديل المسارات بما يناسبك
List<AppNavItem> defaultNavItems = const [
  AppNavItem(
    label: AppStrings.tabChats,
    // asset: AppAssets.chatIcon, // خاملة
    assetActive: AppAssets.chatIcon, // نشطة (بيضاء مثلاً)
    // أو استخدم نفس الصورة مع تلوين:
    // asset: 'assets/nav/chats.png',
    // activeTint: Colors.white,
  ),
  AppNavItem(
    label: AppStrings.tabGroups,
    asset: AppAssets.groupIcon,
    // assetActive: 'assets/nav/groups_active.png',
  ),
  AppNavItem(
    label: AppStrings.tabProfile,
    asset: AppAssets.profileIcon,
    // assetActive: AppAssets.profileIcon,
  ),
  AppNavItem(
    label: AppStrings.tabMore,
    asset: AppAssets.moreIcon,
    // assetActive: 'assets/nav/more_active.png',
  ),
];
