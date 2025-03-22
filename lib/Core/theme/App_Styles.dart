import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepai/core/theme/app_colors.dart';

class AppStyles {
  // Small text styles
  static final TextStyle smallTextStyle = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
  );

  static final TextStyle bodyTextStyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle lightTextStyle = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w200,
  );

  static final TextStyle boldTextStyle = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
  );

  // Medium text styles
  static final TextStyle mediumTextStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle regularTextStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryColor,
  );

  // Large text styles
  static final TextStyle headingTextStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle titleTextStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle largeTitleTextStyle = TextStyle(
    fontSize: 21.sp,
    fontWeight: FontWeight.w700,
  );
}
