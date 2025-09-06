import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/common/app_bottom_bar.dart';
import '../views/edit_profile_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  void _openEdit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const EditProfileSheet(),
    );
  }

  Widget _kv(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(width: 90, child: Text(k, style: const TextStyle(color: Colors.black54))),
            Expanded(child: Text(v, style: const TextStyle(fontWeight: FontWeight.w500))),
            const SizedBox(width: 6),
            const Icon(Icons.copy_outlined, size: 18, color: Colors.black38),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    const double headerH = 110;   // ارتفاع الشريط الأخضر
    const double avatarR = 44;    // نصف قطر الصورة
    const double logoSize = 40;   // ← حجم النسر في الهيدر
    final double topPad = headerH + avatarR + 12; // لضمان ظهور الصورة تحت الهيدر

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      bottomNavigationBar: const AppBottomBar(index: 2),

      body: Stack(
        children: [
          // الخلفية + المحتوى
          Container(
            color: AppColors.backgroundGray,
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, topPad, 16, 16),
              children: [
                // الكارت الأبيض + الصورة الطافية فوقه
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 56, 16, 16), // فراغ للصورة
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 6),
                          const Text('John Lennon',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 14),
                          _kv('Phone', '(+44) 20 1234 5629'),
                          _kv('Gender', 'Male'),
                          _kv('Birthday', '12/01/1997'),
                          _kv('Email', 'john.lennon@mail.com'),
                          const SizedBox(height: 18),
                          // زر Logout
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.errorRed.withOpacity(0.45)),
                            ),
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.logout, color: AppColors.errorRed),
                              label: Text('Logout',
                                  style: TextStyle(
                                    color: AppColors.errorRed,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // الصورة + زر القلم
                    Positioned(
                      top: -avatarR,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              radius: avatarR,
                              backgroundImage: AssetImage('assets/images/avatar_sample.jpg'),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: InkWell(
                                onTap: () => _openEdit(context),
                                child: Container(
                                  width: 26, height: 26,
                                  decoration: BoxDecoration(color: AppColors.primaryGreen, shape: BoxShape.circle),
                                  child: const Icon(Icons.edit, color: Colors.white, size: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // الشريط الأخضر العلوي (شعار يسار + بحث + + يمين)
          Container(
            height: headerH,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.primaryGreen,
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: logoSize, // ← صار أكبر
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  const Icon(Icons.search, color: Colors.white),
                  const SizedBox(width: 14),
                  const Icon(Icons.add, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
