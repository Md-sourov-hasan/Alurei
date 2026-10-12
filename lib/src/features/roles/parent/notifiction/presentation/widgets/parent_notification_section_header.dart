import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../theme/app_colors.dart';

class ParentNotificationSectionHeader extends StatelessWidget {
  const ParentNotificationSectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.disabledTextColor,
          height: 20 / 14,
        ),
      ),
    );
  }
}
