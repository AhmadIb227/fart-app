import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messaging_app/app/core/theme/app_colors.dart';

import '../../modules/groups/controllers/groups_controller.dart';

class GroupCard extends StatelessWidget {
  final GroupItem data;
  final VoidCallback onTap;

  const GroupCard({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // صور أعضاء المجموعة (دوائر متداخلة بسيطة)
            SizedBox(
              width: 56.w,
              height: 40.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: List.generate(
                  3,
                  (i) => Positioned(
                    left: (i * 16).toDouble(),
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundColor: Colors.grey.shade300,
                      child: Text(
                        data.title.isNotEmpty
                            ? data.title.trim()[0].toUpperCase()
                            : '?',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),

            // العنوان والنص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان + شارة (badge) إن وجدت
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.neutral900,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        data.timeLabel,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.neutral300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.neutral300,
                          ),
                        ),
                      ),
                      if (data.badge > 0) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '+${data.badge}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.green.shade800,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
