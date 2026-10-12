import 'package:alurei/src/features/roles/parent/my_offer/presentation/controllers/my_offer_controller.dart';
import 'package:alurei/src/imports/imports.dart';

class RedeemOfferSuccessScreen extends StatelessWidget {
  const RedeemOfferSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offer = Get.arguments as RewardOffer?;
    final points = offer?.pointsRequired ?? 300;

    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.parentMyOffer.offerDetails,
        titleColor: AppColors.headerTextColor,
        showBackButton: true,
        showDivider: false,
        onPressed: () => Get.back<void>(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(),

              // Success Illustration
              SvgPicture.asset(
                AppAssets.passwordSuccess,
                width: 160.w,
                height: 160.w,
              ),

              32.verticalSpace,

              // Heading
              Text(
                'Offer Redeemed Successfully',
                textAlign: TextAlign.center,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B5460),
                ),
              ),

              12.verticalSpace,

              // Subtitle
              Text(
                "You've successfully redeemed $points ALR.",
                textAlign: TextAlign.center,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF364152),
                ),
              ),

              40.verticalSpace,

              // Primary Actions
              AppButton(
                label: 'Back to home',
                isFullWidth: true,
                color: const Color(0xFF0B5460),
                onPressed: () => Get.offAllNamed<void>(AppRoutes.main),
              ),

              16.verticalSpace,

              AppButton(
                label: 'Visit my rewards',
                isFullWidth: true,
                variant: ButtonVariant.outline,
                textColor: const Color(0xFF009E9E),
                borderColor: const Color(0xFF009E9E),
                onPressed: () {
                  Get.offAllNamed<void>(AppRoutes.main);
                  Get.toNamed<void>(AppRoutes.rewards);
                },
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
