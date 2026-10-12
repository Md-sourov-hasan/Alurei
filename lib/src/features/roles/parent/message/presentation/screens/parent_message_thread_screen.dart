import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../shared/app_assets.dart';
import '../../../../../../shared/widgets/app_loading.dart';
import '../../../../../../theme/app_colors.dart';
import '../controllers/parent_message_thread_controller.dart';
import '../widgets/parent_message_bubble_widget.dart';
import '../widgets/parent_message_composer_widget.dart';
import '../widgets/parent_message_header_widget.dart';

/// Parent Chat Message Thread Screen matching Figma node 23315:58284.
class ParentMessageThreadScreen extends GetView<ParentMessageThreadController> {
  const ParentMessageThreadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final conv = controller.conversation.value;
      final String participantName = conv?.participantName ?? 'Deepa Kumari';
      final String avatarUrl = conv?.avatarUrl ?? AppAssets.parentMessageAvatarDeepa;
      final bool isOnline = conv?.isOnline ?? true;

      return Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: ParentMessageHeaderWidget(
          participantName: participantName,
          avatarUrl: avatarUrl,
          isOnline: isOnline,
          statusText: 'Online',
          selectedLanguage: 'En',
          onBackPressed: () => Get.back(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: controller.isLoading.value
                    ? const Center(child: AppLoading())
                    : ListView.builder(
                        controller: controller.scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        itemCount: controller.messages.length,
                        itemBuilder: (context, index) {
                          final message = controller.messages[index];
                          return ParentMessageBubbleWidget(
                            message: message,
                          );
                        },
                      ),
              ),
              ParentMessageComposerWidget(
                textController: controller.textController,
                onSendPressed: controller.sendMessage,
                onAttachmentPressed: controller.onAttachmentPressed,
                onMicPressed: controller.onMicPressed,
              ),
            ],
          ),
        ),
      );
    });
  }
}
