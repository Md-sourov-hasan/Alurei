import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';
import '../controllers/nanny_portfolio_controller.dart';

class NannyPortfolioScreen extends StatelessWidget {
  const NannyPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NannyPortfolioController>();
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: context.appColors.elevatedBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: Get.back<void>,
          icon: Icon(
            IconsaxPlusLinear.arrow_left,
            size: 20.sp,
            color: context.colors.primary,
          ),
        ),
        centerTitle: true,
        title: Text(
          LangKey.parentToday.nannysPortfolio,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 18.sp,
            height: 28 / 18,
            fontWeight: FontWeight.w600,
            color: context.appColors.primaryText,
          ),
        ),
      ),
      body: Obx(() {
        final portfolio = controller.portfolio.value;
        if (controller.isLoading.value) {
          return AppLoading(message: LangKey.parentToday.loadingPortfolio);
        }
        if (portfolio == null) {
          return AppErrorWidget(
            message: controller.errorMessage.value ??
                LangKey.parentToday.unableToLoadPortfolio,
            onRetry: controller.loadPortfolio,
          );
        }
        return RefreshIndicator(
          onRefresh: controller.loadPortfolio,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(10.w, 16.h, 10.w, 28.h),
            children: [
              _PortfolioHeader(portfolio: portfolio),
              SizedBox(height: 12.h),
              _PortfolioTabs(
                selected: controller.selectedTab.value,
                onSelected: (tab) => controller.tab = tab,
              ),
              SizedBox(height: 12.h),
              if (controller.selectedTab.value ==
                  ParentNannyPortfolioTab.portfolio)
                _PortfolioTabView(portfolio: portfolio)
              else
                _InsightsTabView(portfolio: portfolio),
            ],
          ),
        );
      }),
    );
  }
}

class _PortfolioHeader extends StatelessWidget {
  const _PortfolioHeader({required this.portfolio});

  final ParentNannyPortfolioData portfolio;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 78.w,
                height: 78.w,
                padding: EdgeInsets.all(2.5.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: context.colors.primary, width: 2.w),
                ),
                child: ClipOval(
                  child: Image.asset(portfolio.avatarAsset, fit: BoxFit.cover),
                ),
              ),
              PositionedDirectional(
                end: -1.w,
                bottom: 4.h,
                child: Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.appColors.elevatedBackground,
                      width: 2.w,
                    ),
                  ),
                  child: Icon(
                    IconsaxPlusLinear.verify,
                    size: 10.sp,
                    color: context.colors.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            portfolio.name,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 20.sp,
              height: 30 / 20,
              fontWeight: FontWeight.w700,
              color: context.colors.primary,
            ),
          ),
          SizedBox(height: 6.h),
          _HeaderInfo(icon: IconsaxPlusLinear.calendar, label: portfolio.since),
          SizedBox(height: 6.h),
          _HeaderInfo(icon: IconsaxPlusLinear.bag, label: portfolio.experience),
          SizedBox(height: 14.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.brandTealLight),
                borderRadius: AppBorders.md,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    IconsaxPlusLinear.translate,
                    size: 14.sp,
                    color: context.colors.primary,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    portfolio.languages,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      height: 18 / 12,
                      fontWeight: FontWeight.w600,
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PortfolioTabs extends StatelessWidget {
  const _PortfolioTabs({required this.selected, required this.onSelected});

  final ParentNannyPortfolioTab selected;
  final ValueChanged<ParentNannyPortfolioTab> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
      ),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: context.appColors.primaryBackground,
          borderRadius: AppBorders.full,
        ),
        child: Row(
          children: ParentNannyPortfolioTab.values.map((tab) {
            final isSelected = selected == tab;
            return Expanded(
              child: InkWell(
                onTap: () => onSelected(tab),
                borderRadius: AppBorders.full,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.colors.primary
                        : AppColors.transparentColor,
                    borderRadius: AppBorders.full,
                  ),
                  child: Text(
                    switch (tab) {
                      ParentNannyPortfolioTab.portfolio =>
                        LangKey.parentToday.portfolio,
                      ParentNannyPortfolioTab.insights =>
                        LangKey.parentToday.insights,
                    },
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? context.colors.onPrimary
                          : context.appColors.primaryText,
                    ),
                  ),
                ),
              ),
            );
          }).toList(growable: false),
        ),
      ),
    );
  }
}

class _PortfolioTabView extends StatelessWidget {
  const _PortfolioTabView({required this.portfolio});

  final ParentNannyPortfolioData portfolio;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PerksCard(perks: portfolio.perks),
        SizedBox(height: 12.h),
        _SkillsCard(
          skills: portfolio.skills,
          moreSkillsLabel: portfolio.moreSkillsLabel,
        ),
        SizedBox(height: 20.h),
        _ExperienceSection(experiences: portfolio.experiences),
      ],
    );
  }
}

class _InsightsTabView extends StatelessWidget {
  const _InsightsTabView({required this.portfolio});

  final ParentNannyPortfolioData portfolio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: portfolio.ageGroups
              .map((age) => _AgeGroupChip(label: age))
              .toList(growable: false),
        ),
        SizedBox(height: 16.h),
        for (var index = 0; index < portfolio.insights.length; index++) ...[
          _InsightCard(insight: portfolio.insights[index]),
          if (index != portfolio.insights.length - 1) SizedBox(height: 16.h),
        ],
      ],
    );
  }
}

class _PerksCard extends StatelessWidget {
  const _PerksCard({required this.perks});

  final List<ParentNannyPortfolioStat> perks;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title: LangKey.parentToday.perkDetails,
            trailing: IconsaxPlusLinear.gift,
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              for (var index = 0; index < perks.length; index++) ...[
                Expanded(child: _PerkTile(stat: perks[index])),
                if (index != perks.length - 1) SizedBox(width: 10.w),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillsCard extends StatelessWidget {
  const _SkillsCard({required this.skills, required this.moreSkillsLabel});

  final List<String> skills;
  final String moreSkillsLabel;

  @override
  Widget build(BuildContext context) {
    final shownSkills = skills.take(5).toList(growable: false);
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(title: LangKey.parentToday.skillsTraining),
          SizedBox(height: 18.h),
          Wrap(
            spacing: 7.w,
            runSpacing: 12.h,
            children: [
              for (var index = 0; index < shownSkills.length; index++)
                _SkillPill(
                  label: shownSkills[index],
                  alternate: index.isOdd,
                ),
              _SkillPill(label: moreSkillsLabel, isMore: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection({required this.experiences});

  final List<ParentNannyPortfolioExperience> experiences;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(title: LangKey.parentToday.professionalExperience),
          SizedBox(height: 18.h),
          for (var index = 0; index < experiences.length; index++) ...[
            _ExperienceCard(experience: experiences[index]),
            if (index != experiences.length - 1) SizedBox(height: 14.h),
          ],
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.trailing});

  final String title;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 20.sp,
              height: 30 / 20,
              fontWeight: FontWeight.w500,
              color: context.colors.primary,
            ),
          ),
        ),
        if (trailing != null)
          Icon(trailing, size: 20.sp, color: context.colors.primary),
      ],
    );
  }
}

class _PerkTile extends StatelessWidget {
  const _PerkTile({required this.stat});

  final ParentNannyPortfolioStat stat;

  @override
  Widget build(BuildContext context) {
    final isPrimary = stat.accent == ParentRoutineKind.pasta;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isPrimary
            ? AppColors.supportingYellowShade
            : AppColors.brandTealGlassBg,
        borderRadius: AppBorders.lg,
      ),
      child: Column(
        children: [
          Text(
            stat.label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 11.sp,
              height: 16 / 11,
              color: context.appColors.secondaryText,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            stat.value,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 22.sp,
              height: 30 / 22,
              fontWeight: FontWeight.w700,
              color: isPrimary
                  ? context.colors.primary
                  : context.appColors.primaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillPill extends StatelessWidget {
  const _SkillPill({
    required this.label,
    this.alternate = false,
    this.isMore = false,
  });

  final String label;
  final bool alternate;
  final bool isMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: isMore
            ? AppColors.brandTealGlassBg
            : alternate
                ? AppColors.groceryGreen.withValues(alpha: 0.10)
                : AppColors.brandTealLight.withValues(alpha: 0.45),
        borderRadius: AppBorders.full,
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 11.sp,
          height: 16 / 11,
          fontWeight: FontWeight.w700,
          color:
              isMore ? context.appColors.primaryText : context.colors.primary,
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.experience});

  final ParentNannyPortfolioExperience experience;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        border: Border.all(color: context.appColors.bottomNavBorder),
        borderRadius: AppBorders.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            experience.family,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w500,
              color: context.appColors.primaryText,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: const BoxDecoration(
              color: AppColors.brandTealGlassBg,
              borderRadius: AppBorders.md,
            ),
            child: Text(
              experience.period,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 12.sp,
                height: 18 / 12,
                fontWeight: FontWeight.w500,
                color: context.colors.primary,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 18.w,
            runSpacing: 8.h,
            children: [
              _InlineIconText(
                icon: IconsaxPlusLinear.emoji_happy,
                label: experience.children,
              ),
              _InlineIconText(
                icon: IconsaxPlusLinear.clock_1,
                label: experience.duration,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.insight});

  final ParentNannyPortfolioInsight insight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: insight.highlighted
            ? AppColors.brandTealLight.withValues(alpha: 0.5)
            : context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: insight.highlighted
                      ? AppColors.secondaryTeal
                      : context.colors.primary,
                  borderRadius: AppBorders.md,
                ),
                child: Icon(
                  _portfolioInsightIcon(insight.icon),
                  size: 22.sp,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      insight.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 18.sp,
                        height: 24 / 18,
                        fontWeight: FontWeight.w700,
                        color: context.colors.primary,
                      ),
                    ),
                    Text(
                      insight.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        color: context.appColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Divider(height: 1.h, color: context.appColors.bottomNavBorder),
          SizedBox(height: 14.h),
          for (final row in insight.rows) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    row.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      color: context.colors.primary,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  row.value,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w700,
                    color: context.appColors.primaryText,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ],
      ),
    );
  }
}

class _AgeGroupChip extends StatelessWidget {
  const _AgeGroupChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryTeal.withValues(alpha: 0.10),
        border:
            Border.all(color: AppColors.secondaryTeal.withValues(alpha: 0.2)),
        borderRadius: AppBorders.full,
      ),
      child: Text(
        label,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 12.sp,
          height: 16 / 12,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryTeal,
        ),
      ),
    );
  }
}

class _HeaderInfo extends StatelessWidget {
  const _HeaderInfo({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: context.appColors.secondaryText),
        SizedBox(width: 6.w),
        Text(
          label,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 12.sp,
            height: 18 / 12,
            fontWeight: FontWeight.w500,
            color: context.appColors.secondaryText,
          ),
        ),
      ],
    );
  }
}

class _InlineIconText extends StatelessWidget {
  const _InlineIconText({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.sp, color: context.colors.primary),
        SizedBox(width: 6.w),
        Text(
          label,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            height: 20 / 14,
            fontWeight: FontWeight.w500,
            color: context.appColors.primaryText,
          ),
        ),
      ],
    );
  }
}

IconData _portfolioInsightIcon(ParentNannyTaskKind kind) {
  return switch (kind) {
    ParentNannyTaskKind.meal => IconsaxPlusLinear.cup,
    ParentNannyTaskKind.care => IconsaxPlusLinear.heart,
    ParentNannyTaskKind.education => IconsaxPlusLinear.teacher,
    ParentNannyTaskKind.activity => IconsaxPlusLinear.activity,
  };
}
