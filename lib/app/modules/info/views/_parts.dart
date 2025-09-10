import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

/// هيكل عام لشاشات المعلومات مع هيدر مخصص
class InfoScaffold extends StatelessWidget {
  final String title;
  final Widget cardChild;          // محتوى الكرت الأبيض
  final List<Widget>? bottom;      // عناصر إضافية أسفل الكرت (اختياري)

  const InfoScaffold({
    super.key,
    required this.title,
    required this.cardChild,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _header(),
              const SizedBox(height: 12),
              // الكرت الأبيض
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: cardChild,
                ),
              ),
              if (bottom != null) ...[
                const SizedBox(height: 12),
                ...bottom!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// هيدر: سهم رجوع (ذهبي) يسار + عنوان في المنتصف
  Widget _header() {
    return SizedBox(
      height: 44,
      child: Stack(
        children: [
          // زر الرجوع على اليسار
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                if (Get.key.currentState?.canPop() ?? false) {
                  Get.back();
                } else {
                  Get.offAllNamed(Routes.more);
                }
              },
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Icon(
                  Icons.arrow_back_rounded, // سهم مع ذيل
                  size: 20,
                  color: AppColors.accentGold,      // ذهبي
                ),
              ),
            ),
          ),
          // العنوان في المنتصف
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,            // واضح وبارز
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
