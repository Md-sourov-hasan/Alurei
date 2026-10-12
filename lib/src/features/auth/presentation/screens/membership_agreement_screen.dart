import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

class MembershipAgreementScreen extends HookWidget {
  const MembershipAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final agreedToTerms = useState(false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LangKey.auth.everythingYouNeedToKnow,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    24.verticalSpace,

                    // Banner Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.asset(
                        AppAssets.agreementBg,
                        width: double.infinity,
                        height: 160.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    16.verticalSpace,

                    Text(
                      LangKey.auth.earnRewardsWhileCaring,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      LangKey.auth.earnRewardsDesc,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackTextColor,
                        height: 1.5,
                      ),
                    ),
                    32.verticalSpace,

                    // How Alurei Works
                    Text(
                      LangKey.auth.howAlureiWorks,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    16.verticalSpace,
                    _buildHowItWorksItem(
                      icon: IconsaxPlusLinear.heart,
                      title: LangKey.auth.everydayCare,
                      desc: LangKey.auth.everydayCareDesc,
                    ),
                    12.verticalSpace,
                    _buildHowItWorksItem(
                      icon: IconsaxPlusLinear.coin,
                      title: LangKey.auth.earnAlureiTitle,
                      desc: LangKey.auth.earnAlureiDesc,
                    ),
                    12.verticalSpace,
                    _buildHowItWorksItem(
                      icon: IconsaxPlusLinear.shop,
                      title: LangKey.auth.redeemWithPartners,
                      desc: LangKey.auth.redeemWithPartnersDesc,
                    ),
                    32.verticalSpace,

                    // Your Membership Includes
                    Text(
                      LangKey.auth.yourMembershipIncludes,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    16.verticalSpace,
                    _buildCheckItem(
                        LangKey.auth.aiPoweredChildcarePlanning),
                    12.verticalSpace,
                    _buildCheckItem(LangKey.auth.weeklyChildInsights),
                    12.verticalSpace,
                    _buildCheckItem(LangKey.auth.nannyCollaboration),
                    12.verticalSpace,
                    _buildCheckItem(LangKey.auth.careModulesForNannies),
                    12.verticalSpace,
                    _buildCheckItem(LangKey.auth.bedtimeStories),
                    12.verticalSpace,
                    _buildCheckItem(LangKey.auth.exclusivePartnerOffers),
                    12.verticalSpace,
                    _buildCheckItem(LangKey.auth.rewardsThroughAlurei),
                    32.verticalSpace,

                    // Things to Know
                    Text(
                      LangKey.auth.thingsToKnow,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    16.verticalSpace,
                    _buildCheckItem(LangKey.auth.alureiLoyaltyReward),
                    12.verticalSpace,
                    _buildCheckItem(
                        LangKey.auth.alureiCannotBeTransferred),
                    12.verticalSpace,
                    _buildCheckItem(LangKey.auth.alureiCanBeRedeemedOnly),
                    12.verticalSpace,
                    _buildCheckItem(LangKey.auth.partnerOffersMayVary),
                    12.verticalSpace,
                    _buildCheckItem(LangKey
                        .auth.membershipBenefitsActiveWhileGoodStanding
                        .tr()),
                    32.verticalSpace,

                    // Membership Agreement
                    Text(
                      LangKey.auth.membershipAgreement,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    8.verticalSpace,
                    RichText(
                      text: TextSpan(
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackTextColor,
                          height: 1.5,
                        ),
                        children: const [
                          TextSpan(text: 'By joining, you agree to our '),
                          TextSpan(
                            text: 'Membership Terms',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ', '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ', and '),
                          TextSpan(
                            text: 'Partner Terms',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                              text:
                                  '. These documents outline how your data is handled and the specific rules governing rewards and benefits.'),
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    _buildCheckbox(agreedToTerms),
                    32.verticalSpace,
                  ],
                ),
              ),
            ),

            // Bottom Button
            Padding(
              padding: EdgeInsets.all(24.w),
              child: AppButton(
                onPressed: agreedToTerms.value
                    ? () {
                        Get.toNamed<dynamic>(AppRoutes.submitDocuments);
                      }
                    : null,
                isFullWidth: true,
                variant: ButtonVariant.primary,
                label: LangKey.auth.continueToPayment,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorksItem({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8F8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withValues(alpha: 0.1),
            ),
            child: Icon(
              icon,
              size: 20.w,
              color: AppColors.primaryColor,
            ),
          ),
          12.verticalSpace,
          Text(
            title,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          4.verticalSpace,
          Text(
            desc,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.blackTextColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Icon(
            IconsaxPlusLinear.tick_circle,
            size: 18.w,
            color: AppColors.primaryColor,
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Text(
            text,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.blackTextColor,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox(ValueNotifier<bool> agreed) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8F8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => agreed.value = !agreed.value,
            child: Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: agreed.value
                      ? AppColors.primaryColor
                      : const Color(0xFF94ADAD),
                  width: 1.5.w,
                ),
                borderRadius: BorderRadius.circular(6.r),
                color: agreed.value ? AppColors.primaryColor : Colors.white,
              ),
              child: agreed.value
                  ? Icon(Icons.check, size: 16.w, color: Colors.white)
                  : null,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Text(
              LangKey.auth.iHaveReadAndAgree,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blackTextColor,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
