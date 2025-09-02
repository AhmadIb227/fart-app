import 'package:flutter/material.dart';

class AppColors {
  // ألوان أساسية
  static const Color primaryGreen = Color(0xFF0C2E26);
  static const Color primaryGreenLight = Color(0xFF0A5F5A);

  static const Color accentGold = Color(0xFFC79D61);
  static const Color accentGoldDark = Color(0xFF978461);

  static const Color backgroundGray = Color(0xFFD9D9D9);
  static const Color silver = Color(0xFFE6E6E6);

  // محايدين للنصوص
  static const Color neutral900 = Color(0xFF2C2D3A);
  static const Color neutral300 = Color(0xFF9A9BB1);

  // تدرجات عامة
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

  // تدرّج عنصر الناف بار (من فيجما: #032524 → #0B615F)
  static const LinearGradient navItemGradient = LinearGradient(
    colors: [Color(0xFF032524), Color(0xFF0B615F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
