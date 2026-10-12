import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../shared/widgets/app_top_bar.dart';
import '../../../../../../theme/app_colors.dart';
import '../controllers/parent_notification_controller.dart';
import '../widgets/parent_notification_item_card.dart';
import '../widgets/parent_notification_section_header.dart';

class ParentNotificationScreen extends GetView<ParentNotificationController> {
  const ParentNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: const AppTopBar(
        title: 'Notifications',
        centerTitle: true,
      ),
      body: Obx(() {
        final today = controller.todayNotifications;
        final thisWeek = controller.thisWeekNotifications;
        final older = controller.olderNotifications;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (today.isNotEmpty) ...[
                const ParentNotificationSectionHeader(title: 'TODAY'),
                ...today.map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ParentNotificationItemCard(
                      notification: item,
                      onTapAction: () =>
                          controller.onNotificationActionTap(item),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
              if (thisWeek.isNotEmpty) ...[
                const ParentNotificationSectionHeader(title: 'This Week'),
                ...thisWeek.map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ParentNotificationItemCard(
                      notification: item,
                      onTapAction: () =>
                          controller.onNotificationActionTap(item),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
              if (older.isNotEmpty) ...[
                const ParentNotificationSectionHeader(title: 'Older'),
                ...older.map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ParentNotificationItemCard(
                      notification: item,
                      onTapAction: () =>
                          controller.onNotificationActionTap(item),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}
