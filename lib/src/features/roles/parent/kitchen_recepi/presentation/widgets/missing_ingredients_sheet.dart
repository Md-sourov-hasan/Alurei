import 'package:alurei/src/imports/imports.dart';

class MissingIngredientsSheet extends StatelessWidget {
  const MissingIngredientsSheet({
    super.key,
    required this.onScheduleAnyway,
  });

  final VoidCallback onScheduleAnyway;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle + Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 24),
              Container(
                width: 48.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: context.theme.brightness == Brightness.dark
                      ? context.appColors.bottomNavBorder
                      : AppColors.neutral300,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              GestureDetector(
                onTap: () => Get.back<void>(),
                child: Icon(
                  Icons.close,
                  size: 24.w,
                  color: context.appColors.mutedText,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Warning Icon
          SvgPicture.asset(
            AppAssets.triangleAlert,
            width: 56.w,
            height: 56.h,
            colorFilter: ColorFilter.mode(
              context.appColors.warning,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 16.h),

          // Title
          Text(
            LangKey.parentKitchen.missingIngredients,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: context.appColors.warning,
            ),
          ),
          SizedBox(height: 12.h),

          // Subtitle
          Text(
            LangKey.parentKitchen.missingIngredientsMessage,
            textAlign: TextAlign.center,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: context.appColors.mutedText,
              height: 24 / 16,
            ),
          ),
          SizedBox(height: 24.h),

          // Action Buttons
          AppButton(
            label: LangKey.parentKitchen.scheduleAnyway,
            onPressed: () {
              Get.back<void>(); // close bottom sheet
              onScheduleAnyway();
            },
            variant: ButtonVariant.primary,
            isFullWidth: true,
            height: ButtonSize.large,
          ),
          SizedBox(height: 12.h),
          AppButton(
            label: LangKey.parentKitchen.cancel,
            onPressed: () => Get.back<void>(),
            variant: ButtonVariant.outline,
            isFullWidth: true,
            height: ButtonSize.large,
          ),
        ],
      ),
    );
  }
}
