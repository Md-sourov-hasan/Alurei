import 'package:alurei/src/imports/imports.dart';

class TrackStatusScreen extends StatelessWidget {
  const TrackStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.parentKitchen.myOrder,
        titleColor: AppColors.primaryColor,
        showBackButton: true,
        showDivider: false,
        onPressed: () => Get.back<void>(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  children: [
                    // ── View Voucher Header Button ─────────────────────────────────
                    Center(
                      child: IntrinsicWidth(
                        child: AppButton(
                          label: LangKey.parentKitchen.viewVoucher,
                          variant: ButtonVariant.primary,
                          color: AppColors.primaryColor,
                          height: ButtonSize.medium,
                          isVertical: true,
                          prefixIcon: Icon(
                            IconsaxPlusLinear.eye,
                            size: 20.w,
                            color: AppColors.whiteColor,
                          ),
                          onPressed: () =>
                              Get.toNamed(AppRoutes.shoppingVoucher),
                        ),
                      ),
                    ),
                    16.verticalSpace,

                    // ── Voucher Title & Estimated Time ─────────────────────────────
                    Text(
                      LangKey.parentKitchen
                          .trackingVoucherCode.replaceAll('{code}', 'AL-2026-X892'),
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                        height: 24 / 16,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      LangKey.parentKitchen
                          .estimatedDelivery.replaceAll('{time}', 'Today, 2:00 PM'),
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mutedTextColor,
                        height: 18 / 13,
                      ),
                    ),
                    20.verticalSpace,

                    // ── Timeline Status Card ───────────────────────────────────────
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.appColors.elevatedBackground,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      padding: EdgeInsets.all(20.w),
                      child: const _TrackingTimelineList(),
                    ),
                    16.verticalSpace,
                  ],
                ),
              ),
            ),

            // ── Fixed Bottom Action Button ───────────────────────────────────
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
              decoration: BoxDecoration(
                color: context.appColors.primaryBackground,
              ),
              child: AppButton(
                label: LangKey.parentKitchen.cancelOrder,
                variant: ButtonVariant.outline,
                textColor: AppColors.primaryColor,
                borderColor: AppColors.brandTealBorder,
                isFullWidth: true,
                onPressed: () async {
                  final confirmed = await showAppConfirmationDialog(
                    title: LangKey.parentKitchen.orderCancelTitle,
                    message: LangKey.parentKitchen.orderCancelMessage,
                    confirmLabel: LangKey.parentKitchen.yes,
                    cancelLabel: LangKey.parentKitchen.no,
                  );
                  if (confirmed ?? false) {
                    showGlobalToast(message: LangKey.parentKitchen.orderCancelledSuccessfully);
                    Get.back<void>();
                  }
                },
                height: ButtonSize.large,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Renders the complete 6-step timeline for order tracking
class _TrackingTimelineList extends StatelessWidget {
  const _TrackingTimelineList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Step 1: Voucher Sent
        _TimelineItem(
          isCompleted: true,
          isActive: false,
          showConnector: true,
          connectorColor: AppColors.primaryColor,
          badgeIcon: SvgPicture.asset(
            AppAssets.icOrderDone,
            width: 20.w,
            height: 20.w,
          ),
          headerRightWidget: Text(
            'Oct 24, 09:15 AM',
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.mutedTextColor,
              height: 16 / 12,
            ),
          ),
          title: LangKey.parentKitchen.voucherSent,
          description: LangKey.parentKitchen.voucherSentDesc,
        ),

        // Step 2: Store Reviewing
        _TimelineItem(
          isCompleted: true,
          isActive: false,
          showConnector: true,
          connectorColor: AppColors.primaryColor,
          badgeIcon: SvgPicture.asset(
            AppAssets.icOrderDone,
            width: 20.w,
            height: 20.w,
          ),
          title: LangKey.parentKitchen.storeReviewingTitle,
          description: LangKey.parentKitchen.storeReviewingDesc,
          extraContent: Container(
            margin: EdgeInsets.only(top: 10.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.bottomNavSelectedBackground.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8.r),
              border: Border(
                left: BorderSide(
                  color: AppColors.primaryColor,
                  width: 3.w,
                ),
              ),
            ),
            child: Text(
              LangKey.parentKitchen.storeReviewingCallout,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.headerTextColor,
                height: 18 / 12,
              ).copyWith(fontStyle: FontStyle.italic),
            ),
          ),
        ),

        // Step 3: Store Reviewed (ACTIVE)
        _TimelineItem(
          isCompleted: false,
          isActive: true,
          showConnector: true,
          connectorColor: AppColors.inputBorder,
          badgeIcon: SvgPicture.asset(
            AppAssets.icStoreReview,
            width: 16.w,
            height: 16.w,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          headerRightWidget: Text(
            LangKey.parentKitchen.activeStatus,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
              height: 18 / 13,
            ),
          ),
          title: LangKey.parentKitchen.storeReviewedTitle,
          description: LangKey.parentKitchen.storeReviewedDesc,
          extraContent: Padding(
            padding: EdgeInsets.only(top: 14.h),
            child: AppButton(
              label: LangKey.parentKitchen.reviewAndConfirmOrder,
              variant: ButtonVariant.primary,
              color: AppColors.primaryColor,
              isFullWidth: true,
              height: ButtonSize.medium,
              onPressed: () {
                Get.toNamed<void>(AppRoutes.checkout);
              },
            ),
          ),
        ),

        // Step 4: Order Confirmed
        _TimelineItem(
          isCompleted: false,
          isActive: false,
          showConnector: true,
          connectorColor: AppColors.inputBorder,
          badgeIcon: SvgPicture.asset(
            AppAssets.icOrderConfirm,
            width: 16.w,
            height: 16.w,
            colorFilter: const ColorFilter.mode(
              AppColors.mutedTextColor,
              BlendMode.srcIn,
            ),
          ),
          title: LangKey.parentKitchen.orderConfirmedTitle,
          description: LangKey.parentKitchen.orderConfirmedDesc,
        ),

        // Step 5: Out for Delivery
        _TimelineItem(
          isCompleted: false,
          isActive: false,
          showConnector: true,
          connectorColor: AppColors.inputBorder,
          badgeIcon: SvgPicture.asset(
            AppAssets.icTrack,
            width: 16.w,
            height: 16.w,
            colorFilter: const ColorFilter.mode(
              AppColors.mutedTextColor,
              BlendMode.srcIn,
            ),
          ),
          title: LangKey.parentKitchen.outForDeliveryTitle,
          description: LangKey.parentKitchen.outForDeliveryDesc,
        ),

        // Step 6: Delivered
        _TimelineItem(
          isCompleted: false,
          isActive: false,
          showConnector: false,
          badgeIcon: SvgPicture.asset(
            AppAssets.icHomeLocation,
            width: 16.w,
            height: 16.w,
            colorFilter: const ColorFilter.mode(
              AppColors.mutedTextColor,
              BlendMode.srcIn,
            ),
          ),
          title: LangKey.parentKitchen.deliveredTitle,
          description: LangKey.parentKitchen.deliveredDesc,
        ),
      ],
    );
  }
}

/// Single timeline item row with left badge/connector and right details
class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.isCompleted,
    required this.isActive,
    required this.showConnector,
    required this.badgeIcon,
    required this.title,
    required this.description,
    this.connectorColor,
    this.headerRightWidget,
    this.extraContent,
  });

  final bool isCompleted;
  final bool isActive;
  final bool showConnector;
  final Widget badgeIcon;
  final String title;
  final String description;
  final Color? connectorColor;
  final Widget? headerRightWidget;
  final Widget? extraContent;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Left Column: Badge Icon & Vertical Connector Line ────────────
          SizedBox(
            width: 32.w,
            child: Column(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.primaryColor
                        : (isActive
                            ? AppColors.bottomNavSelectedBackground
                            : AppColors.brandGrayLight),
                    shape: BoxShape.circle,
                    border: isActive
                        ? Border.all(
                            color: AppColors.primaryColor,
                            width: 2.w,
                          )
                        : null,
                  ),
                  child: Center(child: badgeIcon),
                ),
                if (showConnector)
                  Expanded(
                    child: Container(
                      width: 2.w,
                      color: connectorColor ?? AppColors.inputBorder,
                    ),
                  ),
              ],
            ),
          ),
          16.horizontalSpace,

          // ── Right Column: Title, Description & Action Content ───────────
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 15.sp,
                          fontWeight: isCompleted || isActive
                              ? FontWeight.w700
                              : FontWeight.w600,
                          color: isCompleted || isActive
                              ? AppColors.primaryColor
                              : AppColors.mutedTextColor,
                          height: 20 / 15,
                        ),
                      ),
                      if (headerRightWidget != null) headerRightWidget!,
                    ],
                  ),
                  4.verticalSpace,
                  Text(
                    description,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: isCompleted || isActive
                          ? AppColors.headerTextColor
                          : AppColors.mutedTextColor,
                      height: 18 / 13,
                    ),
                  ),
                  if (extraContent != null) extraContent!,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
