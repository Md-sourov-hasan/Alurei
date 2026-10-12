import 'package:alurei/src/imports/imports.dart';

class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // ── Checkmark Success Badge ─────────────────────────────────────
              SvgPicture.asset(
                AppAssets.passwordSuccess,
                width: 130.w,
                height: 130.w,
              ),
              24.verticalSpace,

              // ── Order Confirmed Title ───────────────────────────────────────
              Text(
                LangKey.parentKitchen.orderConfirmedTitle,
                textAlign: TextAlign.center,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  height: 32 / 24,
                ),
              ),
              12.verticalSpace,

              // ── Success Description ─────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Text(
                  LangKey.parentKitchen.orderConfirmedSuccessDesc,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.headerTextColor,
                    height: 24 / 16,
                  ),
                ),
              ),

              40.verticalSpace,

              // ── Primary Action: Back to Home ────────────────────────────────
              AppButton(
                label: LangKey.parentKitchen.backToHome,
                variant: ButtonVariant.primary,
                isFullWidth: true,
                height: ButtonSize.medium,
                onPressed: () {
                  Get.offAllNamed<void>(AppRoutes.main);
                },
              ),
              16.verticalSpace,

              // ── Secondary Action: Track Status ──────────────────────────────
              AppButton(
                label: LangKey.parentKitchen.trackStatus,
                variant: ButtonVariant.ghost,
                isFullWidth: true,
                height: ButtonSize.medium,
                onPressed: () {
                  Get.offNamed<void>(AppRoutes.trackStatus);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
