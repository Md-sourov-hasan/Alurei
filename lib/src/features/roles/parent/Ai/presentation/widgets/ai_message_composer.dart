import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';

class AiMessageComposer extends StatelessWidget {
  const AiMessageComposer({
    super.key,
    required this.textController,
    required this.onSend,
    this.onMicPressed,
    this.onAttachmentPressed,
  });

  final TextEditingController textController;
  final VoidCallback onSend;
  final VoidCallback? onMicPressed;
  final VoidCallback? onAttachmentPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFE3E8EF)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: TextField(
                        controller: textController,
                        maxLines: 4,
                        minLines: 1,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => onSend(),
                        decoration: InputDecoration(
                          hintText: LangKey.parentAi.inputHint,
                          hintStyle: context.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF7C8799),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: false,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 6.h),
                        ),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF202939),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (onAttachmentPressed != null) ...[
                        Material(
                          color: const Color(0xFFEFEDED),
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: onAttachmentPressed,
                            customBorder: const CircleBorder(),
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Icon(
                                Icons.attach_file_rounded,
                                size: 18.w,
                                color: const Color(0xFF475467),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                      ],
                      Material(
                        color: const Color(0xFFEFEDED),
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
                      Material(
                        color: Colors.transparent,
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: onSend,
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
            SizedBox(height: 12.h),
            Text(
              LangKey.parentAi.disclaimer,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF7C8799),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 18 / 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
