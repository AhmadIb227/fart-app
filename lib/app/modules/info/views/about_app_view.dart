import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '_parts.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoScaffold(
      title: 'About App',   // عنوان واحد في المنتصف
      cardChild: Column(
        children: [
          const SizedBox(height: 4),
          // شعار أكبر وأقرب للأعلى
          Image.asset(
            'assets/images/logo.png',
            height: 200,           // ← أكبر
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 12),
          const Spacer(),          // يدفع الزر نحو الأسفل
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // TODO: ضع رابط متجرك/تطبيقاتك هنا
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Other Apps',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      bottom: const [
        // فوتر بسيط (اختياري)
        SizedBox(height: 6),
        Center(
          child: Column(
            children: [
              Text('www.exampleapp.com', style: TextStyle(color: AppColors.accentGold)),
              SizedBox(height: 4),
              Text('© 2024 Your Company. All rights reserved.',
                  style: TextStyle(color: AppColors.accentGold, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
