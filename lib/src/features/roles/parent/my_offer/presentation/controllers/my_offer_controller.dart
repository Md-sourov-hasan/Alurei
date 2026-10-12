import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class RewardOffer {
  RewardOffer({
    required this.id,
    required this.partnerName,
    required this.title,
    required this.pointsRequired,
    required this.expiryDate,
    this.imageUrl,
    this.partnerIcon = IconsaxPlusLinear.element_3,
    bool isSaved = false,
    this.hasSufficientBalance = true,
  }) : isSaved = isSaved.obs;

  final String id;
  final String partnerName;
  final String title;
  final int pointsRequired;
  final String expiryDate;
  final String? imageUrl;
  final IconData partnerIcon;
  final RxBool isSaved;
  final bool hasSufficientBalance;
}

class MyOfferController extends GetxController {
  // 0: All, 1: Saved
  final RxInt selectedCategoryTab = 0.obs;

  // Bottom Toast Banner
  final RxBool showBottomBanner = true.obs;

  // List of Offers according to Figma V2 design (node 23315-53359)
  final RxList<RewardOffer> offers = <RewardOffer>[
    RewardOffer(
      id: '1',
      partnerName: 'Serenity Spa',
      title: 'Grab 25% discount with 300 Alurei',
      pointsRequired: 300,
      expiryDate: 'Expires Jan 20, 2025',
      imageUrl: AppAssets.rewardItem,
      partnerIcon: IconsaxPlusLinear.sun,
      isSaved: true,
      hasSufficientBalance: true,
    ),
    RewardOffer(
      id: '2',
      partnerName: 'Serenity Spa',
      title: 'Grab 25% discount with 300 Alurei',
      pointsRequired: 300,
      expiryDate: 'Expires Jan 20, 2025',
      imageUrl: AppAssets.rewardItem,
      partnerIcon: IconsaxPlusLinear.sun,
      isSaved: true,
      hasSufficientBalance: false, // Displays red badge for insufficient balance
    ),
    RewardOffer(
      id: '3',
      partnerName: 'Serenity Spa',
      title: 'Grab 25% discount with 300 Alurei',
      pointsRequired: 300,
      expiryDate: 'Expires Jan 20, 2025',
      imageUrl: AppAssets.rewardItem,
      partnerIcon: IconsaxPlusLinear.sun,
      isSaved: false,
      hasSufficientBalance: true,
    ),
    RewardOffer(
      id: '4',
      partnerName: 'Serenity Spa',
      title: 'Grab 25% discount with 300 Alurei',
      pointsRequired: 300,
      expiryDate: 'Expires Jan 20, 2025',
      imageUrl: AppAssets.rewardItem,
      partnerIcon: IconsaxPlusLinear.sun,
      isSaved: false,
      hasSufficientBalance: true,
    ),
  ].obs;

  List<RewardOffer> get filteredOffers {
    if (selectedCategoryTab.value == 1) {
      return offers.where((offer) => offer.isSaved.value).toList();
    }
    return offers;
  }

  void changeCategoryTab(int index) {
    selectedCategoryTab.value = index;
  }

  void toggleSaveOffer(String id) {
    final offer = offers.firstWhereOrNull((item) => item.id == id);
    if (offer != null) {
      offer.isSaved.toggle();
    }
  }

  void hideBanner() {
    showBottomBanner.value = false;
  }
}
