// lib/app/widgets/buttons/more_button_md.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class MoreButtonMd extends StatelessWidget {
  final VoidCallback? onTap;
  final bool darkMode;
  const MoreButtonMd({super.key, this.onTap, this.darkMode = false});

  @override
  Widget build(BuildContext context) {
    // نفس أبعاد BackButtonMd: 42x42، radius 22، خلفية بيضاء 10%، وظل 6%
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F0D0A2C), // 6% من #0D0A2C تقريباً
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: ShaderMask(
              shaderCallback: (rect) =>
                  AppColors.goldGradient.createShader(rect),
              child: const Icon(
                Icons.more_horiz,
                size: 26,
                color: Colors.white, // سيُستبدل بالـ ShaderMask
              ),
            ),
          ),
        ),
      ),
    );
  }
}
