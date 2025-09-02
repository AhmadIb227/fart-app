import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

class CircleActionButton extends StatelessWidget {
  const CircleActionButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.size,
    this.backgroundOpacity = 0.10,
    this.useGoldGradientIcon = false,
  });

  final VoidCallback onTap;
  final IconData icon;
  final double? size; // افتراضي 42
  final double backgroundOpacity; // افتراضي 10%
  final bool useGoldGradientIcon;

  @override
  Widget build(BuildContext context) {
    final double s = (size ?? 42.w);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22.r),
        child: Ink(
          width: s,
          height: s,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(backgroundOpacity),
            borderRadius: BorderRadius.circular(22.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F0D0A2C), // 6% تقريباً كما بالتصميم
                offset: Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Center(
            child: useGoldGradientIcon
                ? ShaderMask(
                    shaderCallback: (rect) =>
                        AppColors.goldGradient.createShader(rect),
                    child: Icon(icon, size: 26.w, color: Colors.white),
                  )
                : Icon(icon, size: 26.w, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
