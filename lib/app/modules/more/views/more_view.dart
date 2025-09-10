import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/more_controller.dart';
import '../../../widgets/common/app_bottom_bar.dart';
import '../../../routes/app_routes.dart';

class MoreView extends GetView<MoreController> {
  const MoreView({super.key});

  Widget _leading(IconData data) =>
      Icon(data, size: 22, color: AppColors.accentGold);

  Widget _switchTile(String title, IconData icon, RxBool rx) {
    return Obx(() {
      return SwitchListTile(
        value: rx.value,
        onChanged: (v) => rx.value = v,
        title: Text(title),
        secondary: _leading(icon),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        activeColor: Colors.white,
        activeTrackColor: AppColors.primaryGreen,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.black12,
      );
    });
  }

  Widget _sectionCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(children: children),
    );
  }

  ListTile _lang() => ListTile(
        leading: _leading(Icons.translate),
        title: const Text('Language'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('English'),
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down_rounded,
                  size: 18, color: Colors.grey.shade600),
            ],
          ),
        ),
        onTap: () {},
      );

  ListTile _nav(String title, IconData icon, VoidCallback onTap) => ListTile(
        leading: _leading(icon),
        title: Text(title),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    const double logoSize = 32;

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Image.asset('assets/images/logo.png',
                  height: logoSize, fit: BoxFit.contain),
              const Spacer(),
              const Icon(Icons.search, color: Colors.white),
              const SizedBox(width: 14),
              const Icon(Icons.add, color: Colors.white),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomBar(index: 3),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionCard([
            _lang(),
            _switchTile('Dark Mode', Icons.dark_mode_outlined, controller.darkMode),
            _switchTile('Mute Notification', Icons.notifications_off_outlined, controller.muteNotifications),
            _nav('Custom Notification', Icons.tune, () {}),
          ]),
          const SizedBox(height: 16),
          _sectionCard([
            _nav('Invite Friends', Icons.person_add_alt_1_outlined, () {}),
            _nav('Joined Groups', Icons.groups_outlined, () {}),
            _switchTile('Hide Chat History', Icons.visibility_off_outlined, controller.hideChatHistory),
            _switchTile('Security', Icons.shield_outlined, controller.security),

            // ← تفعيل Term of Service
            _nav('Term of Service', Icons.article_outlined, () {
              Get.toNamed(Routes.terms);
            }),

            // ← زر Privacy Policy الجديد
            _nav('Privacy Policy', Icons.privacy_tip_outlined, () {
              Get.toNamed(Routes.privacy);
            }),

            // ← تفعيل About App
            _nav('About App', Icons.info_outline, () {
              Get.toNamed(Routes.aboutApp);
            }),

            _nav('Help Center', Icons.help_outline, () {}),
          ]),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: ListTile(
              leading: Icon(Icons.logout_outlined,
                  size: 22, color: AppColors.errorRed),
              title: Text('Logout',
                  style: TextStyle(
                      color: AppColors.errorRed, fontWeight: FontWeight.w600)),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
