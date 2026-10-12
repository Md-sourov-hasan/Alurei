import 'package:alurei/src/imports/imports.dart';
import '../controllers/child_profile_controller.dart';

class ChildProfileScreen extends StatelessWidget {
  const ChildProfileScreen({super.key});

  ChildProfileController get controller => Get.find<ChildProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final childName =
          (controller.childProfile['name'] as String?)?.split(' ').first ??
              'Child';
      return Scaffold(
        backgroundColor: context.appColors.primaryBackground,
        appBar: AppTopBar(
          title: 'parent_today.child_profile_title'.tr(args: [childName]),
          titleColor: AppColors.headerTextColor,
          showBackButton: true,
          showDivider: true,
          onPressed: () => Get.back<void>(),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.editChildProfile),
              icon: const Icon(
                IconsaxPlusLinear.edit_2,
                color: AppColors.headerTextColor,
              ),
            ),
            8.horizontalSpace,
          ],
        ),
        body: SafeArea(
          child: Obx(() {
            final hasBlockingError = controller.errorMessage.value != null &&
                controller.childProfile.isEmpty &&
                !controller.isLoadingProfile.value;
            if (hasBlockingError) {
              return AppErrorWidget(
                message: controller.errorMessage.value!,
                onRetry: controller.loadChildProfile,
              );
            }

            return SkeletonWrapper(
              isLoading: controller.isLoadingProfile.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: controller.loadChildProfile,
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 24.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildProfileHeader(context),
                                  24.verticalSpace,
                                  _buildManageCaregiversBtn(context),
                                  16.verticalSpace,
                                  _buildStatsRow(context),
                                ],
                              ),
                            ),
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: _SliverAppBarDelegate(
                              TabBar(
                                controller: controller.tabController,
                                indicator: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 3.h,
                                    ),
                                  ),
                                ),
                                labelColor: AppColors.primaryColor,
                                unselectedLabelColor:
                                    context.appColors.secondaryText,
                                indicatorSize: TabBarIndicatorSize.tab,
                                tabs: [
                                  Tab(
                                    icon: Icon(
                                      IconsaxPlusLinear.grid_2,
                                      size: 24.w,
                                    ),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      IconsaxPlusLinear.book,
                                      size: 24.w,
                                    ),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      IconsaxPlusLinear.setting_4,
                                      size: 24.w,
                                    ),
                                  ),
                                ],
                              ),
                              color: AppColors.whiteColor,
                            ),
                          ),
                          SliverFillRemaining(
                            child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                _buildMemoriesGrid(),
                                _buildStoriesTab(context),
                                _buildFiltersTab(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Obx(() {
      final child = controller.childProfile;
      final avatar = child['avatar']?.toString();
      final name = child['name']?.toString() ?? '';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (avatar != null && avatar.isNotEmpty) {
                FullScreenImageViewer.open(
                  imageUrl: avatar,
                  heroTag: 'profile_image_$name',
                );
              }
            },
            child: Hero(
              tag: 'profile_image_$name',
              child: Container(
                width: 88.w,
                height: 88.w,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryColor, width: 2.w),
                ),
                child: ClipOval(
                  child: avatar == null || avatar.isEmpty
                      ? const _ChildAvatarFallback()
                      : CommonImage(
                          imageUrl: avatar,
                          fit: BoxFit.cover,
                          placeholder: const _ChildAvatarFallback(),
                          errorWidget: const _ChildAvatarFallback(),
                        ),
                ),
              ),
            ),
          ),
          16.verticalSpace,
          Text(
            name,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.headerTextColor,
            ),
          ),
          4.verticalSpace,
          Text(
            child['age']?.toString() ?? '',
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: context.appColors.secondaryText,
            ),
          ),
          if ((child['gender']?.toString() ?? '').isNotEmpty ||
              (child['weight']?.toString() ?? '').isNotEmpty) ...[
            8.verticalSpace,
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                if ((child['gender']?.toString() ?? '').isNotEmpty)
                  _InfoPill(label: child['gender'].toString()),
                if ((child['weight']?.toString() ?? '').isNotEmpty)
                  _InfoPill(label: child['weight'].toString()),
                if ((child['wakeUpTime']?.toString() ?? '').isNotEmpty)
                  _InfoPill(label: 'Wake ${child['wakeUpTime']}'),
                if ((child['bedTime']?.toString() ?? '').isNotEmpty)
                  _InfoPill(label: 'Bed ${child['bedTime']}'),
              ],
            ),
          ],
        ],
      );
    });
  }

  Widget _buildManageCaregiversBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed<void>(AppRoutes.parentManageCaregivers),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: context.appColors.elevatedBackground, // light gray
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(IconsaxPlusLinear.profile_2user,
                  color: AppColors.primaryColor, size: 20.w),
            ),
            12.horizontalSpace,
            Expanded(
              child: Text(
                LangKey.parentHome.manageCaregivers,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor, // teal text
                ),
              ),
            ),
            Icon(IconsaxPlusLinear.arrow_right_3,
                color: AppColors.headerTextColor, size: 20.w),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Obx(() {
      final child = controller.childProfile;
      return Row(
        children: [
          Expanded(
            child: _buildStatCard(
              context,
              count: child['memoriesCount'].toString(),
              label: LangKey.parentHome.memories,
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: _buildStatCard(
              context,
              count: child['storiesCount'].toString(),
              label: LangKey.parentHome.stories,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildStatCard(BuildContext context,
      {required String count, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border:
            Border.all(color: AppColors.brandGrayBorder.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),
          4.verticalSpace,
          Text(
            label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.headerTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemoriesGrid() {
    return Obx(() {
      final photos = controller.memoriesPhotos;
      return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: 1,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              FullScreenImageViewer.open(
                imageUrl: photos[index],
                heroTag: 'memory_photo_$index',
                subtitle: '21 June 2026', // Based on design
                onDelete: () {
                  showAppConfirmationDialog(
                    title: LangKey.parentHome.deletePhoto,
                    message:
                        'Are you sure you want to delete this image?\nThis action cannot be undone.',
                    confirmLabel: LangKey.parentToday.delete,
                    cancelLabel: LangKey.parentToday.cancel,
                    primaryConfirm: true,
                    confirmButtonColor: AppColors.errorColor,
                    confirmButtonTextColor: AppColors.whiteColor,
                    headerIcon: Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        color: AppColors.supportingRedShade,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Icon(
                          IconsaxPlusLinear.trash,
                          color: AppColors.errorColor,
                          size: 28.w,
                        ),
                      ),
                    ),
                  ).then((confirmed) {
                    if (confirmed ?? false) {
                      // Call controller to delete memory photo here later
                    }
                  });
                },
                onDownload: () {},
              );
            },
            child: Hero(
              tag: 'memory_photo_$index',
              child: CommonImage(
                imageUrl: photos[index],
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildStoriesTab(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      children: [
        AppTextField(
          controller: TextEditingController(),
          hint: LangKey.parentHome.searchStories,
          prefixIcon: Icon(IconsaxPlusLinear.search_normal_1,
              color: context.appColors.secondaryText, size: 20.w),
          suffixIcon: Icon(IconsaxPlusLinear.calendar,
              color: context.appColors.secondaryText, size: 20.w),
        ),
        24.verticalSpace,
        Obx(() {
          final stories = controller.storiesList;
          return Column(
            children: stories.map((story) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: _buildStoryCard(context, story),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildStoryCard(BuildContext context, Map<String, dynamic> story) {
    return SizedBox(
      height: 240.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CommonImage(
            imageUrl: story['image'] as String,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(16.r),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
                stops: const [0.4, 1.0],
              ),
            ),
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  story['date'] ?? '',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteColor.withValues(alpha: 0.8),
                  ),
                ),
                4.verticalSpace,
                Text(
                  story['title'] ?? '',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.whiteColor,
                  ),
                ),
                12.verticalSpace,
                AppButton(
                  label: LangKey.parentHome.visitStory,
                  onPressed: () {
                    Get.toNamed<dynamic>(
                      AppRoutes.bedtimeStory,
                      arguments: {'isHistory': true},
                    );
                  },
                  color: AppColors.whiteColor,
                  textColor: AppColors.primaryColor,
                  prefixIcon: Icon(Icons.play_arrow_rounded,
                      size: 20.w, color: AppColors.primaryColor),
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersTab(BuildContext context) {
    return ColoredBox(
      color: context.appColors.primaryBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildRecurringActivitiesSection(context),
          8.verticalSpace,
          Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _buildSectionTitle(LangKey.parentHome.favoriteFoods),
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _buildChips(controller.favoriteFoods, true, context),
                ),
                24.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child:
                      _buildSectionTitle(LangKey.parentHome.frequentlyDeclined),
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child:
                      _buildChips(controller.frequentlyDeclined, true, context),
                ),
              ],
            ),
          ),
          8.verticalSpace,
          Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child:
                      _buildSectionTitle(LangKey.parentHome.favoriteActivities),
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _buildChips(
                      controller.favoriteActivities, false, context),
                ),
                24.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _buildSectionTitle(LangKey.parentHome.lowEngagement),
                ),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _buildChips(controller.lowEngagement, false, context),
                ),
              ],
            ),
          ),
          8.verticalSpace,
          Container(
            color: AppColors.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: _buildPersonalitySnapshot(context),
          ),
        ],
      ),
    );
  }

  Widget _buildRecurringActivitiesSection(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSectionTitle('Recurring Activities'),
              ),
              TextButton.icon(
                onPressed: () => _showAddRecurringActivitySheet(context),
                icon: Icon(IconsaxPlusLinear.add, size: 18.w),
                label: const Text('Add'),
              ),
            ],
          ),
          12.verticalSpace,
          Obx(() {
            if (controller.isLoadingActivities.value) {
              return SkeletonWrapper(
                isLoading: true,
                child: Column(
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _RecurringActivityTile(
                        title: 'Loading activity',
                        subtitle: 'MON, WED • 19:00 - 20:00',
                        isDeleting: false,
                        onDelete: () {},
                      ),
                    ),
                  ),
                ),
              );
            }

            if (controller.recurringActivities.isEmpty) {
              return const _EmptyStateRow(
                icon: IconsaxPlusLinear.calendar_remove,
                text: 'No recurring activities yet.',
              );
            }

            return Column(
              children: controller.recurringActivities.map((activity) {
                final id = activity['id']?.toString() ?? '';
                final days = controller.formatDays(activity['days']);
                final time = controller.formatActivityTime(activity);
                final subtitle = [
                  if (days.isNotEmpty) days,
                  if (time.isNotEmpty) time,
                ].join(' • ');
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _RecurringActivityTile(
                    title: activity['name']?.toString() ?? 'Activity',
                    subtitle: subtitle,
                    isDeleting: controller.isDeletingActivity(id),
                    onDelete: id.isEmpty
                        ? null
                        : () => _confirmDeleteRecurringActivity(id),
                  ),
                );
              }).toList(growable: false),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _showAddRecurringActivitySheet(BuildContext context) async {
    final nameController = TextEditingController();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
            decoration: BoxDecoration(
              color: sheetContext.appColors.elevatedBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add recurring activity',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: sheetContext.appColors.primaryText,
                    ),
                  ),
                  16.verticalSpace,
                  AppFormTextInput(
                    controller: nameController,
                    hint: 'Home education schedule',
                  ),
                  16.verticalSpace,
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: ChildProfileController.weekDays.map((day) {
                      final selected =
                          controller.selectedActivityDays.contains(day);
                      return ChoiceChip(
                        label: Text(day),
                        selected: selected,
                        onSelected: (_) => controller.toggleActivityDay(day),
                      );
                    }).toList(growable: false),
                  ),
                  16.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: _SheetTimeButton(
                          label: 'Start',
                          time: controller.activityStartTime.value,
                          onTap: () async {
                            final value = await showAppTimePicker(
                              context: sheetContext,
                              initialTime: controller.activityStartTime.value,
                            );
                            if (value != null) {
                              controller.selectedStartTime = value;
                            }
                          },
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: _SheetTimeButton(
                          label: 'End',
                          time: controller.activityEndTime.value,
                          onTap: () async {
                            final value = await showAppTimePicker(
                              context: sheetContext,
                              initialTime: controller.activityEndTime.value,
                            );
                            if (value != null) {
                              controller.selectedEndTime = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  AppButton(
                    label: 'Add recurring activity',
                    isLoading: controller.isAddingActivity.value,
                    onPressed: controller.isAddingActivity.value
                        ? null
                        : () async {
                            final didAdd =
                                await controller.addRecurringActivity(
                              name: nameController.text,
                            );
                            if (didAdd && sheetContext.mounted) {
                              Navigator.of(sheetContext).pop();
                            }
                          },
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    nameController.dispose();
  }

  Future<void> _confirmDeleteRecurringActivity(String id) async {
    final confirmed = await showAppConfirmationDialog(
      title: 'Delete recurring activity?',
      message: 'This recurring activity will be removed from this child.',
      confirmLabel: LangKey.parentToday.delete,
      cancelLabel: LangKey.parentToday.cancel,
      confirmButtonColor: AppColors.errorColor,
    );
    if (confirmed ?? false) {
      await controller.deleteRecurringActivity(id);
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GlobalTextStyles.interTextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.headerTextColor,
      ),
    );
  }

  Widget _buildChips(List<String> items, bool filled, BuildContext context) {
    return Obx(() {
      return Wrap(
        spacing: 12.w,
        runSpacing: 12.h,
        children: items.map((item) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: filled
                  ? context.appColors.primaryBackground
                  : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12.r),
              border: filled
                  ? null
                  : Border.all(color: AppColors.neutral200, width: 1.w),
            ),
            child: Text(
              item,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.headerTextColor,
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildPersonalitySnapshot(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(IconsaxPlusBold.magic_star,
              color: AppColors.whiteColor, size: 28.w),
          16.verticalSpace,
          Text(
            LangKey.parentHome.personalitySnapshot,
            textAlign: TextAlign.center,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor,
            ),
          ),
          12.verticalSpace,
          Obx(() => Text(
                '"${controller.personalitySnapshot.value}"',
                textAlign: TextAlign.center,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor.withValues(alpha: 0.9),
                  height: 1.5,
                ),
              )),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, {required this.color});

  final TabBar _tabBar;
  final Color color;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: color,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _ChildAvatarFallback extends StatelessWidget {
  const _ChildAvatarFallback();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.brandTealTrack,
      child: Icon(
        IconsaxPlusLinear.user,
        color: AppColors.primaryColor,
        size: 34.w,
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.08),
        borderRadius: AppBorders.full,
      ),
      child: Text(
        label,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}

class _RecurringActivityTile extends StatelessWidget {
  const _RecurringActivityTile({
    required this.title,
    required this.subtitle,
    required this.isDeleting,
    required this.onDelete,
  });

  final String title;
  final String subtitle;
  final bool isDeleting;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: context.appColors.primaryBackground,
        borderRadius: AppBorders.lg,
        border: Border.all(color: context.appColors.bottomNavBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.10),
              borderRadius: AppBorders.md,
            ),
            child: Icon(
              IconsaxPlusLinear.calendar_tick,
              size: 20.w,
              color: AppColors.primaryColor,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: context.appColors.primaryText,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  3.verticalSpace,
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      color: context.appColors.secondaryText,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: isDeleting ? null : onDelete,
            icon: isDeleting
                ? SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(
                    IconsaxPlusLinear.trash,
                    size: 20.w,
                    color: context.colors.error,
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptyStateRow extends StatelessWidget {
  const _EmptyStateRow({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.appColors.primaryBackground,
        borderRadius: AppBorders.lg,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.w, color: context.appColors.secondaryText),
          10.horizontalSpace,
          Expanded(
            child: Text(
              text,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 13.sp,
                color: context.appColors.secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetTimeButton extends StatelessWidget {
  const _SheetTimeButton({
    required this.label,
    required this.time,
    required this.onTap,
  });

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.md,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: appFormInputBoxDecoration(context),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '$label ${_formatSheetTime(time)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 13.sp,
                  color: context.appColors.primaryText,
                ),
              ),
            ),
            Icon(
              IconsaxPlusLinear.clock_1,
              size: 18.w,
              color: context.appColors.secondaryText,
            ),
          ],
        ),
      ),
    );
  }

  String _formatSheetTime(TimeOfDay value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
