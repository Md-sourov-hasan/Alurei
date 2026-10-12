import 'package:alurei/src/imports/imports.dart';

import '../controllers/payment_method_controller.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentMethodController());

    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.parentKitchen.paymentMethodTitle,
        titleColor: AppColors.headerTextColor,
        showBackButton: true,
        showDivider: false,
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
                    Obx(() => Column(
                      children: [
                        _buildSavedCard(
                          context: context,
                          title: LangKey.parentKitchen.mastercardLabel,
                          isDefault: controller.defaultCardIndex.value == 0,
                          isSelected: controller.defaultCardIndex.value == 0,
                          onTap: () => controller.setDefaultCard(0),
                        ),
                        12.verticalSpace,
                        _buildSavedCard(
                          context: context,
                          title: LangKey.parentKitchen.mastercardLabel,
                          isDefault: controller.defaultCardIndex.value == 1,
                          isSelected: controller.defaultCardIndex.value == 1,
                          onTap: () => controller.setDefaultCard(1),
                        ),
                      ],
                    )),
                    32.verticalSpace,
                    Text(
                      LangKey.parentKitchen.addNewPaymentMethod,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackTextColor,
                        height: 28 / 18,
                      ),
                    ),
                    16.verticalSpace,
                    _buildAddNewCardForm(controller),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedCard({
    required BuildContext context,
    required String title,
    required bool isDefault,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.brandLogoLight : context.appColors.primaryBackground,
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : AppColors.brandGrayBorder,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Icon(
            IconsaxPlusLinear.card,
            size: 20.w,
            color: context.appColors.primaryText,
          ),
          12.horizontalSpace,
          Expanded(
            child: Text(
              title,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: context.appColors.primaryText,
                height: 24 / 16,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isDefault ? AppColors.groceryWarningOrange : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(999.r),
              ),
              child: Text(
                isDefault ? 'Remove default' : 'Set as default',
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                  height: 18 / 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewCardForm(PaymentMethodController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.brandLogoLight, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w, bottom: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            label: LangKey.parentKitchen.cardNumberLabel,
            hint: LangKey.parentKitchen.cardNumberHint,
            controller: controller.cardNumberController,
            suffixIcon: Icon(
              IconsaxPlusLinear.card,
              size: 20.w,
              color: AppColors.textHintColor,
            ),
          ),
          24.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: LangKey.parentKitchen.expiryDateLabel,
                  hint: LangKey.parentKitchen.expiryDateHint,
                  controller: controller.expiryDateController,
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: AppTextField(
                  label: LangKey.parentKitchen.cvvLabel,
                  hint: LangKey.parentKitchen.cvvHint,
                  controller: controller.cvvController,
                ),
              ),
            ],
          ),
          24.verticalSpace,
          AppTextField(
            label: LangKey.parentKitchen.cardholderNameLabel,
            hint: LangKey.parentKitchen.cardholderNameHint,
            controller: controller.cardholderNameController,
          ),
          24.verticalSpace,
          AppButton(
            label: 'Save Card Details',
            variant: ButtonVariant.primary,
            isFullWidth: true,
            height: ButtonSize.medium,
            onPressed: controller.onConfirmOrder,
          ),
        ],
      ),
    );
  }
}
