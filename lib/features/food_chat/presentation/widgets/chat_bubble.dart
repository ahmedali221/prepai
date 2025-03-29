import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:prepai/core/theme/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isUser ? AppColors.secondaryColor : AppColors.foodNameColor,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.grey[300],
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              DateFormat('hh:mm a').format(timestamp),
              style: TextStyle(
                color: isUser ? Colors.white70 : Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
