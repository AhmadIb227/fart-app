import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messaging_app/app/modules/groups/controllers/group_info_controller.dart';

import '../../../core/theme/app_colors.dart';

class GroupInfoView extends GetView<GroupInfoController> {
  const GroupInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(GroupInfoController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===== Header =====
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 8.h),
              child: Row(
                children: [
                  _CircleBtn(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF2C2D3A),
                    ),
                  ),
                  const Spacer(),
                  ShaderMask(
                    shaderCallback: (r) =>
                        AppColors.goldGradient.createShader(r),
                    child: const Icon(
                      Icons.videocam_outlined,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  ShaderMask(
                    shaderCallback: (r) =>
                        AppColors.goldGradient.createShader(r),
                    child: const Icon(
                      Icons.phone_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Column(
                  children: [
                    // ===== Avatar + Name + Members =====
                    SizedBox(height: 8.h),
                    Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFDA59A3), Color(0xFF5493FF)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        boxShadow: const [
                          BoxShadow(color: Color(0x22000000), blurRadius: 12),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Obx(
                      () => Text(
                        c.group.value?.title ?? 'Group',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0D1217),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Obx(
                      () => Text(
                        '${c.group.value?.membersCount ?? 0} Members',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF686A8A),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ===== Members strip (placeholder) =====
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: List.generate(
                            3,
                            (i) => Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: CircleAvatar(
                                radius: 16.r,
                                backgroundColor: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),
                    const Divider(height: 1),

                    // ===== Section: Media / Notifications =====
                    _Tile(
                      icon: Icons.folder_copy_outlined,
                      title: 'Media, Links & Documents',
                      trailing: Obx(
                        () => Text(
                          '${c.mediaCount.value}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      onTap: c.openMedia,
                    ),
                    Obx(
                      () => _SwitchTile(
                        icon: Icons.notifications_off_outlined,
                        title: 'Mute Notification',
                        value: c.mute.value,
                        onChanged: c.toggleMute,
                      ),
                    ),
                    _Tile(
                      icon: Icons.notifications_active_outlined,
                      title: 'Custom Notification',
                      subtitle: Obx(
                        () => Text(
                          c.tone.value,
                          style: const TextStyle(color: Color(0xFF686A8A)),
                        ),
                      ),
                      onTap: c.pickTone,
                    ),

                    const Divider(height: 12),

                    // ===== Section: Privacy & Chat =====
                    Obx(
                      () => _SwitchTile(
                        icon: Icons.lock_outline,
                        title: 'Protected Chat',
                        value: c.protectedChat.value,
                        onChanged: c.setProtected,
                      ),
                    ),
                    Obx(
                      () => _SwitchTile(
                        icon: Icons.visibility_off_outlined,
                        title: 'Hide Chat',
                        value: c.hideChat.value,
                        onChanged: c.setHidden,
                      ),
                    ),
                    Obx(
                      () => _SwitchTile(
                        icon: Icons.history_toggle_off_outlined,
                        title: 'Hide Chat History',
                        value: c.hideChatHistory.value,
                        onChanged: c.setHideHistory,
                      ),
                    ),

                    const Divider(height: 12),

                    // ===== Section: Appearance =====
                    _Tile(
                      icon: Icons.palette_outlined,
                      title: 'Custom Color Chat',
                      trailing: Obx(() {
                        final col = c.color.value ?? Colors.transparent;
                        return Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: col == Colors.transparent
                                ? Colors.white
                                : col,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.black26),
                          ),
                        );
                      }),
                      onTap: c.pickColor,
                    ),
                    _Tile(
                      icon: Icons.image_outlined,
                      title: 'Custom Background Chat',
                      trailing: Obx(() {
                        final p = c.bgPath.value;
                        return p == null || p.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: FileImage(File(p)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                      }),
                      onTap: c.pickBackground,
                    ),

                    const Divider(height: 12),

                    // ===== Danger zone =====
                    _DangerTile(
                      icon: Icons.flag_outlined,
                      title: 'Report',
                      onTap: c.report,
                    ),
                    _DangerTile(
                      icon: Icons.logout_rounded,
                      title: 'Leave Group',
                      onTap: c.leaveGroup,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Widgets =====
class _CircleBtn extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const _CircleBtn({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 12,
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

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final Widget? subtitle;
  final VoidCallback? onTap;
  const _Tile({
    required this.icon,
    required this.title,
    this.trailing,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2C2D3A)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: subtitle,
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2C2D3A)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: Switch(value: value, onChanged: onChanged),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: () => onChanged(!value),
    );
  }
}

class _DangerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _DangerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFE53935)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFE53935),
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
