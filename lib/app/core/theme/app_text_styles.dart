import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle h1 = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    color: Colors.white,
  );

  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle body = TextStyle(fontSize: 14, color: Colors.black87);

  // إضافات للمحادثات
  static const TextStyle chatTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.neutral900,
  );

  static const TextStyle chatSubtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.neutral300,
  );

  static const TextStyle chatTime = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.neutral300,
  );

  static TextTheme get textTheme =>
      const TextTheme(headlineLarge: h1, bodyMedium: body);
}
