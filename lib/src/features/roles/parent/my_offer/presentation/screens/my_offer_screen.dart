import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_offer_controller.dart';
import '../widgets/my_offer_bottom_banner.dart';
import '../widgets/my_offer_card.dart';
import '../widgets/my_offer_tab_bar.dart';

class MyOfferScreen extends StatelessWidget {
  const MyOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyOfferController());

    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: 'Alurei Rewards',
        titleColor: AppColors.primaryColor,
        showBackButton: true,
        showDivider: true,
        onPressed: () => Get.back<void>(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Category Selector Tabs ("All" & "Saved") ──────────────────
              MyOfferTabBar(controller: controller),

              16.verticalSpace,

              // ── Offers List ───────────────────────────────────────────────
              Obx(() {
                final offersList = controller.filteredOffers;

                if (offersList.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Center(
                      child: Text(
                        controller.selectedCategoryTab.value == 1
                            ? 'No saved offers yet.'
                            : 'No offers available.',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          color: AppColors.mutedTextColor,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: offersList.length,
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  itemBuilder: (context, index) {
                    final offer = offersList[index];
                    return MyOfferCard(
                      offer: offer,
                      onToggleSave: () => controller.toggleSaveOffer(offer.id),
                      onRedeem: () {
                        Get.toNamed<void>(
                          AppRoutes.myOfferDetails,
                          arguments: offer,
                        );
                      },
                      onViewDetails: () {
                        Get.toNamed<void>(
                          AppRoutes.myOfferDetails,
                          arguments: offer,
                        );
                      },
                    );
                  },
                );
              }),

              24.verticalSpace,

              // ── Bottom Message Banner ──────────────────────────────────────
              Obx(() {
                if (!controller.showBottomBanner.value) {
                  return const SizedBox.shrink();
                }
                return const MyOfferBottomBanner();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
