import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/common/app_bottom_bar.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  // أيقونة ذهبية موحّدة الشكل والحجم
  Widget _leading(IconData data) =>
      Icon(data, size: 22, color: AppColors.accentGold);

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

  // عنصر لغة مع حبة "English" يمين
  ListTile _lang() => ListTile(
        leading: _leading(Icons.language_outlined),
        title: const Text('Language'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Text('English'),
        ),
      );

  // عنصر Toggle مع أيقونة ذهبية
  Widget _switch(String title, IconData icon,
          {bool value = false, ValueChanged<bool>? onChanged}) =>
      SwitchListTile(
        value: value,
        onChanged: onChanged ?? (_) {},
        title: Text(title),
        secondary: _leading(icon),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        activeColor: AppColors.primaryGreen,
        activeTrackColor: AppColors.primaryGreen.withOpacity(0.35),
      );

  // عنصر تنقل بسيط مع سهم يمين
  ListTile _nav(String title, IconData icon) => ListTile(
        leading: _leading(icon),
        title: Text(title),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
        onTap: () {},
      );

  @override
  Widget build(BuildContext context) {
    const double logoSize = 32; // حجم النسر في الهيدر

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
          // القسم الأول
          _sectionCard([
            _lang(),
            _switch('Dark Mode', Icons.dark_mode_outlined),
            _switch('Mute Notification', Icons.notifications_off_outlined),
            _nav('Custom Notification', Icons.tune),
          ]),
          const SizedBox(height: 16),

          // القسم الثاني
          _sectionCard([
            _nav('Invite Friends', Icons.person_add_alt_1_outlined),
            _nav('Joined Groups', Icons.groups_outlined),
            _switch('Hide Chat History', Icons.visibility_off_outlined),
            _nav('Security', Icons.shield_outlined),
            _nav('Term of Service', Icons.article_outlined),
            _nav('About App', Icons.info_outline),
            _nav('Help Center', Icons.help_outline),
          ]),
          const SizedBox(height: 16),

          // الخروج مع أيقونة ذهبية والنص أحمر كما اتفقنا
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
              leading: Icon(Icons.logout_outlined, size: 22, color: AppColors.errorRed), // ← أحمر
              title: Text('Logout',
                  style: TextStyle(color: AppColors.errorRed, fontWeight: FontWeight.w600)),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
