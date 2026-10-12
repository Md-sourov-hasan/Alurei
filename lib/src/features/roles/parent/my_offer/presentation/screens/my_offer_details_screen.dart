import 'package:alurei/src/features/roles/parent/my_offer/presentation/controllers/my_offer_controller.dart';
import 'package:alurei/src/imports/imports.dart';
import '../widgets/my_offer_details_hero_card.dart';
import '../widgets/my_offer_details_locations.dart';
import '../widgets/my_offer_details_redeem_bottom_bar.dart';
import '../widgets/my_offer_details_terms.dart';
import '../widgets/my_offer_details_whats_included.dart';

class MyOfferDetailsScreen extends HookWidget {
  const MyOfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offer = Get.arguments as RewardOffer?;
    final isTermsExpanded = useState(true);

    // Fallback dummy offer if navigating without arguments
    final displayOffer = offer ??
        RewardOffer(
          id: '1',
          partnerName: 'Serenity Spa',
          title: 'Grab 25% discount with 300 ALR',
          pointsRequired: 300,
          expiryDate: 'Expires Jan 20, 2025',
          imageUrl: AppAssets.rewardItem,
          partnerIcon: IconsaxPlusLinear.sun,
          isSaved: false,
          hasSufficientBalance: true,
        );

    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.parentMyOffer.offerDetails,
        titleColor: AppColors.headerTextColor,
        showBackButton: true,
        showDivider: false,
        onPressed: () => Get.back<void>(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 12.h,
              bottom: 100.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Hero Banner Card ─────────────────────────────────────────
                MyOfferDetailsHeroCard(offer: displayOffer),

                24.verticalSpace,

                // ── What's Included Section ──────────────────────────────────
                MyOfferDetailsWhatsIncluded(offer: displayOffer),

                24.verticalSpace,

                // ── Terms & Conditions Accordion ──────────────────────────────
                MyOfferDetailsTerms(isExpanded: isTermsExpanded),

                24.verticalSpace,

                // ── Available Locations Section ─────────────────────────────
                const MyOfferDetailsLocations(),
              ],
            ),
          ),

          // ── Bottom Redeem Button Overlay ──────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: MyOfferDetailsRedeemBottomBar(offer: displayOffer),
          ),
        ],
      ),
    );
  }
}
