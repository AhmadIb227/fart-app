import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GradientCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;
  final double borderWidth;
  final double borderRadius;

  const GradientCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 20,
    this.borderWidth = 2,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: CustomPaint(
        painter: _GradientBorderPainter(
          radius: borderRadius,
          strokeWidth: borderWidth,
        ),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: value ? null : Colors.transparent,
            gradient: value ? AppColors.goldGradient : null,
          ),
          child: value
              ? const Center(
                  child: Icon(Icons.check, size: 14, color: Colors.white),
                )
              : null,
        ),
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  final double radius;
  final double strokeWidth;

  _GradientBorderPainter({required this.radius, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = AppColors.goldGradient.createShader(Offset.zero & size);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
