import 'package:alurei/src/imports/imports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/parent_conversation_model.dart';

/// Single conversation tile widget matching Figma node 23315:58207.
class ParentMessageTileWidget extends StatelessWidget {
  const ParentMessageTileWidget({
    super.key,
    required this.conversation,
    this.onTap,
  });

  final ParentConversationModel conversation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = conversation.isSelected;
    final bool isUnread = conversation.unreadCount > 0;
    final bool isNanny = conversation.roleTitle?.toLowerCase() == 'nanny';

    final Color tileBgColor = isSelected
        ? AppColors.primaryColor.withOpacity(0.05)
        : AppColors.whiteColor;

    final Color borderColor = isSelected
        ? AppColors.inventorySelectedBorder
        : AppColors.bottomNavBorder;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: tileBgColor,
          border: const Border(
            bottom: BorderSide(
              color: AppColors.bottomNavBorder,
              width: 1,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar with Border & Status Indicator
            SizedBox(
              width: 64.r,
              height: 64.r,
              child: Stack(
                children: [
                  Container(
                    width: 64.r,
                    height: 64.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: borderColor,
                        width: 2.9,
                      ),
                    ),
                    padding: EdgeInsets.all(2.9.r),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9999.r),
                      child: _buildAvatarImage(conversation.avatarUrl),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16.r,
                      height: 16.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: conversation.isOnline
                            ? AppColors.groceryStockGreen
                            : AppColors.stockSegmentText,
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 2.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            // Message Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name & Role
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversation.participantName,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.headerTextColor,
                                height: 28 / 18,
                              ),
                            ),
                            if (conversation.roleTitle != null) ...[
                              SizedBox(height: 2.h),
                              Text(
                                conversation.roleTitle!,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: isNanny
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isNanny
                                      ? AppColors.primaryColor
                                      : AppColors.mutedTextColor,
                                  height: 18 / 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Time & Unread Badge
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            conversation.formattedTime ?? '',
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: isUnread
                                  ? AppColors.groceryStockGreen
                                  : AppColors.neutral700,
                              height: 20 / 14,
                            ),
                          ),
                          if (isUnread) ...[
                            SizedBox(height: 4.h),
                            Container(
                              width: 20.r,
                              height: 20.r,
                              decoration: const BoxDecoration(
                                color: AppColors.groceryStockGreen,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${conversation.unreadCount}',
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                  height: 18 / 12,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    conversation.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: isUnread
                          ? AppColors.headerTextColor
                          : AppColors.mutedTextColor,
                      height: 20 / 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarImage(String url) {
    if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _fallbackAvatar(),
      );
    } else if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(color: AppColors.neutral200),
        errorWidget: (context, url, error) => _fallbackAvatar(),
      );
    }
    return _fallbackAvatar();
  }

  Widget _fallbackAvatar() {
    return Image.asset(
      AppAssets.icDeepa,
      fit: BoxFit.cover,
    );
  }
}
