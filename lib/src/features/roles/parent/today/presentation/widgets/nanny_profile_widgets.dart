import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';

class NannyProfileHeader extends StatelessWidget {
  const NannyProfileHeader({
    super.key,
    required this.profile,
    required this.onPortfolioTap,
  });

  final ParentNannyProfileData profile;
  final VoidCallback onPortfolioTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.appColors.elevatedBackground,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            padding: EdgeInsets.all(3.5.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.colors.primary, width: 3.5.w),
              boxShadow: AppShadows.subtle,
            ),
            child: ClipOval(
              child: Image.asset(profile.avatarAsset, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Flexible(
                child: Text(
                  profile.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 20.sp,
                    height: 30 / 20,
                    fontWeight: FontWeight.w700,
                    color: context.appColors.primaryText,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              _ActiveBadge(label: profile.status),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Icon(
                IconsaxPlusLinear.calendar,
                size: 14.sp,
                color: context.appColors.secondaryText,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  profile.since,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    height: 18 / 12,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.secondaryText,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _ContactChip(icon: IconsaxPlusLinear.sms, label: profile.email),
              _ContactChip(icon: IconsaxPlusLinear.call, label: profile.phone),
            ],
          ),
          SizedBox(height: 16.h),
          _HeaderActionRow(
            profile: profile,
            onPortfolioTap: onPortfolioTap,
          ),
        ],
      ),
    );
  }
}

class _HeaderActionRow extends StatelessWidget {
  const _HeaderActionRow({
    required this.profile,
    required this.onPortfolioTap,
  });

  final ParentNannyProfileData profile;
  final VoidCallback onPortfolioTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: context.appColors.bottomNavBorder),
              borderRadius: AppBorders.md,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LangKey.parentToday.caringFor,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.mutedText,
                  ),
                ),
                SizedBox(width: 8.w),
                for (var index = 0; index < profile.caringFor.length; index++)
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: index == 0 ? 0 : 4.w,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.brandTealLight,
                        borderRadius: AppBorders.full,
                      ),
                      child: Text(
                        profile.caringFor[index],
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          height: 16 / 12,
                          fontWeight: FontWeight.w700,
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.10),
              border: Border.all(color: context.appColors.bottomNavBorder),
              borderRadius: AppBorders.lg,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '${LangKey.parentToday.careScore}: ${profile.careScore}',
                maxLines: 1,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 12.sp,
                  height: 18 / 12,
                  fontWeight: FontWeight.w600,
                  color: context.colors.primary,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: FilledButton(
            onPressed: onPortfolioTap,
            style: FilledButton.styleFrom(
              minimumSize: Size(0, 40.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              backgroundColor: context.colors.primary,
              foregroundColor: context.colors.onPrimary,
              shape: const RoundedRectangleBorder(
                borderRadius: AppBorders.md,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                LangKey.parentToday.viewPortfolio,
                maxLines: 1,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 12.sp,
                  height: 18 / 12,
                  fontWeight: FontWeight.w500,
                  color: context.colors.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NannyProfileTabs extends StatelessWidget {
  const NannyProfileTabs({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final ParentNannyProfileTab selected;
  final ValueChanged<ParentNannyProfileTab> onSelected;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.appColors.elevatedBackground,
      child: Row(
        children: ParentNannyProfileTab.values.map((tab) {
          final isSelected = selected == tab;
          return Expanded(
            child: InkWell(
              onTap: () => onSelected(tab),
              child: Container(
                padding: EdgeInsets.only(top: 12.h, bottom: 14.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? context.colors.primary
                          : context.appColors.bottomNavBorder,
                      width: isSelected ? 2.h : 1.h,
                    ),
                  ),
                ),
                child: Text(
                  _tabLabel(tab),
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? context.colors.primary
                        : context.appColors.mutedText,
                  ),
                ),
              ),
            ),
          );
        }).toList(growable: false),
      ),
    );
  }

  String _tabLabel(ParentNannyProfileTab tab) {
    return switch (tab) {
      ParentNannyProfileTab.overview => LangKey.parentToday.overview,
      ParentNannyProfileTab.thisWeek => LangKey.parentToday.thisWeek,
      ParentNannyProfileTab.thisMonth => LangKey.parentToday.thisMonth,
    };
  }
}

class NannyProfileOverviewTab extends StatelessWidget {
  const NannyProfileOverviewTab({
    super.key,
    required this.profile,
    required this.onTaskTap,
  });

  final ParentNannyProfileData profile;
  final ValueChanged<ParentNannyProfileTask> onTaskTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NannyMetricGrid(metrics: profile.overviewMetrics),
        SizedBox(height: 16.h),
        NannyTaskCard(
          title: LangKey.parentToday.recentTasks,
          tasks: profile.recentTasks,
          showViewAll: true,
          onTaskTap: onTaskTap,
        ),
        SizedBox(height: 28.h),
        Text(
          LangKey.parentToday.recentHighlights,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 18.sp,
            height: 28 / 18,
            fontWeight: FontWeight.w700,
            color: context.colors.primary,
          ),
        ),
        SizedBox(height: 12.h),
        NannyHighlightsGrid(images: profile.highlights),
      ],
    );
  }
}

class NannyProfilePeriodTab extends StatelessWidget {
  const NannyProfilePeriodTab({
    super.key,
    required this.title,
    required this.summary,
    required this.tasks,
    required this.onTaskTap,
  });

  final String title;
  final List<ParentNannyProfileMetric> summary;
  final List<ParentNannyProfileTask> tasks;
  final ValueChanged<ParentNannyProfileTask> onTaskTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NannySummaryRow(metrics: summary),
        SizedBox(height: 28.h),
        Text(
          title,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 16.sp,
            height: 24 / 16,
            fontWeight: FontWeight.w600,
            color: context.colors.primary,
          ),
        ),
        SizedBox(height: 16.h),
        NannyTaskCard(tasks: tasks, onTaskTap: onTaskTap),
      ],
    );
  }
}

class NannyMetricGrid extends StatelessWidget {
  const NannyMetricGrid({super.key, required this.metrics});

  final List<ParentNannyProfileMetric> metrics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: metrics.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        final metric = metrics[index];
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: context.appColors.elevatedBackground,
            borderRadius: AppBorders.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                _metricIcon(metric.icon),
                size: 24.sp,
                color: context.colors.primary,
              ),
              const Spacer(),
              Text(
                metric.value,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 18.sp,
                  height: 28 / 18,
                  fontWeight: FontWeight.w600,
                  color: context.appColors.primaryText,
                ),
              ),
              Text(
                metric.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 12.sp,
                  height: 18 / 12,
                  color: context.appColors.disabledText,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class NannySummaryRow extends StatelessWidget {
  const NannySummaryRow({super.key, required this.metrics});

  final List<ParentNannyProfileMetric> metrics;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < metrics.length; index++) ...[
          Expanded(
            child: _SummaryCard(
              metric: metrics[index],
              alignEnd: index > 0,
            ),
          ),
          if (index != metrics.length - 1) SizedBox(width: 8.w),
        ],
      ],
    );
  }
}

class NannyTaskCard extends StatelessWidget {
  const NannyTaskCard({
    super.key,
    required this.tasks,
    this.title,
    this.showViewAll = false,
    required this.onTaskTap,
  });

  final List<ParentNannyProfileTask> tasks;
  final String? title;
  final bool showViewAll;
  final ValueChanged<ParentNannyProfileTask> onTaskTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        border: Border.all(color: context.appColors.bottomNavBorder),
        borderRadius: AppBorders.lg,
      ),
      child: Column(
        children: [
          if (title != null)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 13.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title!,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        fontWeight: FontWeight.w600,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                  if (showViewAll)
                    Text(
                      LangKey.parentToday.viewAll,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        height: 18 / 12,
                        fontWeight: FontWeight.w600,
                        color: context.colors.primary,
                      ),
                    ),
                  if (showViewAll) SizedBox(width: 6.w),
                  if (showViewAll)
                    Icon(
                      IconsaxPlusLinear.arrow_right_3,
                      size: 12.sp,
                      color: context.colors.primary,
                    ),
                ],
              ),
            ),
          for (var index = 0; index < tasks.length; index++)
            _TaskTile(
              task: tasks[index],
              isLast: index == tasks.length - 1,
              onTap: () => onTaskTap(tasks[index]),
            ),
        ],
      ),
    );
  }
}

class NannyHighlightsGrid extends StatelessWidget {
  const NannyHighlightsGrid({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 130 / 109,
      ),
      itemBuilder: (context, index) {
        final image = images[index];
        return InkWell(
          onTap: () => FullScreenImageViewer.open<void>(
            imageUrl: image,
            imageUrls: images,
            initialIndex: index,
          ),
          borderRadius: AppBorders.lg,
          child: ClipRRect(
            borderRadius: AppBorders.lg,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}

Future<bool?> showRemoveNannyDialog() {
  return showAppDialog<bool>(
    barrierColor: AppColors.black40,
    child: const RemoveNannyDialog(),
  );
}

class RemoveNannyDialog extends StatelessWidget {
  const RemoveNannyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 48.w),
      backgroundColor: AppColors.transparentColor,
      elevation: 0,
      child: Container(
        width: 345.w,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: context.appColors.elevatedBackground,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52.w,
              height: 54.h,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: context.colors.error.withValues(alpha: 0.10),
                borderRadius: AppBorders.md,
              ),
              child: SvgPicture.asset(AppAssets.parentTodayDeleteDialogIcon),
            ),
            SizedBox(height: 12.h),
            Text(
              LangKey.parentToday.removeNannyTitle,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 18.sp,
                height: 28 / 18,
                fontWeight: FontWeight.w600,
                color: context.appColors.primaryText,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              LangKey.parentToday.removeNannyDescription,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 20 / 14,
                color: context.appColors.disabledText,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(result: false),
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size.fromHeight(46.h),
                      foregroundColor: context.appColors.disabledText,
                      side:
                          BorderSide(color: context.appColors.bottomNavBorder),
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppBorders.lg,
                      ),
                    ),
                    child: Text(LangKey.parentToday.cancel),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Get.back(result: true),
                    style: FilledButton.styleFrom(
                      fixedSize: Size.fromHeight(46.h),
                      backgroundColor: AppColors.deleteRed,
                      foregroundColor: AppColors.whiteColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppBorders.lg,
                      ),
                    ),
                    child: Text(
                      LangKey.parentToday.delete,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactChip extends StatelessWidget {
  const _ContactChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.appColors.primaryBackground,
        borderRadius: AppBorders.full,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: context.colors.primary),
          SizedBox(width: 8.w),
          Text(
            label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w500,
              color: context.colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveBadge extends StatelessWidget {
  const _ActiveBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.groceryStockGreen.withValues(alpha: 0.10),
        borderRadius: AppBorders.full,
      ),
      child: Text(
        label,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 10.sp,
          height: 15 / 10,
          fontWeight: FontWeight.w600,
          color: AppColors.groceryStockGreen,
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.metric, required this.alignEnd});

  final ParentNannyProfileMetric metric;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: AppColors.brandTealGlassBg,
        border: Border.all(color: context.appColors.elevatedBackground),
        borderRadius: AppBorders.md,
        boxShadow: const [
          BoxShadow(
            color: AppColors.black05,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            metric.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: alignEnd ? TextAlign.right : TextAlign.left,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              height: 18 / 12,
              fontWeight: FontWeight.w500,
              color: context.colors.primary,
            ),
          ),
          Text(
            metric.value,
            textAlign: alignEnd ? TextAlign.right : TextAlign.left,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w700,
              color: context.colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({
    required this.task,
    required this.isLast,
    required this.onTap,
  });

  final ParentNannyProfileTask task;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: context.appColors.bottomNavBorder),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(_taskIcon(task.kind), size: 24.sp, color: _taskColor(task)),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.primaryText,
                    ),
                  ),
                  Text(
                    task.subtitle,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      height: 18 / 12,
                      color: context.appColors.disabledText,
                    ),
                  ),
                ],
              ),
            ),
            if (task.proofMissing)
              Icon(
                IconsaxPlusLinear.close_square,
                size: 16.sp,
                color: context.colors.error,
              ),
            if (task.proofMissing) SizedBox(width: 8.w),
            Icon(
              IconsaxPlusLinear.arrow_right_3,
              size: 16.sp,
              color: context.appColors.primaryText,
            ),
            SizedBox(width: 8.w),
            Icon(
              IconsaxPlusLinear.gallery,
              size: 14.sp,
              color: context.appColors.primaryText,
            ),
            SizedBox(width: 4.w),
            Text(
              task.proofCount.toString(),
              style: GlobalTextStyles.interTextStyle(
                fontSize: 12.sp,
                height: 18 / 12,
                color: context.appColors.primaryText,
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: _statusColor(task.status),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

IconData _metricIcon(ParentRoutineKind kind) {
  return switch (kind) {
    ParentRoutineKind.pasta => IconsaxPlusLinear.cup,
    ParentRoutineKind.nap => IconsaxPlusLinear.heart,
    ParentRoutineKind.wake => IconsaxPlusLinear.clock_1,
    _ => IconsaxPlusLinear.calendar,
  };
}

IconData _taskIcon(ParentNannyTaskKind kind) {
  return switch (kind) {
    ParentNannyTaskKind.meal => IconsaxPlusLinear.cup,
    ParentNannyTaskKind.care => IconsaxPlusLinear.heart,
    ParentNannyTaskKind.education => IconsaxPlusLinear.teacher,
    ParentNannyTaskKind.activity => IconsaxPlusLinear.calendar,
  };
}

Color _taskColor(ParentNannyProfileTask task) {
  return switch (task.kind) {
    ParentNannyTaskKind.meal => AppColors.warning500,
    ParentNannyTaskKind.care => task.status == ParentNannyTaskStatus.missing
        ? AppColors.secondaryButtonColor
        : AppColors.primaryColor,
    ParentNannyTaskKind.education => AppColors.blackColor,
    ParentNannyTaskKind.activity => AppColors.primaryColor,
  };
}

Color _statusColor(ParentNannyTaskStatus status) {
  return switch (status) {
    ParentNannyTaskStatus.complete => AppColors.groceryGreen,
    ParentNannyTaskStatus.warning => AppColors.supportingOrange,
    ParentNannyTaskStatus.missing => AppColors.secondaryButtonColor,
  };
}
