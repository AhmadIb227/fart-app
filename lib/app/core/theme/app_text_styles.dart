import 'package:flutter/material.dart';

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

  static TextTheme get textTheme =>
      const TextTheme(headlineLarge: h1, bodyMedium: body);
}
