import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../core/theme/app_colors.dart';

class AppBottomBar extends StatelessWidget {
  final int index; // 0: Chats, 1: Groups, 2: Profile, 3: More
  const AppBottomBar({super.key, required this.index});

  Widget _item({
    required int i,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final bool selected = index == i;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  if (selected)
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen,
                        borderRadius: BorderRadius.circular(7), // نفس الشكل بالصورة
                      ),
                    ),
                  Icon(
                    icon,
                    size: 22,
                    color: selected ? AppColors.accentGold : Colors.black54, // الذهبي عند التحديد
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: selected ? AppColors.primaryGreen : Colors.black54,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 64,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, -2))
        ]),
        child: Row(
          children: [
            _item(i: 0, icon: Icons.chat_bubble_outline, label: 'Chats', onTap: () {}),
            _item(i: 1, icon: Icons.groups_outlined, label: 'Groups', onTap: () {}),
            _item(
              i: 2, icon: Icons.person_outline, label: 'Profile',
              onTap: () { if (Get.currentRoute != Routes.profile) Get.offAllNamed(Routes.profile); },
            ),
            _item(
              i: 3, icon: Icons.more_horiz, label: 'More',
              onTap: () { if (Get.currentRoute != Routes.more) Get.offAllNamed(Routes.more); },
            ),
          ],
        ),
      ),
    );
  }
}
