import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/group_call_controller.dart';
import '../../../data/models/group_meta.dart';

class GroupCallView extends GetView<GroupCallController> {
  const GroupCallView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(GroupCallController());

    return Scaffold(
      backgroundColor: const Color(0xFF0E1215),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1E2328), Color(0xFF0E1215)],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              children: [
                // ===== شريط علوي =====
                Row(
                  children: [
                    _RoundIconBtn(
                      icon: Icons.arrow_back,
                      onTap: c.hangUp,
                      bg: Colors.white.withOpacity(0.08),
                    ),
                    const Spacer(),
                    Obx(
                      () => Text(
                        c.callingLabel.value, // "Calling ..."
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 40.w), // موازنة
                  ],
                ),

                SizedBox(height: 20.h),

                // ===== شبكة المشاركين (دوائر) =====
                const Expanded(child: _ParticipantsGrid()),

                // ===== المؤقّت =====
                Obx(
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
                              color: Colors.black.withOpacity(0.35),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              c.formatElapsed(), // mm:ss
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
                SizedBox(height: 14.h),

                // ===== أدوات التحكّم =====
                Obx(() {
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

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// شبكة صور دائرية 2×N (حتى 6 عناصر) كما في اللقطة
class _ParticipantsGrid extends GetView<GroupCallController> {
  const _ParticipantsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupMeta? g = controller.group.value;
    // جهّز قائمة الصور (أو placeholders) بعدد أعضاء المجموعة
    final want = (g?.membersCount ?? (g?.avatars.length ?? 0)).clamp(2, 6);
    final urls = <String>[
      ...?g?.avatars,
      ...List.filled((want - (g?.avatars.length ?? 0)).clamp(0, want), ''),
    ].take(want).toList();

    final horizontalPadding = 24.w;
    final spacing = 18.w;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: LayoutBuilder(
        builder: (context, cons) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: urls.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عمودان
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio: 1, // مربعات
            ),
            itemBuilder: (_, i) {
              return LayoutBuilder(
                builder: (ctx, cell) {
                  final size = cell.maxWidth; // نفس الارتفاع تقريبًا
                  return Center(
                    child: _Avatar(
                      size: size * 0.9, // هامش بسيط
                      url: urls[i],
                      fallback: String.fromCharCode(65 + (i % 26)),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

/// دائرة صورة مع حدّ أبيض
class _Avatar extends StatelessWidget {
  final double size;
  final String url;
  final String fallback;
  const _Avatar({
    super.key,
    required this.size,
    required this.url,
    required this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: (size / 2) - 3,
        backgroundImage: url.isNotEmpty ? NetworkImage(url) : null,
        backgroundColor: const Color(0xFF2D3136),
        child: url.isEmpty
            ? Text(
                fallback,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (size / 2.5),
                  fontWeight: FontWeight.w700,
                ),
              )
            : null,
      ),
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
