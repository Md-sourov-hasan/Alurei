import '../../imports/imports.dart';

class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    required this.label,
    required this.child,
    this.description,
  });

  final String label;
  final Widget child;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 16.sp,
            height: 24 / 16,
            fontWeight: description == null ? FontWeight.w500 : FontWeight.w600,
            color: context.appColors.primaryText,
          ),
        ),
        if (description != null) ...[
          SizedBox(height: 4.h),
          Text(
            description!,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w400,
              color: context.appColors.mutedText,
            ),
          ),
        ],
        SizedBox(height: 8.h),
        child,
      ],
    );
  }
}

class AppFormTextInput extends StatelessWidget {
  const AppFormTextInput({
    super.key,
    required this.controller,
    required this.hint,
    this.minLines = 1,
    this.maxLines = 1,
    this.onChanged,
    this.prefixIcon,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hint;
  final int minLines;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final IconData? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      style: GlobalTextStyles.interTextStyle(
        fontSize: 14.sp,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        color: context.appColors.primaryText,
      ),
      decoration: appFormInputDecoration(context, hint).copyWith(
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, size: 18.sp, color: context.appColors.mutedText)
            : null,
      ),
    );
  }
}

class AppFormSelectField extends StatelessWidget {
  const AppFormSelectField({
    super.key,
    required this.value,
    required this.hint,
    required this.onTap,
    this.icon = IconsaxPlusLinear.arrow_down,
  });

  final String? value;
  final String hint;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.lg,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        decoration: appFormInputBoxDecoration(context),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hasValue ? value! : hint,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: hasValue ? FontWeight.w500 : FontWeight.w400,
                  color: hasValue
                      ? context.appColors.primaryText
                      : context.appColors.mutedText,
                ),
              ),
            ),
            Icon(icon, size: 20.sp, color: context.appColors.mutedText),
          ],
        ),
      ),
    );
  }
}

class AppFormSectionCard extends StatelessWidget {
  const AppFormSectionCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(16.w),
      color: context.appColors.elevatedBackground,
      child: child,
    );
  }
}

class AppFormOutlinedPanel extends StatelessWidget {
  const AppFormOutlinedPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        border: Border.all(color: AppColors.brandTealBorder),
        borderRadius: AppBorders.lg,
      ),
      child: child,
    );
  }
}

class AppFormMiniTime extends StatelessWidget {
  const AppFormMiniTime({
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
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.sm,
      child: Column(
        children: [
          Text(
            label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 10.sp,
              height: 14 / 10,
              fontWeight: FontWeight.w600,
              color: context.appColors.secondaryText,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.neutral200),
              borderRadius: AppBorders.sm,
            ),
            child: Text(
              formatAppTimeOfDay(context, time),
              style: GlobalTextStyles.interTextStyle(
                fontSize: 12.sp,
                height: 18 / 12,
                fontWeight: FontWeight.w600,
                color: context.colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration appFormInputDecoration(BuildContext context, String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GlobalTextStyles.interTextStyle(
      fontSize: 14.sp,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
      color: context.appColors.mutedText,
    ),
    filled: true,
    fillColor: context.appColors.primaryBackground,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    border: const OutlineInputBorder(
      borderRadius: AppBorders.lg,
      borderSide: BorderSide(color: AppColors.brandTealBorder),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: AppBorders.lg,
      borderSide: BorderSide(color: AppColors.brandTealBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppBorders.lg,
      borderSide: BorderSide(color: context.colors.primary, width: 1.4),
    ),
  );
}

BoxDecoration appFormInputBoxDecoration(BuildContext context) {
  return BoxDecoration(
    color: context.appColors.primaryBackground,
    border: Border.all(color: AppColors.brandTealBorder),
    borderRadius: AppBorders.lg,
  );
}

String formatAppTimeOfDay(BuildContext context, TimeOfDay time) {
  return MaterialLocalizations.of(context).formatTimeOfDay(
    time,
    alwaysUse24HourFormat: false,
  );
}
