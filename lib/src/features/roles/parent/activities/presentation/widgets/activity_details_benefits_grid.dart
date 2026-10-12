import 'package:alurei/src/imports/imports.dart';

class ActivityDetailsBenefitsGrid extends StatelessWidget {
  const ActivityDetailsBenefitsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildBenefitCard(
                title: LangKey.parentActivities.benefitSocial.tr(),
                subtitle: LangKey.parentActivities.benefitSocialSub.tr(),
                svgPath: AppAssets.icSocial,
                iconBgColor: const Color(0xFFE1F1F1),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: _buildBenefitCard(
                title: LangKey.parentActivities.benefitCognitive.tr(),
                subtitle: LangKey.parentActivities.benefitCognitiveSub.tr(),
                svgPath: AppAssets.icCognitive,
                iconBgColor: const Color(0xFFE0F7F6),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildBenefitCard(
                title: LangKey.parentActivities.benefitEmotional.tr(),
                subtitle: LangKey.parentActivities.benefitEmotionalSub.tr(),
                svgPath: AppAssets.icEmotional,
                iconBgColor: const Color(0xFFFCEAE8),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: _buildBenefitCard(
                title: LangKey.parentActivities.benefitPhysical.tr(),
                subtitle: LangKey.parentActivities.benefitPhysicalSub.tr(),
                svgPath: AppAssets.icPhysical,
                iconBgColor: const Color(0xFFE1F1F1),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBenefitCard({
    required String title,
    required String subtitle,
    IconData? icon,
    String? svgPath,
    Color iconBgColor = const Color(0xFFE1F1F1),
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE4EAEA)),
        boxShadow: AppShadows.subtle,
      ),
      child: Column(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: svgPath != null
                  ? SvgPicture.asset(
                      svgPath,
                      width: 22.w,
                      height: 22.w,
                    )
                  : Icon(
                      icon,
                      size: 22.w,
                      color: const Color(0xFF004D54),
                    ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF003D45),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 11.5.sp,
              height: 1.35,
              color: const Color(0xFF586B6D),
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
