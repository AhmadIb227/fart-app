import 'package:flutter/material.dart';

class AppColors {
  // ألوان ثابتة
  static const Color primaryGreen = Color(0xFF0C2E26);
  static const Color primaryGreenLight = Color(0xFF0A5F5A);

  static const Color accentGold = Color(0xFFC79D61);
  static const Color accentGoldDark = Color(0xFF978461);

  static const Color backgroundGray = Color(0xFFD9D9D9);
  // فضي داكن قليلًا (للقوس الوسطي)
  static const Color silver = Color(0xFFE6E6E6);

  // تدرجات
  static const LinearGradient greenGradient = LinearGradient(
    colors: [primaryGreen, primaryGreenLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [accentGoldDark, accentGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
