import 'package:alurei/src/shared/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../shared/app_assets.dart';
import '../../../../../../shared/localization/generated/lang_key.g.dart';
import '../../../../../../shared/widgets/app_button.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../../../../theme/global_text_styles.dart';

class ParentMessageEmptyStateWidget extends StatelessWidget {
  const ParentMessageEmptyStateWidget({
    super.key,
    required this.onManageCaregiversPressed,
  });

  final VoidCallback onManageCaregiversPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          // Illustration Card
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: AspectRatio(
              aspectRatio: 408 / 315,
              child: Image.asset(
                AppAssets.parentMessageEmptyIllustration,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.whiteColor,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 64.r,
                      color: AppColors.primaryColor,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 24.h),
          // Title
          Text(
            LangKey.parentMessage.noConversationsTitle,
            textAlign: TextAlign.center,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.headerTextColor,
              height: 32 / 24,
            ),
          ),
          SizedBox(height: 16.h),
          // Subtitle
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              LangKey.parentMessage.noConversationsSubtitle,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.mutedTextColor,
                height: 24 / 16,
              ),
            ),
          ),
          SizedBox(height: 32.h),
          // Call-To-Action Button
          AppButton(
            label: LangKey.parentMessage.goToManageCaregivers,
            isFullWidth: true,
            height: ButtonSize.large,
            color: AppColors.primaryColor,
            textColor: AppColors.whiteColor,
            onPressed: onManageCaregiversPressed,
          ),
        ],
      ),
    );
  }
}
