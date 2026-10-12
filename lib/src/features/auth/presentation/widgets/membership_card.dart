import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({
    super.key,
    required this.childCount,
    required this.price,
    required this.onSelect,
    required this.onComplimentarySelect,
  });

  final int childCount;
  final int price;
  final VoidCallback onSelect;
  final VoidCallback onComplimentarySelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDF4F4),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFC7DFE0),
          width: 1.w,
        ),
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          RichText(
            text: TextSpan(
              text: LangKey.auth.childCountPrefix
                  .tr(args: [childCount.toString()]),
              style: GlobalTextStyles.interTextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
              children: [
                TextSpan(
                  text: LangKey.auth.familyMembershipSuffix,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          8.verticalSpace,
          // Price
          RichText(
            text: TextSpan(
              text: LangKey.auth.priceAed.tr(args: [price.toString()]),
              style: GlobalTextStyles.interTextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
              children: [
                TextSpan(
                  text: LangKey.auth.perMonth,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.brandGrayText,
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,

          // Features List 1
          _FeatureItem(
            assetPath: AppAssets.parentTodayAiAssistant,
            text: LangKey.auth.manageChildMax.tr(args: [childCount.toString()]),
            fontWeight: FontWeight.w600,
          ),
          12.verticalSpace,
          _FeatureItem(
            assetPath: AppAssets.parentTodayAiAssistant,
            text: LangKey.auth.customizedRoutines,
            fontWeight: FontWeight.w600,
          ),
          12.verticalSpace,
          _FeatureItem(
            assetPath: AppAssets.parentTodayAiAssistant,
            text: LangKey.auth.nannyInsights,
            fontWeight: FontWeight.w600,
          ),
          12.verticalSpace,
          _FeatureItem(
            assetPath: AppAssets.parentTodayAiAssistant,
            text: LangKey.auth.uniqueBedtimeStories,
            fontWeight: FontWeight.w600,
          ),

          24.verticalSpace,

          // "WHAT'S INCLUDED" label
          Text(
            LangKey.auth.whatsIncluded,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
              letterSpacing: 1.2,
            ),
          ),
          16.verticalSpace,

          // Features List 2
          _FeatureItem(
            icon: IconsaxPlusLinear.heart,
            text: LangKey.auth.personalisedDailyFlow,
          ),
          12.verticalSpace,
          _FeatureItem(
            icon: IconsaxPlusLinear.location,
            text: LangKey.auth.localActivitySuggestions,
          ),
          12.verticalSpace,
          _FeatureItem(
            icon: IconsaxPlusLinear.user_octagon,
            text: LangKey.auth.careLayers,
          ),
          12.verticalSpace,
          _FeatureItem(
            icon: IconsaxPlusLinear.book,
            text: LangKey.auth.nightlyBedtimeStories,
          ),
          12.verticalSpace,
          _FeatureItem(
            icon: IconsaxPlusLinear.headphone,
            text: LangKey.auth.unlimitedCareAssist,
          ),
          12.verticalSpace,
          _FeatureItem(
            icon: IconsaxPlusLinear.gift,
            text: LangKey.auth.partnerPerks,
          ),

          32.verticalSpace,

          // Button
          SizedBox(
            width: double.infinity,
            child: AppButton(
              onPressed: onSelect,
              isFullWidth: true,
              variant: ButtonVariant.primary,
              label: LangKey.auth.getFamilyMembership
                  .tr(args: [childCount.toString()]),
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          16.verticalSpace,

          // Link
          Center(
            child: InkWell(
              onTap: onComplimentarySelect,
              child: Text(
                LangKey.auth.complimentaryMembership,
                textAlign: TextAlign.center,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    this.icon,
    this.assetPath,
    required this.text,
    this.fontWeight = FontWeight.w400,
  });

  final IconData? icon;
  final String? assetPath;
  final String text;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: assetPath != null
              ? ClipOval(
                  child: Image.asset(
                    assetPath!,
                    width: 16.w,
                    height: 16.w,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(
                  icon,
                  size: 16.w,
                  color: AppColors.primaryColor,
                ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Text(
            text,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 15.sp,
              fontWeight: fontWeight,
              color: AppColors.blackTextColor,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
