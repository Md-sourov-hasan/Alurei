import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/app_language.dart';
import '../controllers/language_controller.dart';

class LanguageScreen extends GetView<LanguageController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: context.appColors.elevatedBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            IconsaxPlusLinear.arrow_left,
            color: context.appColors.primaryText,
          ),
          onPressed: () => Get.back<void>(),
        ),
        title: Text(
          LangKey.languageScreen.title,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: context.appColors.primaryText,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Instruction Header Section
              Text(
                LangKey.languageScreen.choosePreferredLanguage,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
                  color: context.appColors.primaryText,
                  height: 1.3,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                LangKey.languageScreen.selectLanguageSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.appColors.secondaryText,
                  fontSize: 15.sp,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24.h),

              Obx(() {
                final currentCode = controller.selectedLanguageCode.value;
                final languages = controller.visibleLanguages;
                return Skeletonizer(
                  enabled: controller.isLoading.value,
                  child: Column(
                    children: [
                      for (final language in languages) ...[
                        _buildLanguageItem(
                          context,
                          language: language,
                          isSelected: currentCode == language.code,
                        ),
                        SizedBox(height: 12.h),
                      ],
                    ],
                  ),
                );
              }),

              Obx(() {
                if (controller.errorMessage.value.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    controller.errorMessage.value,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.error,
                    ),
                  ),
                );
              }),

              SizedBox(height: 32.h),

              Obx(
                () => AppButton(
                  label: LangKey.languageScreen.save,
                  isFullWidth: true,
                  height: ButtonSize.large,
                  isLoading: controller.isSaving.value,
                  onPressed:
                      controller.isSaving.value || controller.isLoading.value
                          ? null
                          : () => controller.saveLanguage(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageItem(
    BuildContext context, {
    required AppLanguage language,
    required bool isSelected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.selectLanguage(language.code, context),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          decoration: BoxDecoration(
            color: context.appColors.elevatedBackground,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              width: 2.w,
            ),
          ),
          child: Row(
            children: [
              // Circular icon container
              Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.primaryColor.withValues(alpha: 0.1)
                      : context.appColors.primaryBackground,
                ),
                alignment: Alignment.center,
                child: Icon(
                  _iconForLanguage(language.code),
                  size: 22.r,
                  color: isSelected
                      ? AppColors.primaryColor
                      : context.appColors.secondaryText,
                ),
              ),
              SizedBox(width: 16.w),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language.label,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: context.appColors.primaryText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      language.nativeName,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        color: context.appColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              // Checkmark badge for selected item
              if (isSelected)
                Icon(
                  IconsaxPlusBold.tick_circle,
                  size: 24.r,
                  color: AppColors.primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconForLanguage(String code) {
    switch (code) {
      case 'ar':
        return IconsaxPlusLinear.translate;
      case 'si':
        return IconsaxPlusLinear.voice_square;
      default:
        return IconsaxPlusLinear.global;
    }
  }
}
