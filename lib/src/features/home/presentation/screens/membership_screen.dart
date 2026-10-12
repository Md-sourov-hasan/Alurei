import 'package:alurei/src/imports/imports.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.membership.membership,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentPlanCard(context),
            SizedBox(height: 24.h),
            _buildPaymentMethod(context),
            SizedBox(height: 24.h),
            _buildBillingHistory(context),
            SizedBox(height: 32.h),
            _buildSwitchAnnualBilling(context),
            SizedBox(height: 24.h),
            _buildSupportCenter(context),
            SizedBox(height: 32.h),
            AppButton(
              label: LangKey.membership.pauseSubscriptions,
              onPressed: () => Get.toNamed<dynamic>(AppRoutes.pauseMembership),
              variant: ButtonVariant.primary,
              isFullWidth: true,
            ),
            SizedBox(height: 16.h),
            Center(
              child: TextButton(
                onPressed: () =>
                    Get.toNamed<dynamic>(AppRoutes.cancelMembership),
                child: Text(
                  LangKey.membership.cancelMembership,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: context.colors.error,
                  ),
                ),
              ),
            ),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPlanCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LangKey.membership.currentPlan,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.appColors.secondaryText,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: context.appColors.success,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  LangKey.membership.active,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            LangKey.parentHome.childMembershipCount,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          RichText(
            text: TextSpan(
              text: '19 ',
              style: context.textTheme.headlineMedium?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                  text:
                      '${LangKey.parentHome.currencyAed} / ${LangKey.parentHome.perMonth}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(
                IconsaxPlusLinear.calendar,
                size: 16.w,
                color: context.appColors.secondaryText,
              ),
              SizedBox(width: 8.w),
              Text(
                'Next billing: Oct 12, 2023',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.appColors.secondaryText,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          AppButton(
            label: LangKey.membership.changePlan,
            onPressed: () {},
            variant: ButtonVariant.outline,
            isFullWidth: true,
            textColor: context.colors.primary,
            borderColor: context.colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangKey.membership.paymentMethod,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.brandTealTrack.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            children: [
              Icon(
                IconsaxPlusLinear.card,
                color: context.colors.onSurface,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Mastercard 4421',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.brandTealTrack.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  LangKey.membership.defaultLabel,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () => Get.toNamed<dynamic>(AppRoutes.paymentMethod),
                child: Text(
                  LangKey.membership.manage,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBillingHistory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                LangKey.membership.billingHistory,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              child: Text(
                LangKey.membership.showingLastMonths,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.appColors.secondaryText,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              _buildBillingItem(
                context,
                isFailed: true,
                title: LangKey.parentHome.childMembershipCount,
                date: 'Oct 12, 2023',
                price: '99.00 AED',
              ),
              AppDivider(height: 24.h),
              _buildBillingItem(
                context,
                isFailed: false,
                title: LangKey.parentHome.childMembershipCount,
                date: 'Sep 12, 2023',
                price: '99.00 AED',
              ),
              AppDivider(height: 24.h),
              _buildBillingItem(
                context,
                isFailed: false,
                title: LangKey.parentHome.childMembershipCount,
                date: 'Sep 12, 2023',
                price: '99.00 AED',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBillingItem(
    BuildContext context, {
    required bool isFailed,
    required String title,
    required String date,
    required String price,
  }) {
    final statusColor =
        isFailed ? context.colors.error : context.appColors.success;
    final statusBgColor = isFailed
        ? context.colors.error.withValues(alpha: 0.1)
        : context.appColors.success.withValues(alpha: 0.1);
    final statusText =
        isFailed ? LangKey.membership.failed : LangKey.membership.paid;

    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: statusBgColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            isFailed
                ? IconsaxPlusLinear.card_slash
                : IconsaxPlusLinear.money_tick,
            color: statusColor,
            size: 20.w,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                date,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.appColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              price,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: statusBgColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                statusText,
                style: context.textTheme.labelSmall?.copyWith(
                  color: statusColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitchAnnualBilling(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangKey.membership.switchAnnualBilling,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            color: context.colors.primary,
            child: Stack(
              children: [
                Positioned(
                  top: -20.w,
                  right: -20.w,
                  child: Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            IconsaxPlusBold.star,
                            size: 80.w,
                            color: Colors.black.withValues(alpha: 0.05),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${LangKey.parentHome.currencyAed} 499',
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                LangKey.parentHome.perYear,
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LangKey.membership.familyPlus,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      _buildBenefitRow(
                          context, LangKey.membership.saveAnnualBilling),
                      SizedBox(height: 8.h),
                      _buildBenefitRow(
                          context, LangKey.membership.prioritySupport),
                      SizedBox(height: 24.h),
                      AppButton(
                        label: LangKey.membership.upgradeFamilyPlus,
                        onPressed: () {},
                        color: Colors.white,
                        textColor: context.colors.primary,
                        isFullWidth: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitRow(BuildContext context, String text) {
    return Row(
      children: [
        Icon(
          IconsaxPlusLinear.tick_circle,
          color: Colors.white,
          size: 16.w,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupportCenter(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        color: Colors.white,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4.w,
                color: context.colors.primary,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Icon(
                              IconsaxPlusLinear.headphone,
                              color: context.colors.primary,
                              size: 24.w,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LangKey.membership.needHelp,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  LangKey.membership.supportDesc,
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: context.appColors.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                IconsaxPlusLinear.info_circle,
                                color: context.colors.primary,
                                size: 16.w,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                LangKey.membership.supportCenter,
                                style: context.textTheme.labelLarge?.copyWith(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.w600,
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
            ],
          ),
        ),
      ),
    );
  }
}
