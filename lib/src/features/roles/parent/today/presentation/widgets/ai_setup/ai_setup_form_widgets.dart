import 'package:alurei/src/imports/imports.dart';

import '../../controllers/ai_setup_guide_controller.dart';

class AiSetupField extends AppFormField {
  const AiSetupField({
    super.key,
    required super.label,
    required super.child,
    super.description,
  });
}

class AiSetupTextInput extends AppFormTextInput {
  const AiSetupTextInput({
    super.key,
    required super.controller,
    required super.hint,
    super.minLines,
    super.maxLines,
    super.onChanged,
  });
}

class AiSetupSelectField extends AppFormSelectField {
  const AiSetupSelectField({
    super.key,
    required super.value,
    required super.hint,
    required super.onTap,
    super.icon,
  });
}

class AiSetupCard extends AppFormSectionCard {
  const AiSetupCard({super.key, required super.child, super.padding});
}

class AiSetupOutlinedPanel extends AppFormOutlinedPanel {
  const AiSetupOutlinedPanel({super.key, required super.child});
}

class AiSetupDaySelector extends StatelessWidget {
  const AiSetupDaySelector({
    super.key,
    required this.selectedDays,
    required this.onToggle,
  });

  final Set<String> selectedDays;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: AiSetupGuideController.weekDays.map((day) {
        final isSelected = selectedDays.contains(day);
        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              end: day == AiSetupGuideController.weekDays.last ? 0 : 6.w,
            ),
            child: InkWell(
              onTap: () => onToggle(day),
              borderRadius: AppBorders.md,
              child: AnimatedContainer(
                duration: AppDurations.fast,
                height: 42.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colors.primary
                      : context.appColors.elevatedBackground,
                  border: Border.all(color: AppColors.neutral100),
                  borderRadius: AppBorders.md,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    day,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      height: 18 / 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? context.colors.onPrimary
                          : context.appColors.mutedText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(growable: false),
    );
  }
}

class AiSetupTimeBox extends StatelessWidget {
  const AiSetupTimeBox({
    super.key,
    required this.label,
    required this.time,
    required this.onTap,
  });

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w500,
              color: context.appColors.secondaryText,
            ),
          ),
          SizedBox(height: 8.h),
          InkWell(
            onTap: onTap,
            borderRadius: AppBorders.md,
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: context.appColors.primaryBackground,
                borderRadius: AppBorders.md,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      formatAiSetupTimeOfDay(context, time),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        fontWeight: FontWeight.w600,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                  Icon(
                    IconsaxPlusLinear.clock_1,
                    size: 18.sp,
                    color: context.appColors.mutedText,
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

class AiSetupRoutineCard extends StatelessWidget {
  const AiSetupRoutineCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.start,
    this.end,
    required this.onStartTap,
    this.onEndTap,
    this.tint,
    this.iconColor,
    this.onDelete,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final TimeOfDay start;
  final TimeOfDay? end;
  final VoidCallback onStartTap;
  final VoidCallback? onEndTap;
  final Color? tint;
  final Color? iconColor;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final chipColor = tint ?? AppColors.brandTealLight;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.appColors.secondaryBackground,
        border: Border.all(color: AppColors.bottomNavBorder),
        borderRadius: AppBorders.lg,
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(color: chipColor, shape: BoxShape.circle),
            child: Icon(icon,
                size: 22.sp, color: iconColor ?? context.colors.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    height: 24 / 16,
                    fontWeight: FontWeight.w600,
                    color: context.colors.primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    height: 18 / 12,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.disabledText,
                  ),
                ),
              ],
            ),
          ),
          AiSetupMiniTime(
            label: LangKey.parentToday.from,
            time: start,
            onTap: onStartTap,
          ),
          if (end != null && onEndTap != null) ...[
            SizedBox(width: 8.w),
            AiSetupMiniTime(
              label: LangKey.parentToday.toUpper,
              time: end!,
              onTap: onEndTap!,
            ),
          ],
          if (onDelete != null) ...[
            SizedBox(width: 6.w),
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                IconsaxPlusLinear.close_circle,
                size: 20.sp,
                color: context.appColors.mutedText,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class AiSetupMiniTime extends AppFormMiniTime {
  const AiSetupMiniTime({
    super.key,
    required super.label,
    required super.time,
    required super.onTap,
  });
}

class AiSetupSafetyOption extends StatelessWidget {
  const AiSetupSafetyOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.lg,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: context.appColors.elevatedBackground,
          border: Border.all(
            color:
                selected ? context.colors.primary : AppColors.transparentColor,
          ),
          borderRadius: AppBorders.lg,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w600,
                  color: context.colors.primary,
                ),
              ),
            ),
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? context.colors.primary
                    : context.appColors.elevatedBackground,
                border: Border.all(
                  color:
                      selected ? context.colors.primary : AppColors.neutral300,
                ),
              ),
              child: selected
                  ? Icon(
                      IconsaxPlusLinear.tick_circle,
                      size: 14.sp,
                      color: context.colors.onPrimary,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration aiSetupInputDecoration(BuildContext context, String hint) {
  return appFormInputDecoration(context, hint);
}

BoxDecoration aiSetupInputBoxDecoration(BuildContext context) {
  return appFormInputBoxDecoration(context);
}

String formatAiSetupTimeOfDay(BuildContext context, TimeOfDay time) {
  return formatAppTimeOfDay(context, time);
}
