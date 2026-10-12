import '../../../../imports/imports.dart';
import '../controllers/settings_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: AppTopBar(
        title: LangKey.settingsScreen.title,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              DecoratedBox(
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
                  children: [
                    _buildSettingsItem(
                      context,
                      icon: IconsaxPlusLinear.security_safe,
                      title: LangKey.settingsScreen.changePassword,
                      titleColor: context.colors.onSurface,
                      iconBgColor: AppColors.bottomNavSelectedBackground,
                      iconColor: AppColors.primaryColor,
                      onTap: controller.onChangePasswordPressed,
                    ),
                    Divider(
                      height: 1.h,
                      thickness: 1.r,
                      color: context.appColors.bottomNavBorder,
                    ),
                    _buildSettingsItem(
                      context,
                      icon: IconsaxPlusLinear.trash,
                      title: LangKey.settingsScreen.deleteAccount,
                      titleColor: AppColors.redColor,
                      iconBgColor: AppColors.supportingRedShade,
                      iconColor: AppColors.redColor,
                      onTap: controller.onDeleteAccountPressed,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  LangKey.settingsScreen.deleteWarning,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.appColors.mutedText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color titleColor,
    required Color iconBgColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: titleColor,
                ),
              ),
            ),
            Icon(
              IconsaxPlusLinear.arrow_right_3,
              size: 18.sp,
              color: titleColor == AppColors.redColor
                  ? AppColors.redColor
                  : context.appColors.mutedText,
            ),
          ],
        ),
      ),
    );
  }
}
