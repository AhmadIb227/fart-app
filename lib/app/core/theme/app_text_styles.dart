import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headings
  static TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  
  static TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  
  // Body text
  static TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );
  
  static TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.white.withOpacity(0.8),
  );
  
  static TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.white.withOpacity(0.7),
  );
  
  // Buttons
  static TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  
  // Custom text styles
  static TextStyle splashText = TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.italic,
    color: AppColors.white.withOpacity(0.9),
  );
  
  static TextStyle versionText = TextStyle(
    fontSize: 12,
    color: AppColors.white.withOpacity(0.6),
  );
}