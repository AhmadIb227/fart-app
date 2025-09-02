import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/chat_thread.dart';

class ChatCard extends StatelessWidget {
  final ChatThread data;
  final VoidCallback? onTap;

  const ChatCard({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(0.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 17.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            CircleAvatar(
              radius: 24.r,
              backgroundColor: AppColors.backgroundGray,
              backgroundImage: (data.avatarPath != null)
                  ? AssetImage(data.avatarPath!) as ImageProvider
                  : null,
              child: (data.avatarPath == null)
                  ? Text(
                      data.name.isNotEmpty ? data.name[0].toUpperCase() : '?',
                      style: const TextStyle(
                        color: AppColors.neutral900,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.w),

            // نصوص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name, style: AppTextStyles.chatTitle),
                  SizedBox(height: 8.h),
                  Text(
                    data.lastMessage,
                    style: AppTextStyles.chatSubtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),

            // وقت + بادج الرسائل
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // تغيير لون الوقت للذهبي الداكن (#978461)
                Text(
                  _formatTime(data.lastTime),
                  style: AppTextStyles.chatTime.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accentGoldDark,
                  ),
                ),
                SizedBox(height: 8.h),
                if (data.unreadCount > 0)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreenLight,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${data.unreadCount}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
