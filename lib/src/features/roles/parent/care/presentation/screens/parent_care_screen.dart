import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';
import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_care_controller.dart';
import '../widgets/care_all_modules_section.dart';
import '../widgets/care_child_chips.dart';
import '../widgets/care_hub_tabs.dart';
import '../widgets/care_insights_tab_view.dart';
import '../widgets/care_module_card.dart';
import '../widgets/care_module_filter_tabs.dart';
import '../widgets/care_suggested_section.dart';
import '../widgets/care_topic_chips.dart';
import '../widgets/for_you/care_for_you_tab_view.dart';

class ParentCareScreen extends GetView<ParentCareController> {
  const ParentCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activeController = Get.isRegistered<ParentCareController>()
        ? controller
        : Get.put(ParentCareController());

    final sessionController = Get.isRegistered<SessionController>()
        ? Get.find<SessionController>()
        : null;

    return Obx(() {
      final currentUser = sessionController?.user.value;
      final fullName = currentUser?.fullName;
      final userName = (fullName != null && fullName.isNotEmpty)
          ? fullName
          : 'Monica Steve';

      return Scaffold(
        backgroundColor: context.appColors.primaryBackground,
        appBar: AppDashboardTopBar(
          greeting: 'Good Morning',
          userName: userName,
          avatarUrl: AppAssets.parentTodayParentAvatar,
          notificationCount: activeController.notificationCount.value,
          messageCount: activeController.messageCount.value,
          onNotifications: activeController.openNotifications,
          onMessages: activeController.openMessages,
          toolbarHeight: 83,
        ),
        body: Obx(() {
          return SkeletonWrapper(
            isLoading: activeController.isLoading.value,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Edge-to-edge Child Selector Circular Avatar Chips (Eve, Rose)
                  const CareChildChips(),

              // Edge-to-edge Caregiving Hub / Insights / For you Tabs
              const CareHubTabs(),

              // Dynamic Hub Tab View (Caregiving Hub, Insights, For you)
              Obx(() {
                final hubIndex = activeController.selectedHubIndex.value;

                // Hub Tab 1: Insights View
                if (hubIndex == 1) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: const CareInsightsTabView(),
                  );
                }

                // Hub Tab 2: For You View
                if (hubIndex == 2) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: const CareForYouTabView(),
                  );
                }

                // Hub Tab 0: Caregiving Hub View
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main Section Header & Description
                      Text(
                        LangKey.parentCare.exploreBabyHandlingLesson,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF003D45),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        LangKey.parentCare.exploreSubtitle,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 13.sp,
                          height: 1.4,
                          color: const Color(0xFF6C7E80),
                        ),
                      ),
                      SizedBox(height: 18.h),

                      // Module Filter Tabs (All Modules / In progress / Completed)
                      const CareModuleFilterTabs(),

                      // Dynamic Content based on selected Module Filter Tab
                      Obx(() {
                        final filterIndex =
                            activeController.selectedModuleFilterIndex.value;

                        // Tab 1: In Progress Tab View
                        if (filterIndex == 1) {
                          final list = activeController.filteredInProgressList;
                          if (list.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.h),
                              child: Center(
                                child: Text(
                                  'No in-progress modules found',
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF8BA5A8),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.only(top: 18.h),
                            child: Column(
                              children: List.generate(list.length, (i) {
                                final item = list[i];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 14.h),
                                  child: CareModuleCard(
                                    item: item,
                                    isInProgressMode: true,
                                    onAddToWeek: () =>
                                        activeController.addToWeek(item),
                                    onVisitModule: () =>
                                        activeController.visitModule(item),
                                    onBookmark: () =>
                                        activeController.toggleBookmark(item),
                                  ),
                                );
                              }),
                            ),
                          );
                        }

                        // Tab 2: Completed Tab View
                        if (filterIndex == 2) {
                          final list = activeController.filteredCompletedList;
                          if (list.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.h),
                              child: Center(
                                child: Text(
                                  'No completed modules found',
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF8BA5A8),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.only(top: 18.h),
                            child: Column(
                              children: List.generate(list.length, (i) {
                                final item = list[i];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 14.h),
                                  child: CareModuleCard(
                                    item: item,
                                    isInProgressMode: true,
                                    onAddToWeek: () =>
                                        activeController.addToWeek(item),
                                    onVisitModule: () =>
                                        activeController.visitModule(item),
                                    onBookmark: () =>
                                        activeController.toggleBookmark(item),
                                  ),
                                );
                              }),
                            ),
                          );
                        }

                        // Tab 3: Saved Tab View
                        if (filterIndex == 3) {
                          final list = activeController.filteredSavedList;
                          if (list.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.h),
                              child: Center(
                                child: Text(
                                  'No saved modules found',
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF8BA5A8),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.only(top: 18.h),
                            child: Column(
                              children: List.generate(list.length, (i) {
                                final item = list[i];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 14.h),
                                  child: CareModuleCard(
                                    item: item,
                                    onAddToWeek: () =>
                                        activeController.addToWeek(item),
                                    onVisitModule: () =>
                                        activeController.visitModule(item),
                                    onBookmark: () =>
                                        activeController.toggleBookmark(item),
                                  ),
                                );
                              }),
                            ),
                          );
                        }

                        // Tab 0: All Modules Tab View
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 18.h),

                            // Search Bar + Filter Icon Button Row
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 48.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF4F9F9),
                                      borderRadius: BorderRadius.circular(24.r),
                                      border: Border.all(
                                        color: const Color(0xFFE5EEEE),
                                      ),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          IconsaxPlusLinear.search_normal_1,
                                          size: 18.w,
                                          color: const Color(0xFF6C7E80),
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: TextField(
                                            onChanged:
                                                activeController.updateSearch,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style:
                                                GlobalTextStyles.interTextStyle(
                                              fontSize: 13.5.sp,
                                              color: const Color(0xFF003D45),
                                            ),
                                            decoration: InputDecoration(
                                              filled: false,
                                              fillColor: Colors.transparent,
                                              hintText:
                                                  LangKey.parentCare.searchHint,
                                              hintStyle: GlobalTextStyles
                                                  .interTextStyle(
                                                fontSize: 13.5.sp,
                                                color: const Color(0xFF7C8E90),
                                              ),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),

                                // Teal Filter Icon Button
                                GestureDetector(
                                  onTap: () => showGlobalToast(
                                      message: LangKey.parentCare.filterTapped),
                                  child: Container(
                                    width: 48.h,
                                    height: 48.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryTeal,
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: Center(
                                      child: _ThreeSlidersFilterIcon(
                                        size: 22.w,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            // Topic Filter Chips (All Topics, Feeding, Sleep, Behavior)
                            const CareTopicChips(),
                            SizedBox(height: 24.h),

                            // Suggested Section
                            const CareSuggestedSection(),
                            SizedBox(height: 24.h),

                            // All Modules Section
                            const CareAllModulesSection(),
                          ],
                        );
                      }),
                      SizedBox(height: 100.h),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      );
    }),
  );
});
}
}

class _ThreeSlidersFilterIcon extends StatelessWidget {
  const _ThreeSlidersFilterIcon({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ThreeSlidersPainter(color: color),
    );
  }
}

class _ThreeSlidersPainter extends CustomPainter {
  _ThreeSlidersPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final w = size.width;
    final h = size.height;

    // Top slider (Y = 0.22 * h)
    final y1 = h * 0.22;
    canvas.drawLine(Offset(w * 0.12, y1), Offset(w * 0.88, y1), strokePaint);
    // Top handle (vertical tick at X = 0.72 * w)
    canvas.drawLine(Offset(w * 0.72, y1 - h * 0.14),
        Offset(w * 0.72, y1 + h * 0.14), strokePaint);

    // Middle slider (Y = 0.50 * h)
    final y2 = h * 0.50;
    canvas.drawLine(Offset(w * 0.12, y2), Offset(w * 0.88, y2), strokePaint);
    // Middle handle (vertical tick at X = 0.32 * w)
    canvas.drawLine(Offset(w * 0.32, y2 - h * 0.14),
        Offset(w * 0.32, y2 + h * 0.14), strokePaint);

    // Bottom slider (Y = 0.78 * h)
    final y3 = h * 0.78;
    canvas.drawLine(Offset(w * 0.12, y3), Offset(w * 0.88, y3), strokePaint);
    // Bottom handle (vertical tick at X = 0.60 * w)
    canvas.drawLine(Offset(w * 0.60, y3 - h * 0.14),
        Offset(w * 0.60, y3 + h * 0.14), strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
