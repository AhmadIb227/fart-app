import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Gradient? gradient;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.gradient,
    this.height,
    this.radius,
    this.paddingH,
    this.gap,
    this.textStyle,
    this.leading,
  });

  /// كبسولة مع إعدادات مقاربة لما في الصورة
  const PrimaryButton.capsule({
    super.key,
    required this.label,
    required this.onPressed,
    this.gradient,
    this.height = 53,
    this.radius = 28,
    this.paddingH = 22,
    this.gap = 14,
    this.textStyle = AppTextStyles.button,
    this.leading,
  });

  final double? height;
  final double? radius;
  final double? paddingH;
  final double? gap;
  final TextStyle? textStyle;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      height: height ?? 48,
      padding: EdgeInsets.symmetric(horizontal: paddingH ?? 16),
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.goldGradient,
        borderRadius: BorderRadius.circular(radius ?? 14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[leading!, SizedBox(width: gap ?? 8)],
          Text(label, style: textStyle ?? AppTextStyles.button),
        ],
      ),
    );

    return InkWell(
      borderRadius: BorderRadius.circular(radius ?? 14),
      onTap: onPressed,
      child: child,
    );
  }
}
