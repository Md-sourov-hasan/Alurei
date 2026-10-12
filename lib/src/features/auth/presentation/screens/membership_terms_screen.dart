import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

class MembershipTermsScreen extends StatelessWidget {
  const MembershipTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primaryColor,
          onPressed: () => Get.back<dynamic>(),
        ),
        title: Text(
          LangKey.auth.membershipTerms,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.headerTextColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSmallText(LangKey.auth.lastUpdated),
            24.verticalSpace,
            _buildHeading(LangKey.auth.alureiMembershipTermsAndConditions),
            24.verticalSpace,
            _buildHeading(LangKey.auth.aboutAlureiTitle),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.aboutAlureiDesc1.tr()),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.aboutAlureiDesc2.tr()),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.aboutAlureiDesc3.tr()),
            24.verticalSpace,
            _buildHeading(LangKey.auth.redeemingAlureiTitle),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.redeemingAlureiDesc1.tr()),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.redeemingAlureiDesc2.tr()),
            24.verticalSpace,
            _buildHeading(LangKey.auth.membershipBenefitsTitle),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.membershipBenefitsDesc),
            24.verticalSpace,
            _buildHeading(LangKey.auth.usingAlureiTitle),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.usingAlureiPoint1.tr()),
            4.verticalSpace,
            _buildParagraph(LangKey.auth.usingAlureiPoint2.tr()),
            4.verticalSpace,
            _buildParagraph(LangKey.auth.usingAlureiPoint3.tr()),
            4.verticalSpace,
            _buildParagraph(LangKey.auth.usingAlureiPoint4.tr()),
            4.verticalSpace,
            _buildParagraph(LangKey.auth.usingAlureiPoint5.tr()),
            24.verticalSpace,
            _buildHeading(LangKey.auth.expirationTitle),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.expirationDesc),
            24.verticalSpace,
            _buildHeading(LangKey.auth.membershipStatusTitle),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.membershipStatusDesc),
            24.verticalSpace,
            _buildHeading(LangKey.auth.fairUseTitle),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.fairUseDesc),
            24.verticalSpace,
            _buildHeading(LangKey.auth.changesToTheProgramTitle),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.changesToTheProgramDesc),
            24.verticalSpace,
            _buildHeading(LangKey.auth.needHelpTitle),
            12.verticalSpace,
            _buildParagraph(LangKey.auth.needHelpDesc),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildSmallText(String text) {
    return Text(
      text,
      style: GlobalTextStyles.interTextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.brandGrayText,
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Text(
      text,
      style: GlobalTextStyles.interTextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: GlobalTextStyles.interTextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.blackTextColor,
        height: 1.5,
      ),
    );
  }
}
