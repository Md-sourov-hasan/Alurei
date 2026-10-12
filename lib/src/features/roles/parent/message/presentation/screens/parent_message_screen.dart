import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';

import '../controllers/parent_message_controller.dart';
import '../widgets/parent_message_empty_state_widget.dart';
import '../widgets/parent_message_list_widget.dart';

class ParentMessageScreen extends GetView<ParentMessageController> {
  const ParentMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppTopBar(
        title: '',
        centerTitle: true,
        titleWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAssets.icMessageCircle,
              width: 32.w,
              height: 32.w,
            ),
            SizedBox(width: 2.w),
            Text(
              LangKey.parentMessage.title,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.headerTextColor,
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoading());
        }

        if (controller.showEmptyState.value) {
          return ParentMessageEmptyStateWidget(
            onManageCaregiversPressed: controller.onManageCaregiversPressed,
          );
        }

        return ParentMessageListWidget(
          conversations: controller.conversations,
          onConversationTap: controller.onConversationTap,
        );
      }),
    );
  }
}
