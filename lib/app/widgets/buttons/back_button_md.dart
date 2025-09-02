import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackButtonMd extends StatelessWidget {
  final VoidCallback? onTap;
  final bool darkMode; // true = على هيدر داكن

  const BackButtonMd({super.key, this.onTap, this.darkMode = true});

  @override
  Widget build(BuildContext context) {
    final bg = darkMode
        ? Colors.white.withOpacity(0.10)
        : Colors.black.withOpacity(0.06);
    final iconColor = darkMode ? Colors.white : const Color(0xFF2C2D3A);

    return InkWell(
      borderRadius: BorderRadius.circular(22.r),
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      child: Container(
        width: 42.w,
        height: 42.w,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F0D0A2C),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(Icons.arrow_back_ios_new, size: 18.w, color: iconColor),
      ),
    );
  }
}
