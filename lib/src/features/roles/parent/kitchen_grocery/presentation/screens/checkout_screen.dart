import 'package:alurei/src/imports/imports.dart';
import '../controllers/checkout_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());

    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.parentKitchen.myOrder,
        titleColor: AppColors.primaryColor,
        showBackButton: true,
        showDivider: true,
        onPressed: () => Get.back<void>(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Partner & Order Info ─────────────────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AppAssets.icStore,
                          width: 20.w,
                          height: 20.w,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: Text(
                            '${LangKey.parentKitchen.checkoutStoreLabel}: Carrefour Market',
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              height: 24 / 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Text(
                      '${LangKey.parentKitchen.checkoutOrderId}: #AL-99824-V',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mutedTextColor,
                        height: 20 / 14,
                      ),
                    ),
                    24.verticalSpace,

                    // ── Item List Card ───────────────────────────────────────
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LangKey.parentKitchen.checkoutVoucherItems,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.headerTextColor,
                              height: 24 / 16,
                            ),
                          ),
                          16.verticalSpace,
                          _buildItemRow(
                              'Organic Whole Milk', '2 Liters', r'$12.50'),
                          _buildItemRow('Fresh Spinach', '200g', r'$8.40'),
                          _buildItemRow(
                              'Eco-Friendly Diapers', '1 Unit', r'$24.99',
                              isLast: true),
                        ],
                      ),
                    ),
                    24.verticalSpace,

                    // ── Price Summary Card ───────────────────────────────────
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        children: [
                          _buildSummaryRow(
                              LangKey.parentKitchen.checkoutSubtotal,
                              r'$45.89'),
                          12.verticalSpace,
                          _buildSummaryRow(
                            LangKey.parentKitchen.checkoutOnlineDiscount,
                            r'- $2.29',
                            titleColor: AppColors.primaryColor,
                            valueColor: AppColors.primaryColor,
                            titleWeight: FontWeight.w700,
                            valueWeight: FontWeight.w600,
                          ),
                          12.verticalSpace,
                          _buildSummaryRow(
                              LangKey.parentKitchen.checkoutDeliveryFee,
                              r'$2.50'),
                          16.verticalSpace,
                          Container(
                            padding: EdgeInsets.only(top: 16.h),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: AppColors.dividerColor,
                                  width: 1.w,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LangKey.parentKitchen.checkoutTotal,
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.headerTextColor,
                                    height: 30 / 20,
                                  ),
                                ),
                                Text(
                                  r'$46.10',
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                    height: 32 / 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.verticalSpace,

                    // ── Payment Selection ────────────────────────────────────
                    Text(
                      LangKey.parentKitchen.checkoutPaymentMethod,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyTextColor,
                        height: 24 / 16,
                      ),
                    ),
                    12.verticalSpace,
                    Obx(() => Column(
                          children: [
                            _buildPaymentMethodOption(
                              context: context,
                              index: 0,
                              title: LangKey.parentKitchen.checkoutPayNowOnline,
                              subtitle: LangKey
                                  .parentKitchen.checkoutSecureCreditCard,
                              isSelected:
                                  controller.selectedPaymentMethod.value == 0,
                              onTap: () => controller.selectPaymentMethod(0),
                            ),
                            12.verticalSpace,
                            _buildPaymentMethodOption(
                              context: context,
                              index: 1,
                              title:
                                  LangKey.parentKitchen.checkoutCashOnDelivery,
                              subtitle: LangKey
                                  .parentKitchen.checkoutPayWhenOrderArrives,
                              isSelected:
                                  controller.selectedPaymentMethod.value == 1,
                              onTap: () => controller.selectPaymentMethod(1),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),

            // ── Fixed Bottom Action Button ───────────────────────────────────
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
              decoration: BoxDecoration(
                color: context.appColors.primaryBackground,
              ),
              child: Obx(
                () => AppButton(
                  label: controller.selectedPaymentMethod.value == 0
                      ? LangKey.parentKitchen.checkoutPayNow
                      : LangKey.parentKitchen.checkoutConfirmOrder,
                  variant: ButtonVariant.primary,
                  isFullWidth: true,
                  onPressed: () {
                    if (controller.selectedPaymentMethod.value == 0) {
                      controller.onPayNow();
                    } else {
                      controller.onConfirmOrder();
                    }
                  },
                  height: ButtonSize.large,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(String title, String subtitle, String price,
      {bool isLast = false}) {
    return Container(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: AppColors.dividerColor,
                  width: 1.w,
                ),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headerTextColor,
                    height: 24 / 16,
                  ),
                ),
                4.verticalSpace,
                Text(
                  subtitle,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mutedTextColor,
                    height: 18 / 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.headerTextColor,
              height: 24 / 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String title,
    String value, {
    Color? titleColor,
    Color? valueColor,
    FontWeight? titleWeight,
    FontWeight? valueWeight,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 16.sp,
            fontWeight: titleWeight ?? FontWeight.w400,
            color: titleColor ?? AppColors.headerTextColor,
            height: 24 / 16,
          ),
        ),
        Text(
          value,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 16.sp,
            fontWeight: valueWeight ?? FontWeight.w400,
            color: valueColor ?? AppColors.bodyTextColor,
            height: 24 / 16,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption({
    required BuildContext context,
    required int index,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withValues(alpha: 0.05)
              : AppColors.whiteColor,
          border: isSelected
              ? Border.all(color: AppColors.primaryColor, width: 1.w)
              : Border.all(color: Colors.transparent, width: 1.w),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.headerTextColor,
                      height: 28 / 18,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    subtitle,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.mutedTextColor,
                      height: 18 / 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primaryColor,
                size: 24.w,
              )
            else
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.inputBorder,
                    width: 1.5.w,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
