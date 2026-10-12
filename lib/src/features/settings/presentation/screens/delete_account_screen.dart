import '../../../../imports/imports.dart';
import '../controllers/delete_account_controller.dart';

class DeleteAccountScreen extends GetView<DeleteAccountController> {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: AppTopBar(
        title: LangKey.deleteAccountScreen.title,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: context.appColors.elevatedBackground,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: context.appColors.bottomNavBorder,
                width: 1.r,
              ),
              boxShadow: AppShadows.subtle,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LangKey.deleteAccountScreen.beforeYouGo,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colors.onSurface,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  LangKey.deleteAccountScreen.subtitle,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.appColors.mutedText,
                  ),
                ),
                SizedBox(height: 24.h),
                ...controller.reasons.map((reason) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Obx(() {
                      final isSelected =
                          controller.selectedReason.value == reason;
                      return InkWell(
                        onTap: () => controller.reason = reason,
                        borderRadius: BorderRadius.circular(12.r),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.bottomNavSelectedBackground
                                : context.appColors.elevatedBackground,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : context.appColors.bottomNavBorder,
                              width: isSelected ? 1.5.r : 1.r,
                            ),
                          ),
                          child: Text(
                            reason,
                            textAlign: TextAlign.center,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : context.colors.onSurface,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
                SizedBox(height: 8.h),
                AppTextField(
                  hint: LangKey.deleteAccountScreen.describeIssueHint,
                  controller: controller.detailsController,
                  maxLines: 4,
                ),
                SizedBox(height: 24.h),
                Obx(
                  () => AppButton(
                    label: LangKey.deleteAccountScreen.delete,
                    isFullWidth: true,
                    color: AppColors.groceryMissingRed,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.onDeletePressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
