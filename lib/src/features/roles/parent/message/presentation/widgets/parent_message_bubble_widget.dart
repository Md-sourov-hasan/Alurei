import 'dart:io';

import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';

import '../../data/models/parent_chat_message_model.dart';

/// Message bubble widget supporting text, image, date header, outgoing & incoming styles
/// based on Figma node 23315:58284.
class ParentMessageBubbleWidget extends StatelessWidget {
  const ParentMessageBubbleWidget({
    super.key,
    required this.message,
  });

  final ParentChatMessageModel message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (message.dateHeader != null) _buildDateHeader(message.dateHeader!),
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: message.isOutgoing
              ? _buildOutgoingBubble(context)
              : _buildIncomingBubble(context),
        ),
      ],
    );
  }

  Widget _buildDateHeader(String headerText) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 8.h, bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          headerText,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
            height: 18 / 12,
          ),
        ),
      ),
    );
  }

  Widget _buildOutgoingBubble(BuildContext context) {
    if (message.imageUrl != null && message.imageUrl!.isNotEmpty) {
      return _buildOutgoingImageBubble(context);
    }

    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 271.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
              topRight: Radius.circular(4.r),
            ),
          ),
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.text,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.brandLogoLight,
                  height: 24 / 16,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.formattedTime,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.neutral300,
                      height: 18 / 12,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  SvgPicture.asset(
                    AppAssets.icMessageDone,
                    width: 16.w,
                    height: 9.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutgoingImageBubble(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 271.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
              topRight: Radius.circular(4.r),
            ),
          ),
          padding: EdgeInsets.all(4.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: _buildImageWidget(message.imageUrl!),
                ),
              ),
              if (message.text.isNotEmpty) ...[
                SizedBox(height: 6.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    message.text,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.brandLogoLight,
                    ),
                  ),
                ),
              ],
              SizedBox(height: 4.h),
              Padding(
                padding: EdgeInsets.only(right: 8.w, bottom: 4.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.formattedTime,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.neutral300,
                        height: 18 / 12,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    SvgPicture.asset(
                      AppAssets.icMessageDone,
                      width: 16.w,
                      height: 9.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIncomingBubble(BuildContext context) {
    if (message.imageUrl != null && message.imageUrl!.isNotEmpty) {
      return _buildIncomingImageBubble(context);
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 304.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
              topLeft: Radius.circular(4.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mutedTextColor,
                  height: 24 / 16,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                message.formattedTime,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.stockSegmentText,
                  height: 15 / 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIncomingImageBubble(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 304.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.r),
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
              topLeft: Radius.circular(4.r),
            ),
          ),
          padding: EdgeInsets.all(4.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: SizedBox(
                  height: 222.h,
                  width: double.infinity,
                  child: _buildImageWidget(message.imageUrl!),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (message.text.isNotEmpty)
                      Text(
                        message.text,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackTextColor,
                          height: 24 / 16,
                        ),
                      ),
                    SizedBox(height: 4.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        message.formattedTime,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.stockSegmentText,
                          height: 18 / 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(color: AppColors.neutral200),
        errorWidget: (context, url, error) => Container(
          color: AppColors.neutral300,
          child: Icon(Icons.broken_image, size: 40.r, color: AppColors.neutral600),
        ),
      );
    } else if (url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: AppColors.neutral300,
          child: Icon(Icons.broken_image, size: 40.r, color: AppColors.neutral600),
        ),
      );
    } else {
      final file = File(url);
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.neutral300,
            child: Icon(Icons.broken_image, size: 40.r, color: AppColors.neutral600),
          ),
        );
      }
      return Container(
        color: AppColors.neutral300,
        child: Icon(Icons.broken_image, size: 40.r, color: AppColors.neutral600),
      );
    }
  }
}
