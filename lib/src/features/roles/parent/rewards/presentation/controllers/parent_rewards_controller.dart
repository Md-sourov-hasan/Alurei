import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class RewardActivity {
  const RewardActivity({
    required this.title,
    required this.time,
    required this.icon,
    this.isHeart = false,
    this.isLeaf = false,
    this.amount,
    this.isCarrefour = false,
  });

  final String title;
  final String time;
  final IconData icon;
  final bool isHeart;
  final bool isLeaf;
  final String? amount;
  final bool isCarrefour;
}

class WellbeingOffer {
  const WellbeingOffer({
    required this.title,
    required this.description,
    required this.discount,
    required this.icon,
  });

  final String title;
  final String description;
  final String discount;
  final IconData icon;
}

class ParentRewardsController extends GetxController {
  // 0: Earn, 1: Spend
  final RxInt selectedTab = 0.obs;

  // 0: All, 1: Saved
  final RxInt selectedCategoryTab = 0.obs;

  final RxInt balance = 4250.obs;

  final RxList<RewardActivity> recentActivities = <RewardActivity>[
    const RewardActivity(
      title: "Listen Eve's bedtime story",
      time: "2 hours ago",
      icon: IconsaxPlusLinear.book,
    ),
    const RewardActivity(
      title: "Assigned a full-day plan to the nanny",
      time: "Yesterday",
      icon: IconsaxPlusLinear.profile_2user,
    ),
    const RewardActivity(
      title: "Sent appreciation to Maria",
      time: "Yesterday",
      icon: IconsaxPlusLinear.archive_tick,
    ),
    const RewardActivity(
      title: "Completed grocery order from partner",
      time: "Yesterday",
      icon: IconsaxPlusLinear.empty_wallet_tick,
      isLeaf: true,
    ),
    const RewardActivity(
      title: "70%+ Care Score for 7 days",
      time: "Yesterday",
      icon: IconsaxPlusLinear.heart,
      isHeart: true,
    ),
    const RewardActivity(
      title: "Nanny completed assigned care module",
      time: "Yesterday",
      icon: IconsaxPlusLinear.heart,
      isHeart: true,
    ),
    const RewardActivity(
      title: "Read a parent guidance article",
      time: "Yesterday",
      icon: IconsaxPlusLinear.document,
    ),
    const RewardActivity(
      title: "Switch to annual billing",
      time: "Yesterday",
      icon: IconsaxPlusLinear.document,
    ),
  ].obs;

  final RxList<RewardActivity> recentSpentActivities = <RewardActivity>[
    const RewardActivity(
      title: "Redeemed Carrefour Voucher",
      time: "2 hours ago",
      icon: IconsaxPlusLinear.ticket,
      amount: "-100 Alurei",
      isCarrefour: true,
    ),
    const RewardActivity(
      title: "Redeemed Carrefour Voucher",
      time: "2 hours ago",
      icon: IconsaxPlusLinear.ticket,
      amount: "-5 Alurei",
      isCarrefour: true,
    ),
    const RewardActivity(
      title: "Redeemed Carrefour Voucher",
      time: "2 hours ago",
      icon: IconsaxPlusLinear.ticket,
      amount: "-5 Alurei",
      isCarrefour: true,
    ),
    const RewardActivity(
      title: "Redeemed Carrefour Voucher",
      time: "2 hours ago",
      icon: IconsaxPlusLinear.ticket,
      amount: "-5 Alurei",
      isCarrefour: true,
    ),
    const RewardActivity(
      title: "Redeemed Carrefour Voucher",
      time: "2 hours ago",
      icon: IconsaxPlusLinear.ticket,
      amount: "-5 Alurei",
      isCarrefour: true,
    ),
    const RewardActivity(
      title: "Redeemed Carrefour Voucher",
      time: "2 hours ago",
      icon: IconsaxPlusLinear.ticket,
      amount: "-5 Alurei",
      isCarrefour: true,
    ),
    const RewardActivity(
      title: "Redeemed Carrefour Voucher",
      time: "2 hours ago",
      icon: IconsaxPlusLinear.ticket,
      amount: "-5 Alurei",
      isCarrefour: true,
    ),
    const RewardActivity(
      title: "Redeemed Carrefour Voucher",
      time: "2 hours ago",
      icon: IconsaxPlusLinear.ticket,
      amount: "-5 Alurei",
      isCarrefour: true,
    ),
  ].obs;

  final RxList<WellbeingOffer> wellbeingOffers = <WellbeingOffer>[
    const WellbeingOffer(
      title: "Serenity Spa",
      description: "Holistic wellness & massage",
      discount: "20% OFF",
      icon: IconsaxPlusLinear.sun,
    ),
    const WellbeingOffer(
      title: "Serenity Spa",
      description: "Holistic wellness & massage",
      discount: "20% OFF",
      icon: IconsaxPlusLinear.cup,
    ),
    const WellbeingOffer(
      title: "Serenity Spa",
      description: "Holistic wellness & massage",
      discount: "20% OFF",
      icon: IconsaxPlusLinear.sun,
    ),
  ].obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeCategoryTab(int index) {
    selectedCategoryTab.value = index;
  }
}
