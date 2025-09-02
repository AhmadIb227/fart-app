import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messaging_app/app/widgets/shap/right_concave_corner_clipper.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/values/strings.dart';
import '../../../data/models/contact_user.dart';
import '../../../widgets/buttons/back_button_md.dart';
import '../controllers/create_group_controller.dart';

class CreateGroupView extends GetView<CreateGroupController> {
  const CreateGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;

    const double headerH = 110.0;
    const double headerRadius = 50.0;

    return Scaffold(
      backgroundColor: Colors.white,

      // زر Create Group ثابت في الأسفل
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: c.submit,
                borderRadius: BorderRadius.circular(30),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: AppColors.greenGradient,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      AppStrings.createGroup,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== الهيدر =====
            SizedBox(
              height: headerH,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.greenGradient,
                      borderRadius: const BorderRadius.only(
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
                  Positioned(
                    right: 0,
                    bottom: -1,
                    child: SizedBox(
                      width: 37,
                      height: 45,
                      child: ClipPath(
                        clipper: RightConcaveCornerClipper(),
                        child: Container(
                          color: const Color.fromARGB(255, 11, 80, 78),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(left: 16, top: 30, child: BackButtonMd()),
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment(0, -0.05),
                      child: Text(
                        AppStrings.createGroup,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ===== المحتوى القابل للسكرول =====
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Label(text: AppStrings.nameGroup),

                    _InputCard(
                      child: TextField(
                        controller: c.nameCtrl,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF2C2D3A),
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: AppStrings.enterGroupName,
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: const Color(0xFF2C2D3A).withOpacity(.30),
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    const _Label(text: AppStrings.members),

                    // زر إضافة أعضاء – الأيقونة يسار والنص بالوسط بتدرج ذهبي
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: c.openAddMembersSheet,
                      child: Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: const [
                            _GradientPlusIcon(size: 18),
                            SizedBox(width: 8),
                            Expanded(
                              child: Center(
                                child: _GradientText(
                                  AppStrings.addMembersToGroup,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ===== قائمة الأعضاء المختارين بمظهر فيجما =====
                    Obx(() {
                      if (c.selectedMembers.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: _SelectedMembersList(
                          items: c.selectedMembers,
                          onRemove: (m) => c.selectedMembers.remove(m),
                        ),
                      );
                    }),
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

/// Label رمادي صغير فوق الحقول
class _Label extends StatelessWidget {
  final String text;
  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF686A8A), // neutral-500
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

/// كارد الإدخال
class _InputCard extends StatelessWidget {
  final Widget child;
  const _InputCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD0D1DB), width: 1),
      ),
      child: child,
    );
  }
}

/// قائمة الأعضاء المختارين (مطابقة لبطاقة فيجما)
class _SelectedMembersList extends StatelessWidget {
  final List<ContactUser> items;
  final ValueChanged<ContactUser> onRemove;
  const _SelectedMembersList({required this.items, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, i) => _SelectedMemberTile(
        data: items[i],
        onRemove: () => onRemove(items[i]),
      ),
    );
  }
}

class _SelectedMemberTile extends StatelessWidget {
  final ContactUser data;
  final VoidCallback onRemove;
  const _SelectedMemberTile({required this.data, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar 42x42
        CircleAvatar(
          radius: 21,
          backgroundImage: data.avatarUrl != null
              ? NetworkImage(data.avatarUrl!)
              : null,
          child: data.avatarUrl == null
              ? Text(
                  data.name.isNotEmpty ? data.name[0] : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : null,
        ),
        const SizedBox(width: 16),

        // الاسم + الرقم
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C2D3A), // neutral-900
                ),
              ),
              const SizedBox(height: 8),
              Text(
                data.phone,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF686A8A), // neutral-500
                ),
              ),
            ],
          ),
        ),

        // زر الإزالة (36x36) بخلفية بيضاء 20% و X حمراء
        InkWell(
          onTap: onRemove,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.20),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.close,
              size: 20,
              color: Color(0xFFF44336), // red-500
            ),
          ),
        ),
      ],
    );
  }
}

/// نص بتدرّج ذهبي
class _GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const _GradientText(this.text, {required this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => AppColors.goldGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style.copyWith(color: Colors.white)),
    );
  }
}

/// أيقونة + بحدّ ذهبي (12–18px)
class _GradientPlusIcon extends StatelessWidget {
  final double size;
  const _GradientPlusIcon({this.size = 18});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.square(size), painter: _PlusPainter());
  }
}

class _PlusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..shader = AppColors.goldGradient.createShader(rect);

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
