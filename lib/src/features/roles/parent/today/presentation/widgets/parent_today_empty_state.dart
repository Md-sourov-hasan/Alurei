import 'package:alurei/src/imports/imports.dart';

/// Full-body prompt shown before a parent has added their first child.
class ParentTodayEmptyState extends StatelessWidget {
  const ParentTodayEmptyState({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.pagePadding.w,
          vertical: AppSpacing.xxxl.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(40.r)),
              child: Container(
                color: const Color(0xFFE7EEEF),
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40.r)),
                  child: Image.asset(
                    AppAssets.emptyTodayPlaceholder,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.xxl.h),
            Text(
              LangKey.parentToday.noChildrenTitle,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall?.copyWith(
                color: context.appColors.strongText,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            Text(
              LangKey.parentToday.noChildrenDescription,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.appColors.mutedText,
                height: 1.5,
              ),
            ),
            SizedBox(height: AppSpacing.xxl.h),
            AppButton(
              label: LangKey.parentToday.addFirstChild,
              onPressed: onPressed,
              height: ButtonSize.large,
              isFullWidth: true,
              prefixIcon: Icon(
                IconsaxPlusLinear.add,
                size: 20.sp,
                color: context.colors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
