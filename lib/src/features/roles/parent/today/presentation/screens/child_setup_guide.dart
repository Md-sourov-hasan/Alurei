import 'dart:ui';

import 'package:alurei/src/imports/imports.dart';

/// Figma node 24552:46680 — child-day setup entry point.
class ChildSetupGuide extends StatelessWidget {
  const ChildSetupGuide({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArguments = _routeArguments();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.childSetupGuideBackground,
            fit: BoxFit.cover,
          ),
          ColoredBox(color: AppColors.blackColor.withValues(alpha: 0.5)),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: ColoredBox(
              color: AppColors.blackColor.withValues(alpha: 0.05),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FigmaBackButton(),
                  SizedBox(height: 24.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero Section
                      Column(
                        children: [
                          Text(
                            LangKey.parentToday.childSetupGuideTitle,
                            textAlign: TextAlign.center,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 30.sp,
                              height: 38 / 30,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF4F4F4),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            LangKey.parentToday.childSetupGuideSubtitle,
                            textAlign: TextAlign.center,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 16.sp,
                              height: 24 / 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      // Option 1: Guided
                      _GuidedOptionCard(
                        onPressed: () => Get.toNamed<void>(
                          AppRoutes.aiSetupGuide,
                          arguments: routeArguments,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      // Option 2: Manual
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: _ManualOptionCard(
                          onPressed: () => Get.toNamed<void>(
                            AppRoutes.buildDayFromLibrary,
                            arguments: routeArguments,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, Object?> _routeArguments() {
    final arguments = Get.arguments;
    if (arguments is Map) return arguments.cast<String, Object?>();
    return const <String, Object?>{};
  }
}

class _FigmaBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: MaterialLocalizations.of(context).backButtonTooltip,
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: Material(
          color: AppColors.transparentColor,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: Get.back<void>,
            customBorder: const CircleBorder(),
            child: Center(
              child: Icon(
                IconsaxPlusLinear.arrow_left,
                size: 24.sp,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GuidedOptionCard extends StatelessWidget {
  const _GuidedOptionCard({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.secondaryTeal,
            AppColors.whiteColor,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(4.w),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            // Cloud face badge (top-right)
            PositionedDirectional(
              top: 21.h,
              end: 21.w,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withValues(alpha: 0.2),
                      blurRadius: 12.r,
                      offset: Offset(0, 10.h),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Image.asset(
                    AppAssets.childSetupGuidedCloudBadge,
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Main content
            Padding(
              padding: EdgeInsets.all(28.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppAssets.childSetupGuidedIcon,
                    width: 62.w,
                    height: 62.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    LangKey.parentToday.guidedSetupTitle,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 24.sp,
                      height: 32 / 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFF4F4F4),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    LangKey.parentToday.guidedSetupDescription,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFE3E8EF),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whiteColor,
                        foregroundColor: const Color(0xFF083C44),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        LangKey.parentToday.startGuidedSetup,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 16.sp,
                          height: 24 / 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF083C44),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ManualOptionCard extends StatelessWidget {
  const _ManualOptionCard({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.bottomNavBorder,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14006876),
            blurRadius: 20.r,
            offset: Offset(0, 15.h),
            spreadRadius: -5.r,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppAssets.childSetupManualIcon,
              width: 62.w,
              height: 62.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 12.h),
            Text(
              LangKey.parentToday.manualSetupTitle,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 20.sp,
                height: 30 / 20,
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              LangKey.parentToday.manualSetupDescription,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFEEF2F6),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.whiteColor,
                  foregroundColor: const Color(0xFF083C44),
                  elevation: 0,
                  side: const BorderSide(
                    color: Color(0xFFB3CACE),
                    width: 1,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  LangKey.parentToday.startManualBuild,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    height: 24 / 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF083C44),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
