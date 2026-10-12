import 'package:alurei/src/imports/imports.dart';

class ActivitiesSearchBar extends HookWidget {
  const ActivitiesSearchBar({
    super.key,
    required this.onSearchChanged,
    this.initialValue = '',
    this.onFilterPressed,
  });

  final ValueChanged<String> onSearchChanged;
  final String initialValue;
  final VoidCallback? onFilterPressed;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final textController = useTextEditingController(text: initialValue);

    useEffect(() {
      if (textController.text != initialValue) {
        textController.text = initialValue;
      }
      return null;
    }, [initialValue]);

    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: appColors.primaryBackground,
        border: Border.all(color: AppColors.brandTealBorder),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(
            IconsaxPlusLinear.search_normal,
            size: 20.w,
            color: AppColors.appleColor,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: textController,
              onChanged: onSearchChanged,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                color: appColors.primaryText,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                filled: false,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: LangKey.parentActivities.searchHint,
                hintStyle: GlobalTextStyles.interTextStyle(
                  fontSize: 13.sp,
                  color: AppColors.brandGrayHint,
                ),
              ),
            ),
          ),
          if (onFilterPressed != null) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: onFilterPressed,
              child: SvgPicture.asset(
                AppAssets.icFunnel,
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
