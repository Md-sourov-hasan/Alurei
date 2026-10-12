import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';

import '../controllers/parent_ai_controller.dart';
import '../widgets/ai_chat_app_bar.dart';
import '../widgets/ai_history_drawer.dart';
import '../widgets/ai_message_composer.dart';
import '../widgets/ai_response_card_bubble.dart';
import '../widgets/ai_suggestion_chips_bar.dart';
import '../widgets/ai_user_message_bubble.dart';

class ParentAiScreen extends GetView<ParentAiController> {
  ParentAiScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AiChatAppBar(
        onBack: () => Get.back(),
        onHistory: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
      endDrawer: const AiHistoryDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final msgs = controller.messages.toList();
              final loading = controller.isLoading.value;
              return ListView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: msgs.length + (loading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < msgs.length) {
                    final message = msgs[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: message.isUser
                          ? AiUserMessageBubble(message: message)
                          : AiResponseCardBubble(message: message),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: AppLoading(),
                    ),
                  );
                },
              );
            }),
          ),
          Obx(() {
            final items = controller.suggestions.toList();
            return AiSuggestionChipsBar(
              suggestions: items,
              onSelectSuggestion: controller.sendMessage,
            );
          }),
          AiMessageComposer(
            textController: controller.textController,
            onSend: controller.sendMessage,
            onMicPressed: controller.onMicPressed,
            onAttachmentPressed: controller.onAttachmentPressed,
          ),
        ],
      ),
    );
  }
}
