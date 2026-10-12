import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../imports/core_imports.dart';

/// A premium themed text form field wrapping [TextFormField] for consistency.
///
/// Usage:
/// ```dart
/// AppTextField(
///   label: 'Email',
///   hint: 'you@example.com',
///   controller: _emailController,
///   keyboardType: TextInputType.emailAddress,
///   isRequired: true,
///   validator: (v) => v!.isEmpty ? 'Required' : null,
/// )
/// ```
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.label,
    this.labelStyle,
    this.asteriskColor,
    this.borderColor,
    this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.autofocus = false,
    this.isRequired = false,
    this.onTap,
  });

  final String? label;
  final TextStyle? labelStyle;
  final Color? asteriskColor;
  final Color? borderColor;
  final String? hint;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final bool autofocus;
  final bool isRequired;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Text(
                label!,
                style: labelStyle ?? GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackTextColor,
                ),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: asteriskColor ?? AppColors.brandRedAsterisk,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
        GestureDetector(
          onTap: (readOnly && enabled && onTap != null) ? onTap : null,
          child: AbsorbPointer(
            absorbing: readOnly && onTap != null,
            child: TextFormField(
              controller: controller,
              initialValue: initialValue,
              validator: validator,
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmitted,
              focusNode: focusNode,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              obscureText: obscureText,
              readOnly: readOnly,
              enabled: enabled,
              maxLines: obscureText ? 1 : maxLines,
              minLines: minLines,
              autofocus: autofocus,
              onTap: onTap,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.blackTextColor,
              ),
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintText: hint ?? label,
                hintStyle: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.brandGrayText,
                ),
                filled: true,
                fillColor: AppColors.brandTealIce,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: prefixIcon,
                      )
                    : null,
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                suffixIcon: suffixIcon != null
                    ? Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: suffixIcon,
                      )
                    : null,
                suffixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide:
                      BorderSide(color: borderColor ?? AppColors.brandGrayBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide:
                      BorderSide(color: borderColor ?? AppColors.brandGrayBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(
                      color: AppColors.primaryColor, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: AppColors.errorColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide:
                      const BorderSide(color: AppColors.errorColor, width: 1.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
