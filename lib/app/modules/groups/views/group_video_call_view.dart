import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/group_call_controller.dart';
import '../../../data/models/group_meta.dart';

class GroupVideoCallView extends GetView<GroupCallController> {
  const GroupVideoCallView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(GroupCallController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // ===== شبكة فيديو 2×N (حتى 6) تملأ الشاشة =====
            const _VideoGrid(),

            // ===== شريط علوي =====
            Positioned(
              left: 12.w,
              right: 12.w,
              top: 8.h,
              child: Row(
                children: [
                  _RoundIconBtn(
                    icon: Icons.arrow_back,
                    onTap: c.hangUp,
                    bg: Colors.black.withOpacity(0.30),
                  ),
                  const Spacer(),
                  Obx(
                    () => Text(
                      c.callingLabel.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        shadows: const [
                          Shadow(color: Colors.black54, blurRadius: 4),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(width: 40.w),
                ],
              ),
            ),

            // ===== المؤقّت =====
            Positioned(
              bottom: 96.h,
              left: 0,
              right: 0,
              child: Center(
                child: Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: c.isInCall.value
                        ? Container(
                            key: const ValueKey('timer'),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.45),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              c.formatElapsed(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(key: ValueKey('no-timer')),
                  ),
                ),
              ),
            ),

            // ===== أدوات التحكّم =====
            Positioned(
              left: 0,
              right: 0,
              bottom: 24.h,
              child: Center(
                child: Obx(() {
                  if (c.isInCall.value) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _WhiteCircleBtn(
                          onTap: c.toggleMic,
                          child: ShaderMask(
                            shaderCallback: (r) =>
                                AppColors.goldGradient.createShader(r),
                            child: Icon(
                              c.micMuted.value
                                  ? Icons.mic_off_rounded
                                  : Icons.mic_none_rounded,
                              size: 22.w,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 18.w),
                        _WhiteCircleBtn(
                          onTap: c.toggleSpeaker,
                          child: ShaderMask(
                            shaderCallback: (r) =>
                                AppColors.goldGradient.createShader(r),
                            child: Icon(
                              c.speakerOn.value
                                  ? Icons.volume_up_rounded
                                  : Icons.volume_off_rounded,
                              size: 22.w,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 18.w),
                        _RoundAction(
                          bg: const Color(0xFFE53935),
                          icon: Icons.call_end,
                          onTap: c.hangUp,
                        ),
                      ],
                    );
                  }
                  // قبل الاستجابة
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _RoundAction(
                        bg: const Color(0xFFE53935),
                        icon: Icons.call_end,
                        onTap: c.hangUp,
                      ),
                      SizedBox(width: 32.w),
                      _RoundAction(
                        bg: const Color(0xFF2ECC71),
                        icon: Icons.call,
                        onTap: c.connect,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// شبكة فيديو 2×N (حتى 6 عناصر) – استبدل Image.network بمشغّل الفيديو لاحقًا (RTC)
class _VideoGrid extends GetView<GroupCallController> {
  const _VideoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupMeta? g = controller.group.value;
    final want = (g?.membersCount ?? (g?.avatars.length ?? 0)).clamp(2, 6);
    final urls = <String>[
      ...?g?.avatars,
      ...List.filled((want - (g?.avatars.length ?? 0)).clamp(0, want), ''),
    ].take(want).toList();

    // تباعد بسيط جدًا مثل السكريمشوت
    const spacing = 2.0;

    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: urls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // عمودان
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 9 / 16, // مستطيلات طويلة قليلاً (قابلة للتعديل)
      ),
      itemBuilder: (_, i) {
        final url = urls[i];
        return Container(
          color: const Color(0xFF111315),
          child: url.isNotEmpty
              ? Image.network(
                  url,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}

/// زر Back دائري صغير
class _RoundIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color bg;
  const _RoundIconBtn({
    required this.icon,
    required this.onTap,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    final s = 36.w;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(s / 2),
        child: Ink(
          width: s,
          height: s,
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 20.w),
        ),
      ),
    );
  }
}

/// زر أبيض دائري (ميك/سبيكر)
class _WhiteCircleBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const _WhiteCircleBtn({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = 44.w;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/// زر دائري كبير (اتصال/إنهاء)
class _RoundAction extends StatelessWidget {
  final Color bg;
  final IconData icon;
  final VoidCallback onTap;
  const _RoundAction({
    super.key,
    required this.bg,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = 56.w;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 28.w),
        ),
      ),
    );
  }
}
