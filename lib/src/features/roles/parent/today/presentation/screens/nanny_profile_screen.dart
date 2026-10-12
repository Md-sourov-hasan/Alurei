import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';
import '../controllers/nanny_profile_controller.dart';
import '../widgets/nanny_profile_widgets.dart';

class NannyProfileScreen extends StatelessWidget {
  const NannyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NannyProfileController>();
    return Obx(() {
      final profile = controller.profile.value;
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
            LangKey.parentToday.nannyProfile,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 18.sp,
              height: 28 / 18,
              fontWeight: FontWeight.w600,
              color: context.appColors.primaryText,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: controller.isRemoving.value
                  ? null
                  : () async {
                      final confirmed = await showRemoveNannyDialog();
                      if (confirmed ?? false) await controller.removeNanny();
                    },
              child: Container(
                margin: const EdgeInsetsDirectional.only(end: 16),
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: AppBorders.md,
                  border: Border.all(color: context.colors.error),
                ),
                child: controller.isRemoving.value
                    ? SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.w,
                          color: context.colors.error,
                        ),
                      )
                    : Icon(
                        IconsaxPlusLinear.user_remove,
                        size: 16.sp,
                        color: context.colors.error,
                      ),
              ),
            ),
          ],
        ),
        body: _buildBody(context, controller, profile),
      );
    });
  }

  Widget _buildBody(
    BuildContext context,
    NannyProfileController controller,
    ParentNannyProfileData? profile,
  ) {
    if (controller.isLoading.value) {
      return AppLoading(message: LangKey.parentToday.loadingNannyProfile);
    }
    if (profile == null) {
      return AppErrorWidget(
        message: controller.errorMessage.value ??
            LangKey.parentToday.unableToLoadNannyProfile,
        onRetry: controller.loadProfile,
      );
    }

    return RefreshIndicator(
      onRefresh: controller.loadProfile,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: NannyProfileHeader(
              profile: profile,
              onPortfolioTap: () => Get.toNamed<void>(
                AppRoutes.nannyPortfolio,
                arguments: {'nanny_id': profile.id},
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 6.h)),
          SliverToBoxAdapter(
            child: NannyProfileTabs(
              selected: controller.selectedTab.value,
              onSelected: (value) => controller.tab = value,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
            sliver: SliverToBoxAdapter(
              child: _SelectedTabBody(
                tab: controller.selectedTab.value,
                profile: profile,
                onTaskTap: (task) => Get.toNamed<void>(
                  AppRoutes.nannyActivityDetails,
                  arguments: {'task_id': task.id},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedTabBody extends StatelessWidget {
  const _SelectedTabBody({
    required this.tab,
    required this.profile,
    required this.onTaskTap,
  });

  final ParentNannyProfileTab tab;
  final ParentNannyProfileData profile;
  final ValueChanged<ParentNannyProfileTask> onTaskTap;

  @override
  Widget build(BuildContext context) {
    return switch (tab) {
      ParentNannyProfileTab.overview => NannyProfileOverviewTab(
          profile: profile,
          onTaskTap: onTaskTap,
        ),
      ParentNannyProfileTab.thisWeek => NannyProfilePeriodTab(
          title: LangKey.parentToday.allTasksThisWeek,
          summary: profile.weekSummary,
          tasks: profile.weekTasks,
          onTaskTap: onTaskTap,
        ),
      ParentNannyProfileTab.thisMonth => NannyProfilePeriodTab(
          title: LangKey.parentToday.allTasksThisMonth,
          summary: profile.monthSummary,
          tasks: profile.monthTasks,
          onTaskTap: onTaskTap,
        ),
    };
  }
}
