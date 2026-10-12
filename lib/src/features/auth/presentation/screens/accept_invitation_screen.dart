import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

class AcceptInvitationScreen extends StatelessWidget {
  const AcceptInvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final appColors = context.appColors;

    return Scaffold(
      backgroundColor: appColors.primaryBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      24.verticalSpace,

                      // Title
                      Text(
                        'Review your invitation',
                        textAlign: TextAlign.center,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.primary,
                          height: 38 / 30,
                        ),
                      ),
                      8.verticalSpace,

                      // Subtitle
                      Text(
                        'Monica Steve has invited you to care for Eve. Join the family account to access routines, activities, meals, and care updates.',
                        textAlign: TextAlign.center,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: appColors.mutedText,
                          height: 20 / 14,
                        ),
                      ),
                      32.verticalSpace,

                      // Parents Section Header
                      Text(
                        'Parents',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: appColors.primaryText,
                          height: 28 / 18,
                        ),
                      ),
                      12.verticalSpace,

                      // Parent Profile Card
                      Container(
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          border: Border.all(
                              color: appColors.bottomNavBorder, width: 1.w),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.all(24.w),
                        child: Row(
                          children: [
                            // Avatar Image
                            Container(
                              width: 56.w,
                              height: 56.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: colors.primary,
                                  width: 2.w,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  AppAssets.parentTodayParentAvatar,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            16.horizontalSpace,
                            // Parent Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Monica Steve',
                                    style: GlobalTextStyles.interTextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: appColors.primaryText,
                                      height: 30 / 20,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  Text(
                                    '4517 Washington Ave.Kentucky 39495',
                                    style: GlobalTextStyles.interTextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: appColors.mutedText,
                                      height: 20 / 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      24.verticalSpace,

                      // Children's Information Section Header
                      Text(
                        'Children’s Information (2)',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: appColors.primaryText,
                          height: 28 / 18,
                        ),
                      ),
                      12.verticalSpace,

                      // Children Information Card
                      Container(
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          border: Border.all(
                              color: appColors.bottomNavBorder, width: 1.w),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Eve',
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: appColors.primaryText,
                                height: 30 / 20,
                              ),
                            ),
                            2.verticalSpace,
                            Text(
                              'Age: 4 years old',
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: appColors.mutedText,
                                height: 20 / 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Push buttons to bottom of screen
                      const Spacer(),
                      24.verticalSpace,

                      // Accept Invitation Button
                      AppButton(
                        label: 'Accept Invitation',
                        isFullWidth: true,
                        height: ButtonSize.large,
                        onPressed: () {
                          Get.offAllNamed<dynamic>(
                            AppRoutes.verificationSuccess,
                            arguments: <String, dynamic>{
                              'title': 'Invitation Accepted!',
                              'subtitle':
                                  'You have successfully accepted the invitation and joined the family care workspace.',
                              'targetRoute': AppRoutes.main,
                            },
                          );
                        },
                      ),
                      12.verticalSpace,

                      // Cancel Button using Reusable AppButton Outline
                      AppButton(
                        label: 'Cancel',
                        variant: ButtonVariant.outline,
                        isFullWidth: true,
                        height: ButtonSize.large,
                        onPressed: () {
                          Get.offAllNamed<dynamic>(
                            AppRoutes.verificationSuccess,
                            arguments: <String, dynamic>{
                              'title': 'Invitation Declined',
                              'subtitle':
                                  'You have declined the family invitation.',
                              'targetRoute': AppRoutes.login,
                            },
                          );
                        },
                      ),
                      16.verticalSpace,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
