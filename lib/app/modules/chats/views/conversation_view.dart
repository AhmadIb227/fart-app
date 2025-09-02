import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/values/strings.dart';
import '../../../widgets/buttons/back_button_md.dart';
import '../../../data/models/contact_user.dart';
import '../controllers/conversation_controller.dart';

class ConversationView extends GetView<ConversationController> {
  const ConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // ===== العمود الأساسي =====
            Column(
              children: [
                // ===== شريط علوي =====
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back (نغلق لوحة الإضافات أيضًا عند الرجوع)
                      BackButtonMd(
                        onTap: () {
                          controller.closeAttachPanel();
                          Get.back();
                        },
                      ),

                      // عنوان
                      Text(
                        AppStrings.messageTitle,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0D1217),
                        ),
                      ),

                      // More (ظل خفيف)
                      _CircleIcon(
                        size: 42.w,
                        radius: 22.r,
                        bg: Colors.white.withOpacity(0.10),
                        hasShadow: true,
                        onTap: () {},
                        child: ShaderMask(
                          shaderCallback: (rect) =>
                              AppColors.goldGradient.createShader(rect),
                          child: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // ===== معلومات المستخدم + فيديو/اتصال =====
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Obx(() {
                    final ContactUser? cu = controller.user.value;
                    final name = cu?.name ?? 'User';
                    final phone = cu?.phone ?? '';
                    final avatarUrl = cu?.avatarUrl;

                    return Row(
                      children: [
                        // Avatar 42px
                        CircleAvatar(
                          radius: 21.r,
                          backgroundColor: const Color(0xFFEAEAEA),
                          backgroundImage:
                              (avatarUrl != null && avatarUrl.isNotEmpty)
                              ? NetworkImage(avatarUrl)
                              : null,
                          child: (avatarUrl == null || avatarUrl.isEmpty)
                              ? Text(
                                  name.isNotEmpty ? name[0].toUpperCase() : 'U',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                    color: const Color(0xFF2C2D3A),
                                  ),
                                )
                              : null,
                        ),

                        SizedBox(width: 16.w),

                        // الاسم + الرقم
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600, // SemiBold
                                  color: const Color(0xFF0D1217),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                phone,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF686A8A),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 16.w),

                        // Video (بدون ظل)
                        _CircleIcon(
                          size: 42.w,
                          radius: 22.r,
                          bg: Colors.white.withOpacity(0.10),
                          hasShadow: false,
                          onTap: () {},
                          child: ShaderMask(
                            shaderCallback: (rect) =>
                                AppColors.goldGradient.createShader(rect),
                            child: const Icon(
                              Icons.videocam_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(width: 10.w),

                        // Phone (بدون ظل)
                        _CircleIcon(
                          size: 42.w,
                          radius: 22.r,
                          bg: Colors.white.withOpacity(0.10),
                          hasShadow: false,
                          onTap: () {},
                          child: ShaderMask(
                            shaderCallback: (rect) =>
                                AppColors.goldGradient.createShader(rect),
                            child: const Icon(
                              Icons.phone_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),

                SizedBox(height: 16.h),

                // ===== حاوية الرسائل =====
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F0F3),
                      border: Border(
                        top: BorderSide(color: Color(0xFFE9EAEB), width: 1),
                        bottom: BorderSide(color: Color(0xFFE9EAEB), width: 1),
                      ),
                    ),
                    child: Obx(
                      () => ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        itemCount: controller.messages.length,
                        itemBuilder: (_, i) {
                          final m = controller.messages[i];
                          final isMe = m['isMe'] as bool? ?? false;
                          final text = m['text'] as String? ?? '';
                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 305.w),
                              margin: EdgeInsets.only(bottom: 8.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? const Color(0xFF08512A) // مرسل
                                    : Colors.white, // مستقبل
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                  bottomLeft: Radius.circular(
                                    isMe ? 16.r : 0.r,
                                  ),
                                  bottomRight: Radius.circular(
                                    isMe ? 0.r : 16.r,
                                  ),
                                ),
                              ),
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: isMe
                                      ? Colors.white
                                      : const Color(0xFF2C2D3A),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // ===== شريط الإدخال =====
                const _ChatInput(),
              ],
            ),

            // ===== لوحة الإضافات (Popup) =====
            Obx(() {
              final open = controller.isAttachOpen.value;
              return IgnorePointer(
                ignoring: !open,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: open ? 1 : 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      // تبتعد عن الأسفل حتى لا تغطي شريط الإدخال
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        bottom: 84.h,
                      ),
                      child: _AttachmentsPopup(
                        onCamera: controller.onPickCamera,
                        onRecord: controller.onRecordAudio,
                        onContact: controller.onPickContact,
                        onGallery: controller.onPickGallery,
                        onLocation: controller.onShareLocation,
                        onDocument: controller.onPickDocument,
                      ),
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

/// زر دائري شفاف قابل لإضافة/إلغاء الظل
class _CircleIcon extends StatelessWidget {
  final double size;
  final double radius;
  final Color bg;
  final bool hasShadow;
  final VoidCallback? onTap;
  final Widget child;

  const _CircleIcon({
    required this.size,
    required this.radius,
    required this.bg,
    required this.child,
    this.hasShadow = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Ink(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: hasShadow
                ? const [
                    BoxShadow(
                      color: Color(0x1A0D0A2C), // 10%
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ]
                : const [],
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/// شريط الإدخال (زر + ، حقل بإطار ذهبي 1px ، زر إرسال بتدرّج)
class _ChatInput extends GetView<ConversationController> {
  const _ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 16.h),
      child: Row(
        children: [
          // زر +
          _CircleIcon(
            size: 42.w,
            radius: 22.r,
            bg: Colors.white.withOpacity(0.10),
            hasShadow: false,
            onTap: controller.toggleAttachPanel,
            child: const Icon(Icons.add, color: Color(0xFF2C2D3A)),
          ),
          SizedBox(width: 12.w),

          // حقل الإدخال
          Expanded(
            child: Container(
              constraints: BoxConstraints(minHeight: 56.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(width: 1, color: const Color(0xFFD9D9D9)),
              ),
              child: TextField(
                controller: controller.msgCtrl,
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Message',
                  border: InputBorder.none,
                ),
                onTap: controller.closeAttachPanel,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // زر الإرسال
          SizedBox(
            width: 42.w,
            height: 42.w,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(22.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(22.r),
                onTap: controller.sendMessage,
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: AppColors.greenGradient,
                    borderRadius: BorderRadius.circular(22.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0F0D0A2C), // 6%
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: ShaderMask(
                      shaderCallback: (rect) =>
                          AppColors.goldGradient.createShader(rect),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// لوحة الإضافات (336w، padding 24، radius 12، shadow 10%)
class _AttachmentsPopup extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onRecord;
  final VoidCallback onContact;
  final VoidCallback onGallery;
  final VoidCallback onLocation;
  final VoidCallback onDocument;

  const _AttachmentsPopup({
    super.key,
    required this.onCamera,
    required this.onRecord,
    required this.onContact,
    required this.onGallery,
    required this.onLocation,
    required this.onDocument,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336.w,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A0D0A2C), // 10%
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Wrap(
        spacing: 24.w,
        runSpacing: 24.h,
        children: [
          _AttachItem(
            icon: Icons.photo_camera_outlined,
            label: 'Camera',
            onTap: onCamera,
          ),
          _AttachItem(
            icon: Icons.mic_none_outlined,
            label: 'Record',
            onTap: onRecord,
          ),
          _AttachItem(
            icon: Icons.person_outline,
            label: 'Contact',
            onTap: onContact,
          ),
          _AttachItem(
            icon: Icons.image_outlined,
            label: 'Gallery',
            onTap: onGallery,
          ),
          _AttachItem(
            icon: Icons.location_on_outlined,
            label: 'My Location',
            onTap: onLocation,
          ),
          _AttachItem(
            icon: Icons.insert_drive_file_outlined,
            label: 'Document',
            onTap: onDocument,
          ),
        ],
      ),
    );
  }
}

/// عنصر: دائرة 42 بتدرّج أخضر + أيقونة ذهبية + نص 12/Medium
class _AttachItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AttachItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                gradient: AppColors.greenGradient, // #032524 -> #0B615F
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Center(
                child: ShaderMask(
                  shaderCallback: (rect) =>
                      AppColors.goldGradient.createShader(rect),
                  child: Icon(icon, size: 22.w, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF0D1217),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
