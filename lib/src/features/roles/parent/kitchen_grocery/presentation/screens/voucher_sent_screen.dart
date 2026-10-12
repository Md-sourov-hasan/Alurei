import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class VoucherSentScreen extends StatelessWidget {
  const VoucherSentScreen({
    super.key,
    this.storeName,
  });

  final String? storeName;

  @override
  Widget build(BuildContext context) {
    final store = storeName ?? (Get.arguments as String?) ?? 'Carrefour';

    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.parentKitchen.shoppingVoucher,
        titleColor: AppColors.primaryColor,
        showBackButton: true,
        showDivider: true,
        onPressed: () => Get.back<void>(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 8.h,
            bottom: 24.h,
          ),
          child: Column(
            children: [
              // ── Checkmark Success Badge ─────────────────────────────────────
              SvgPicture.asset(
                AppAssets.passwordSuccess,
                width: 140.w,
                height: 140.w,
              ),
              8.verticalSpace,

              // ── Voucher Sent Title & Subtitle ──────────────────────────────
              Text(
                LangKey.parentKitchen.voucherSent,
                textAlign: TextAlign.center,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                  height: 32 / 24,
                ),
              ),
              8.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  LangKey.parentKitchen.voucherSentSubtitle.replaceAll('{store}', store),
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.headerTextColor,
                    height: 24 / 16,
                  ),
                ),
              ),
              24.verticalSpace,

              // ── Main Confirmation Card ──────────────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.bottomNavSelectedBackground.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.brandTealBorder,
                    width: 1.w,
                  ),
                ),
                child: Text(
                  LangKey.parentKitchen.voucherSentNotice,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.headerTextColor,
                    height: 24 / 15,
                  ),
                ),
              ),
              24.verticalSpace,

              // ── Exclusive Reward / Coupon Section ────────────────────────────
              CustomPaint(
                painter: DottedBorderPainter(
                  color: AppColors.brandTealBorder,
                  strokeWidth: 1.5.w,
                  dash: 5.w,
                  gap: 4.w,
                  radius: 16.r,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 22.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.appColors.elevatedBackground,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        LangKey.parentKitchen.exclusiveReward,
                        textAlign: TextAlign.center,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                          height: 18 / 12,
                          letterSpacing: 1.w,
                        ),
                      ),
                      8.verticalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 28.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.appColors.primaryBackground,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            width: 1.w,
                          ),
                        ),
                        child: Text(
                          'ALUREI10',
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                            height: 32 / 24,
                          ),
                        ),
                      ),
                      12.verticalSpace,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.headerTextColor,
                            height: 22 / 15,
                          ),
                          children: [
                            TextSpan(
                              text: LangKey.parentKitchen.saveCouponPrefix,
                            ),
                            TextSpan(
                              text: LangKey.parentKitchen.fivePercentDiscount,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            TextSpan(
                              text: LangKey.parentKitchen.onYourOrder,
                            ),
                          ],
                        ),
                      ),
                      16.verticalSpace,

                      // Copy Code Button
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            const ClipboardData(text: 'ALUREI10'),
                          );
                          showGlobalToast(
                            message: LangKey.parentKitchen.couponCopied.replaceAll('{}', 'ALUREI10'),
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 9.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                IconsaxPlusLinear.copy,
                                size: 16.w,
                                color: AppColors.primaryColor,
                              ),
                              8.horizontalSpace,
                              Text(
                                LangKey.parentKitchen.copyCode,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                  height: 20 / 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              32.verticalSpace,

              // ── Primary Action Buttons ──────────────────────────────────────
              AppButton(
                label: LangKey.parentKitchen.backToHome,
                variant: ButtonVariant.primary,
                color: AppColors.primaryColor,
                isFullWidth: true,
                onPressed: () => Get.offAllNamed(AppRoutes.main),
                height: ButtonSize.large,
              ),
              12.verticalSpace,
              AppButton(
                label: LangKey.parentKitchen.trackStatus,
                variant: ButtonVariant.ghost,
                textColor: AppColors.headerTextColor,
                isFullWidth: true,
                onPressed: () => Get.toNamed(AppRoutes.trackStatus),
                height: ButtonSize.medium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
