import 'package:flutter/widgets.dart';

class RightConcaveCornerClipper extends CustomClipper<Path> {
  const RightConcaveCornerClipper();

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(w, 0)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..cubicTo(
        w * 0.10,
        h * 0.75, // control point 1
        w * 0.45,
        h * 0.35, // control point 2
        w,
        0, // end (top-right)
      )
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
