import 'dart:ui';

import 'package:alurei/src/imports/imports.dart';

class AiGeneratingOverlay extends StatelessWidget {
  const AiGeneratingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: ColoredBox(
          color: AppColors.blackColor.withValues(alpha: 0.45),
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 28.w),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
              decoration: BoxDecoration(
                color: context.appColors.elevatedBackground,
                borderRadius: AppBorders.xl,
                border: Border.all(color: AppColors.brandGrayBorder),
                boxShadow: AppShadows.modal,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 86.w,
                    height: 86.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 5.w,
                          color: context.colors.primary,
                          backgroundColor: AppColors.brandTealLight,
                        ),
                        Icon(
                          IconsaxPlusBold.magic_star,
                          size: 34.sp,
                          color: context.colors.primary,
                        )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .scale(
                              begin: const Offset(0.88, 0.88),
                              end: const Offset(1.08, 1.08),
                              duration: const Duration(milliseconds: 900),
                              curve: Curves.easeInOut,
                            )
                            .then()
                            .scale(
                              begin: const Offset(1.08, 1.08),
                              end: const Offset(0.88, 0.88),
                              duration: const Duration(milliseconds: 900),
                              curve: Curves.easeInOut,
                            ),
                      ],
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    LangKey.parentToday.aiGeneratingTitle,
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 22.sp,
                      height: 30 / 22,
                      fontWeight: FontWeight.w700,
                      color: context.colors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    LangKey.parentToday.aiGeneratingDescription,
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AiGeneratedDayCompletedView extends StatelessWidget {
  const AiGeneratedDayCompletedView({
    super.key,
    required this.childName,
    required this.onViewToday,
  });

  final String childName;
  final VoidCallback onViewToday;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppAssets.aiGeneratedDayCompleted, fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
            child: ColoredBox(
              color: AppColors.blackColor.withValues(alpha: 0.05),
            ),
          ),
          ColoredBox(color: AppColors.blackColor.withValues(alpha: 0.10)),
          Center(
            child: Container(
              width: 384.w,
              margin: EdgeInsets.symmetric(horizontal: 28.w),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.h),
              decoration: BoxDecoration(
                color: context.appColors.primaryBackground,
                border: Border.all(color: AppColors.brandGrayBorder),
                borderRadius: AppBorders.lg,
                boxShadow: AppShadows.modal,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LangKey.parentToday.dayReadyTitle.replaceFirst(
                      '{}',
                      childName.isEmpty ? 'Eve' : childName,
                    ),
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 30.sp,
                      height: 38 / 30,
                      fontWeight: FontWeight.w700,
                      color: context.colors.primary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    LangKey.parentToday.dayReadyDescription,
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      height: 24 / 16,
                      fontWeight: FontWeight.w400,
                      color: context.appColors.secondaryText,
                    ),
                  ),
                  SizedBox(height: 35.h),
                  AppButton(
                    label: LangKey.parentToday.viewTodayCareFlow,
                    onPressed: onViewToday,
                    height: ButtonSize.large,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
