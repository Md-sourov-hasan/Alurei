import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';

class AiChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AiChatAppBar({
    super.key,
    this.onBack,
    this.onHistory,
  });

  final VoidCallback? onBack;
  final VoidCallback? onHistory;

  @override
  Size get preferredSize => Size.fromHeight(68.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            IconButton(
              onPressed: onBack ?? () => Get.back(),
              icon: Icon(
                IconsaxPlusLinear.arrow_left,
                size: 20.sp,
                color: context.colors.onSurface,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            SizedBox(width: 12.w),
            Image.asset(
              AppAssets.aiMessageIcon,
              width: 46.w,
              height: 46.w,
              fit: BoxFit.cover,
            ),


            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LangKey.parentAi.title,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colors.primary,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    LangKey.parentAi.subtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF4B5565),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onHistory,
              icon: SvgPicture.asset(
                AppAssets.icAiHistory,
                width: 20.w,
                height: 20.w,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
