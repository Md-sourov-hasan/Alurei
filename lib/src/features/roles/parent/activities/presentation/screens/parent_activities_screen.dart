import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/shared/widgets/parent_ai_assistant_button.dart';
import '../controllers/parent_activities_controller.dart';
import '../widgets/activities_all_section.dart';
import '../widgets/activities_filter_chips.dart';
import '../widgets/activities_search_bar.dart';
import '../widgets/activities_suggested_section.dart';

/// Parent Activities screen corresponding to the Activities tab on the bottom navigation bar.
class ParentActivitiesScreen extends GetView<ParentActivitiesController> {
  const ParentActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activeController = Get.isRegistered<ParentActivitiesController>()
        ? controller
        : Get.put(ParentActivitiesController());
    final appColors = context.appColors;

    return Obx(() {
      return Scaffold(
        backgroundColor: appColors.primaryBackground,
        appBar: AppDashboardTopBar(
          greeting: LangKey.parentToday.goodMorning,
          userName: 'Deepa Kumari',
          avatarUrl: AppAssets.parentTodayParentAvatar,
          notificationCount: activeController.notificationCount.value,
          messageCount: activeController.messageCount.value,
          onNotifications: activeController.openNotifications,
          onMessages: activeController.openMessages,
          toolbarHeight: 83,
        ),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // Search Bar & Filter Chips
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        ActivitiesSearchBar(
                          onSearchChanged: activeController.updateSearch,
                          initialValue: activeController.searchQuery.value,
                          onFilterPressed: activeController.toggleFilters,
                        ),
                        Obx(() {
                          if (!activeController.showFilters.value) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            children: [
                              SizedBox(height: 12.h),
                              const ActivitiesFilterChips(),
                            ],
                          );
                        }),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),

                // Suggested for you Section
                const SliverToBoxAdapter(
                  child: ActivitiesSuggestedSection(),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(height: 24.h),
                ),

                // All Activities Section
                const SliverToBoxAdapter(
                  child: ActivitiesAllSection(),
                ),

                // Bottom Spacing
                SliverToBoxAdapter(
                  child: SizedBox(height: 32.h),
                ),
              ],
            ),
            Positioned(
              right: 16.w,
              bottom: 90.h,
              child: ParentAiAssistantButton(
                menuOpen: activeController.isAiMenuOpen.value,
                onPressed: activeController.toggleAiMenu,
              ),
            ),
          ],
        ),
      );
    });
  }
}
