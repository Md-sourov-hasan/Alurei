import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../../../theme/app_colors.dart';
import '../../domain/entities/parent_notification_entity.dart';

class ParentNotificationItemCard extends StatelessWidget {
  const ParentNotificationItemCard({
    super.key,
    required this.notification,
    this.onTapAction,
  });

  final ParentNotificationEntity notification;
  final VoidCallback? onTapAction;

  @override
  Widget build(BuildContext context) {
    final isUnread = notification.isUnread;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0x0D0B5460) : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: isUnread
            ? const Border(
                left: BorderSide(
                  color: AppColors.primaryColor,
                  width: 4,
                ),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeadingIcon(),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.headerTextColor,
                          height: 24 / 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      notification.timeAgo,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mutedTextColor,
                        height: 18 / 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.description,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mutedTextColor,
                    height: 20 / 14,
                  ),
                ),
                if (notification.actionText != null) ...[
                  SizedBox(height: 12.h),
                  _buildActionButton(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingIcon() {
    if (notification.avatarAsset != null) {
      return Container(
        width: 48.w,
        height: 48.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          notification.avatarAsset!,
          fit: BoxFit.cover,
        ),
      );
    }

    final IconData iconData = _getIconForType(notification.type);
    final Color badgeColor = notification.badgeBgColor ?? const Color(0x1A0B5460);
    final Color iconColor = notification.badgeIconColor ?? AppColors.primaryColor;

    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(
        iconData,
        size: 20.w,
        color: iconColor,
      ),
    );
  }

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.activity:
        return IconsaxPlusLinear.task_square;
      case NotificationType.meal:
        return IconsaxPlusLinear.reserve;
      case NotificationType.message:
        return IconsaxPlusLinear.message;
      case NotificationType.grocery:
        return IconsaxPlusLinear.shopping_cart;
      case NotificationType.story:
        return IconsaxPlusLinear.book_1;
      case NotificationType.care:
        return IconsaxPlusLinear.teacher;
      case NotificationType.invitation:
        return IconsaxPlusLinear.profile_add;
      case NotificationType.offer:
        return IconsaxPlusLinear.discount_shape;
      case NotificationType.aiInsight:
        return IconsaxPlusLinear.cpu_setting;
    }
  }

  Widget _buildActionButton() {
    switch (notification.actionStyle) {
      case NotificationActionStyle.filledButton:
        return GestureDetector(
          onTap: onTapAction,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              notification.actionText!,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
                height: 20 / 14,
              ),
            ),
          ),
        );

      case NotificationActionStyle.outlinedButton:
        return GestureDetector(
          onTap: onTapAction,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999.r),
              border: Border.all(
                color: AppColors.bottomNavBorder,
                width: 1,
              ),
            ),
            child: Text(
              notification.actionText!,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.disabledTextColor,
                height: 20 / 14,
              ),
            ),
          ),
        );

      case NotificationActionStyle.link:
      // ignore: unreachable_switch_default
      default:
        final Color textColor =
            notification.actionColor ?? AppColors.primaryColor;
        return GestureDetector(
          onTap: onTapAction,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                notification.actionText!,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                  height: 20 / 14,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                IconsaxPlusLinear.arrow_right_3,
                size: 12.w,
                color: textColor,
              ),
            ],
          ),
        );
    }
  }
}
