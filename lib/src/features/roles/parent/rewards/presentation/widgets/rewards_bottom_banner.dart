import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';

class RewardsBottomBanner extends StatelessWidget {
  const RewardsBottomBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        'Thank you for making every care moment count. Your dedication deserves to be celebrated.',
        textAlign: TextAlign.center,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.mutedTextColor,
          height: 20 / 14,
        ),
      ),
    );
  }
}
