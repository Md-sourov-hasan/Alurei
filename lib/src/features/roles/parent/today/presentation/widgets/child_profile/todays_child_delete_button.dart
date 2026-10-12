import 'package:alurei/src/imports/imports.dart';

class TodaysChildDeleteButton extends StatelessWidget {
  const TodaysChildDeleteButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(50.h),
          foregroundColor: context.colors.error,
          side: BorderSide(color: context.colors.error),
          shape: const RoundedRectangleBorder(borderRadius: AppBorders.md),
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                isLoading
                    ? 'Deleting...'
                    : LangKey.parentToday.deleteChildProfile,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  height: 24 / 16,
                  fontWeight: FontWeight.w400,
                  color: context.colors.error,
                ),
              ),
            ),
            if (isLoading)
              SizedBox.square(
                dimension: 20.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  color: context.colors.error,
                ),
              )
            else
              Icon(IconsaxPlusLinear.trash, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
