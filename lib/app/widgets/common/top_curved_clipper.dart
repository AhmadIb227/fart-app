import 'package:flutter/material.dart';

class TopCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    // بداية من أعلى اليسار قليلاً للأسفل لعمل Curve
    path.lineTo(0, 60);
    path.quadraticBezierTo(size.width * 0.5, -30, size.width, 60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
