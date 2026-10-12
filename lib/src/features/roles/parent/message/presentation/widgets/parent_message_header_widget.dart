import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';

/// Top header bar widget for Parent Message Thread based on Figma Node 23315:58284.
class ParentMessageHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const ParentMessageHeaderWidget({
    super.key,
    required this.participantName,
    required this.avatarUrl,
    required this.isOnline,
    this.statusText = 'Online',
    this.selectedLanguage = 'En',
    this.onBackPressed,
    this.onInfoPressed,
    this.onLanguagePressed,
  });

  final String participantName;
  final String avatarUrl;
  final bool isOnline;
  final String statusText;
  final String selectedLanguage;
  final VoidCallback? onBackPressed;
  final VoidCallback? onInfoPressed;
  final VoidCallback? onLanguagePressed;

  @override
  Size get preferredSize => Size.fromHeight(64.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteBackgroundColor,
      elevation: 0,
      surfaceTintColor: AppColors.transparentColor,
      automaticallyImplyLeading: false,
      titleSpacing: 16.w,
      toolbarHeight: 64.h,
      title: Row(
        children: [
          // Back arrow
          InkWell(
            onTap: onBackPressed ?? () => Get.back(),
            borderRadius: BorderRadius.circular(20.r),
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: Icon(
                IconsaxPlusLinear.arrow_left_1,
                size: 24.sp,
                color: AppColors.headerTextColor,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Avatar with Online dot
          SizedBox(
            width: 40.r,
            height: 40.r,
            child: Stack(
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.inventorySelectedBorder,
                      width: 1.8.w,
                    ),
                  ),
                  padding: EdgeInsets.all(1.8.r),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9999.r),
                    child: _buildAvatarWidget(avatarUrl),
                  ),
                ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10.r,
                      height: 10.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.groceryStockGreen,
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 1.25.w,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Name & Online Status
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  participantName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headerTextColor,
                    height: 24 / 18,
                  ),
                ),
                Text(
                  statusText,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                    height: 18 / 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Language selector pill
          InkWell(
            onTap: onLanguagePressed,
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.primaryBackgroundColor,
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedLanguage,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                      height: 18 / 12,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    IconsaxPlusLinear.arrow_down_1,
                    size: 14.sp,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Info button
          InkWell(
            onTap: onInfoPressed,
            borderRadius: BorderRadius.circular(20.r),
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: SvgPicture.asset(
                AppAssets.icInfo,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarWidget(String url) {
    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _fallbackAvatar(),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(color: AppColors.neutral200),
      errorWidget: (context, url, error) => _fallbackAvatar(),
    );
  }

  Widget _fallbackAvatar() {
    return Image.asset(
      AppAssets.icDeepa,
      fit: BoxFit.cover,
    );
  }
}
