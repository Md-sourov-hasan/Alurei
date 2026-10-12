import 'package:alurei/src/imports/imports.dart';

Future<String?> showAiSetupOptionMenu({
  required BuildContext context,
  required List<String> options,
  required String? selected,
}) {
  return showDialog<String>(
    context: context,
    barrierColor: AppColors.blackColor.withValues(alpha: 0.18),
    builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: Material(
          color: AppColors.transparentColor,
          child: Container(
            width: 212.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: context.appColors.primaryBackground,
              borderRadius: AppBorders.md,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((option) {
                final isSelected = option == selected ||
                    (selected == null && option == options.first);
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: option == options.last ? 0 : 8.h,
                  ),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(option),
                    borderRadius: AppBorders.lg,
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? context.colors.primary
                            : context.appColors.primaryBackground,
                        border: isSelected
                            ? null
                            : Border.all(color: AppColors.brandTealTrack),
                        borderRadius: AppBorders.lg,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 16.sp,
                                height: 24 / 16,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? context.colors.onPrimary
                                    : context.appColors.secondaryText,
                              ),
                            ),
                          ),
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? context.colors.onPrimary
                                    : AppColors.brandTealTrack,
                                width: 1.4,
                              ),
                            ),
                            child: isSelected
                                ? Center(
                                    child: Container(
                                      width: 10.w,
                                      height: 10.w,
                                      decoration: BoxDecoration(
                                        color: context.colors.onPrimary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(growable: false),
            ),
          ),
        ),
      );
    },
  );
}
