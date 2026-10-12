import 'package:alurei/src/features/roles/parent/my_offer/presentation/controllers/my_offer_controller.dart';
import 'package:alurei/src/imports/imports.dart';
import 'redeem_offer_bottom_sheet.dart';

class MyOfferDetailsRedeemBottomBar extends StatelessWidget {
  const MyOfferDetailsRedeemBottomBar({
    super.key,
    required this.offer,
  });

  final RewardOffer offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.black12,
            blurRadius: 8.r,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: AppButton(
          label: LangKey.parentMyOffer.redeemOffer,
          isFullWidth: true,
          onPressed: () {
            HapticFeedback.selectionClick();
            context.showAppBottomSheet(
              builder: (context) => RedeemOfferBottomSheet(offer: offer),
            );
          },
        ),
      ),
    );
  }
}
