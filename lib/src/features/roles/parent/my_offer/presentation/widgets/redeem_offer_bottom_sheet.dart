import 'package:alurei/src/features/roles/parent/my_offer/presentation/controllers/my_offer_controller.dart';
import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/widgets/dashed_border_painter.dart';
import 'package:flutter/services.dart';

class RedeemOfferBottomSheet extends HookWidget {
  const RedeemOfferBottomSheet({
    super.key,
    required this.offer,
  });

  final RewardOffer offer;

  @override
  Widget build(BuildContext context) {
    final activeTab = useState<int>(0);

    const code = 'ALUREI15';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          12.verticalSpace,

          12.verticalSpace,
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.redeemOfferHeaderBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.redeemOfferHeaderBg,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15.r),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                AppAssets.icOfferTagDot,
                                width: 20.w,
                                height: 20.w,
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LangKey.parentMyOffer
                                          .exclusiveFamilyDiscount,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.redeemOfferHeaderBorder,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      offer.title,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.redeemOfferTitleText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => activeTab.value = 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: activeTab.value == 0
                                        ? AppColors.redeemOfferHeaderBorder
                                        : AppColors.whiteColor,
                                    border: const Border(
                                      bottom: BorderSide(
                                        color: AppColors.redeemOfferBorder,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.icOnline,
                                        width: 16.w,
                                        height: 16.w,
                                        colorFilter: ColorFilter.mode(
                                          activeTab.value == 0
                                              ? AppColors.whiteColor
                                              : AppColors.redeemOfferTabUnselectedText,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      6.horizontalSpace,
                                      Text(
                                        LangKey.parentMyOffer.online,
                                        style: GlobalTextStyles.interTextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: activeTab.value == 0
                                              ? AppColors.whiteColor
                                              : AppColors.redeemOfferTabUnselectedText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => activeTab.value = 1,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: activeTab.value == 1
                                        ? AppColors.redeemOfferHeaderBorder
                                        : AppColors.whiteColor,
                                    border: const Border(
                                      bottom: BorderSide(
                                        color: AppColors.redeemOfferBorder,
                                      ),
                                      left: BorderSide(
                                        color: AppColors.redeemOfferBorder,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.icInStore,
                                        width: 16.w,
                                        height: 16.w,
                                        colorFilter: ColorFilter.mode(
                                          activeTab.value == 1
                                              ? AppColors.whiteColor
                                              : AppColors.redeemOfferTabUnselectedText,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      6.horizontalSpace,
                                      Text(
                                        LangKey.parentMyOffer.inStore,
                                        style: GlobalTextStyles.interTextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: activeTab.value == 1
                                              ? AppColors.whiteColor
                                              : AppColors.redeemOfferTabUnselectedText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: activeTab.value == 0
                                ? _buildOnlineView(
                                    context: context,
                                    code: code,
                                    key: const ValueKey('online'))
                                : _buildInStoreView(
                                    context: context,
                                    code: code,
                                    key: const ValueKey('instore')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  24.verticalSpace,
                  AppButton(
                    isFullWidth: true,
                    label: activeTab.value == 0
                        ? 'Visit ${offer.partnerName}'
                        : LangKey.parentMyOffer.redeemOffer,
                    variant: ButtonVariant.primary,
                    color: AppColors.redeemOfferHeaderBorder,
                    suffixIcon: activeTab.value == 0
                        ? Icon(
                            Icons.open_in_new,
                            size: 18.w,
                            color: AppColors.whiteColor,
                          )
                        : null,
                    onPressed: () {
                      if (activeTab.value == 0) {
                        showGlobalToast(message: 'Opening website');
                      } else {
                        HapticFeedback.selectionClick();
                        Get.back<void>();
                        Get.toNamed<void>(
                          AppRoutes.redeemOfferSuccess,
                          arguments: offer,
                        );
                      }
                    },
                  ),
                  40.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineView(
      {required BuildContext context, required String code, Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter this code at checkout on the ${offer.partnerName} website to claim your discount.',
            style: GlobalTextStyles.interTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.redeemOfferTitleText,
              height: 1.4,
            ),
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: CustomPaint(
                  painter: DashedBorderPainter(
                    color: AppColors.redeemOfferDashedBorder,
                    strokeWidth: 1,
                    gap: 6,
                    radius: 20.r,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    alignment: Alignment.center,
                    child: Text(
                      code,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.redeemOfferCodeText,
                      ),
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              AppButton(
                width: ButtonSize.small,
                label: LangKey.parentMyOffer.copy,
                variant: ButtonVariant.primary,
                color: AppColors.redeemOfferHeaderBorder,
                prefixIcon: Icon(
                  IconsaxPlusLinear.copy,
                  size: 16.w,
                  color: AppColors.whiteColor,
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  showGlobalToast(message: LangKey.parentMyOffer.codeCopied);
                },
              ),
            ],
          ),
          16.verticalSpace,
          Text(
            offer.expiryDate,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.redeemOfferSubtext,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInStoreView(
      {required BuildContext context, required String code, Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scan the QR code at any ${offer.partnerName} store to apply your discount at the till.',
            style: GlobalTextStyles.interTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.redeemOfferSubtext,
              height: 1.4,
            ),
          ),
          20.verticalSpace,
          Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.redeemOfferSubtext,
                width: 1.5.w,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              IconsaxPlusLinear.camera,
              size: 48.w,
              color: AppColors.redeemOfferIconMuted,
            ),
          ),
          24.verticalSpace,
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.redeemOfferVoucherBadgeBg,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: const BoxDecoration(
                      color: AppColors.redeemOfferDashedBorder,
                      shape: BoxShape.circle,
                    ),
                  ),
                  8.horizontalSpace,
                  Text(
                    LangKey.parentMyOffer.orTellVoucherCode,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.redeemOfferCodeText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          16.verticalSpace,
          Center(
            child: SizedBox(
              width: 210.w,
              child: CustomPaint(
                painter: DashedBorderPainter(
                  color: AppColors.redeemOfferDashedBorder,
                  strokeWidth: 1,
                  gap: 6,
                  radius: 20.r,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  alignment: Alignment.center,
                  child: Text(
                    code,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.redeemOfferCodeText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
