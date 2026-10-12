import 'package:alurei/src/features/roles/parent/my_offer/presentation/screens/my_offer_screen.dart';
import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_rewards_controller.dart';

class ParentRewardsScreen extends StatelessWidget {
  const ParentRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ParentRewardsController());

    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title:
            '${LangKey.parentRewards.alureiUnit} ${LangKey.parentHome.rewards}',
        titleColor: AppColors.primaryColor,
        showBackButton: true,
        showDivider: true,
        onPressed: () => Get.back<void>(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Available Balance Card ─────────────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.rewardCardGradientStart,
                      AppColors.rewardCardGradientEnd,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LangKey.parentRewards.availableBalance,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.whiteColor.withOpacity(0.9),
                              ),
                            ),
                            4.verticalSpace,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Obx(() => Text(
                                      controller.balance.value
                                          .toString()
                                          .replaceAllMapped(
                                            RegExp(
                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                            (Match m) => '${m[1]},',
                                          ),
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 36.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.brandGrayLight,
                                        letterSpacing: -0.72.w,
                                      ),
                                    )),
                                4.horizontalSpace,
                                Text(
                                  LangKey.parentRewards.alureiUnit,
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.brandGrayLight
                                        .withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Opacity(
                          opacity: 0.5,
                          child: Container(
                            width: 66.w,
                            height: 66.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor.withOpacity(0.15),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Transform.scale(
                              scale: 1.2,
                              child: Image.asset(
                                AppAssets.imgKitchenChatbot,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    AppButton(
                      label: LangKey.parentRewards.useCareMoments,
                      variant: ButtonVariant.primary,
                      color: AppColors.whiteColor,
                      textColor: AppColors.rewardCardGradientEnd,
                      isFullWidth: true,
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        Get.to(() => const MyOfferScreen());
                      },
                    ),
                  ],
                ),
              ),
              24.verticalSpace,

              // ── Wellbeing Section ──────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LangKey.parentRewards.yourWellbeing,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.headerTextColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      Get.to(() => const MyOfferScreen());
                    },
                    child: Row(
                      children: [
                        Text(
                          LangKey.parentRewards.visitAllOffers,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.voucherBadgeBg,
                          ),
                        ),
                        Icon(
                          IconsaxPlusLinear.arrow_right_1,
                          size: 12.w,
                          color: AppColors.voucherBadgeBg,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              2.verticalSpace,
              Text(
                LangKey.parentRewards.youGiveCare,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryTextColor,
                ),
              ),
              16.verticalSpace,

              // Horizontal Wellbeing list
              SizedBox(
                height: 168.h,
                child: Obx(() => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.wellbeingOffers.length,
                      separatorBuilder: (context, index) => 12.horizontalSpace,
                      itemBuilder: (context, index) {
                        final offer = controller.wellbeingOffers[index];
                        return Container(
                          width: 180.w,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.wellbeingCardBorder,
                              width: 1.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blackColor.withOpacity(0.03),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    index == 1
                                        ? AppAssets.icSpa2
                                        : AppAssets.icSpa,
                                    width: 25.w,
                                    height: 25.w,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.brandTealLight,
                                      borderRadius:
                                          BorderRadius.circular(999.r),
                                    ),
                                    child: Text(
                                      offer.discount,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.voucherBadgeBg,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              12.verticalSpace,
                              Text(
                                offer.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackTextColor,
                                ),
                              ),
                              4.verticalSpace,
                              Text(
                                offer.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.mutedTextColor,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  Get.to(() => const MyOfferScreen());
                                },
                                child: Text(
                                  LangKey.parentRewards.viewOffer,
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              ),
              24.verticalSpace,

              // ── Tab Bar selector ───────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppColors.brandGrayLight,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        final isSelected = controller.selectedTab.value == 0;
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            controller.changeTab(0);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppColors.blackColor
                                            .withOpacity(0.05),
                                        blurRadius: 1,
                                        offset: const Offset(0, 1),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Text(
                              LangKey.parentRewards.earn,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? AppColors.whiteColor
                                    : AppColors.brandDarkAsterisk,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    Expanded(
                      child: Obx(() {
                        final isSelected = controller.selectedTab.value == 1;
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            controller.changeTab(1);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppColors.blackColor
                                            .withOpacity(0.05),
                                        blurRadius: 1,
                                        offset: const Offset(0, 1),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Text(
                              LangKey.parentRewards.spend,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? AppColors.whiteColor
                                    : AppColors.brandDarkAsterisk,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,

              // ── Activities List ────────────────────────────────────────────
              Obx(() {
                final isEarn = controller.selectedTab.value == 0;
                final listTitle = isEarn
                    ? LangKey.parentRewards.earnedLastWeek
                    : LangKey.parentRewards.spentLastWeek;
                final activities = isEarn
                    ? controller.recentActivities
                    : controller.recentSpentActivities;

                if (activities.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Text(
                        isEarn
                            ? 'No earned history available.'
                            : 'No spent history available.',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          color: AppColors.mutedTextColor,
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listTitle,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.headerTextColor,
                      ),
                    ),
                    12.verticalSpace,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: activities.length,
                      separatorBuilder: (context, index) => 12.verticalSpace,
                      itemBuilder: (context, index) {
                        final activity = activities[index];
                        return Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppColors.groceryCardBorder,
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            children: [
                              if (activity.isCarrefour)
                                Container(
                                  width: 40.w,
                                  height: 40.w,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryBackgroundColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppAssets.icCarrefourLogo,
                                      width: 24.w,
                                      height: 16.h,
                                    ),
                                  ),
                                )
                              else
                                activity.icon == IconsaxPlusLinear.document
                                    ? SvgPicture.asset(
                                        AppAssets.icArticleSvg,
                                        width: 40.w,
                                        height: 40.w,
                                      )
                                    : Container(
                                        width: 40.w,
                                        height: 40.w,
                                        decoration: const BoxDecoration(
                                          color: AppColors
                                              .bottomNavSelectedBackground,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: activity.icon ==
                                                  IconsaxPlusLinear.book
                                              ? SvgPicture.asset(
                                                  AppAssets.icBedtimeStorySvg,
                                                  width: 20.w,
                                                  height: 15.h,
                                                )
                                              : activity.icon ==
                                                      IconsaxPlusLinear
                                                          .profile_2user
                                                  ? SvgPicture.asset(
                                                      AppAssets.icFullDayPlan,
                                                      width: 20.w,
                                                      height: 10.h,
                                                    )
                                                  : activity.icon ==
                                                          IconsaxPlusLinear
                                                              .archive_tick
                                                      ? SvgPicture.asset(
                                                          AppAssets
                                                              .icAppreciation,
                                                          width: 20.w,
                                                          height: 20.w,
                                                        )
                                                      : (activity.icon ==
                                                                  IconsaxPlusLinear
                                                                      .heart ||
                                                              activity.isHeart)
                                                          ? SvgPicture.asset(
                                                              AppAssets
                                                                  .icHeartSvg,
                                                              width: 20.w,
                                                              height: 20.w,
                                                              colorFilter:
                                                                  const ColorFilter
                                                                      .mode(
                                                                AppColors
                                                                    .primaryColor,
                                                                BlendMode.srcIn,
                                                              ),
                                                            )
                                                          : Icon(
                                                              activity.icon,
                                                              color: activity
                                                                      .isLeaf
                                                                  ? AppColors
                                                                      .supportingGreen
                                                                  : AppColors
                                                                      .primaryColor,
                                                              size: 20.w,
                                                            ),
                                        ),
                                      ),
                              12.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      activity.title,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.headerTextColor,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      activity.time,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.disabledTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (activity.amount != null) ...[
                                12.horizontalSpace,
                                Text(
                                  activity.amount!,
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.groceryRed,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
