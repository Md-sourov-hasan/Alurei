import 'package:alurei/src/imports/imports.dart';

Future<TimeOfDay?> showAppTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) {
  var selected = initialTime;
  return showDialog<TimeOfDay>(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
        shape: const RoundedRectangleBorder(borderRadius: AppBorders.lg),
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      LangKey.parentToday.selectTime,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 20.sp,
                        height: 30 / 20,
                        fontWeight: FontWeight.w500,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: Get.back<void>,
                    icon: const Icon(IconsaxPlusLinear.close_circle),
                  ),
                ],
              ),
              SizedBox(
                height: 180.h,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(
                    2024,
                    1,
                    1,
                    initialTime.hour,
                    initialTime.minute,
                  ),
                  onDateTimeChanged: (value) {
                    selected =
                        TimeOfDay(hour: value.hour, minute: value.minute);
                  },
                ),
              ),
              AppButton(
                label: LangKey.parentToday.confirm,
                onPressed: () => Navigator.of(context).pop(selected),
                height: ButtonSize.large,
                isFullWidth: true,
              ),
              SizedBox(height: 8.h),
              AppButton(
                label: LangKey.parentToday.cancel,
                onPressed: Get.back<void>,
                variant: ButtonVariant.ghost,
                height: ButtonSize.medium,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      );
    },
  );
}
