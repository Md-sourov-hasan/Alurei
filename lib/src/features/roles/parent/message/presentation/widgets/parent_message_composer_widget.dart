import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';

/// Message composer input footer widget based on Figma Node 23315:58284.
class ParentMessageComposerWidget extends StatelessWidget {
  const ParentMessageComposerWidget({
    super.key,
    required this.textController,
    required this.onSendPressed,
    this.onAttachmentPressed,
    this.onMicPressed,
  });

  final TextEditingController textController;
  final VoidCallback onSendPressed;
  final VoidCallback? onAttachmentPressed;
  final VoidCallback? onMicPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryBackgroundColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.groceryNoteBorder,
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withOpacity(0.05),
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Attachment paperclip button
              if (onAttachmentPressed != null) ...[
                Material(
                  color: AppColors.groceryCardBorder,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: onAttachmentPressed,
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: SvgPicture.asset(
                        AppAssets.icDocument,
                        width: 14.w,
                        height: 18.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
              ],
              // Text Input field
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: TextField(
                    controller: textController,
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => onSendPressed(),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.headerTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Write your message',
                      hintStyle: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.brandGrayHint,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      filled: false,
                      fillColor: AppColors.transparentColor,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 6.h),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Audio recording mic button
                  if (onMicPressed != null) ...[
                    Material(
                      color: AppColors.groceryCardBorder,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: onMicPressed,
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: SvgPicture.asset(
                            AppAssets.icVoice,
                            width: 14.w,
                            height: 18.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  // Send button
                  Material(
                    color: AppColors.transparentColor,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: onSendPressed,
                      customBorder: const CircleBorder(),
                      child: SvgPicture.asset(
                        AppAssets.icSend,
                        width: 36.w,
                        height: 36.w,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
