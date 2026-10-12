import 'package:get/get.dart';

import '../../../../../../routing/app_routes.dart';
import '../../data/models/parent_conversation_model.dart';
import '../../domain/repositories/parent_message_repository.dart';

class ParentMessageController extends GetxController {
  ParentMessageController({
    required this.repository,
  });

  final ParentMessageRepository repository;

  final conversations = <ParentConversationModel>[].obs;
  final isLoading = false.obs;
  final showEmptyState = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadConversations();
  }

  Future<void> loadConversations() async {
    try {
      isLoading.value = true;
      final result = await repository.fetchConversations();
      conversations.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }

  void onManageCaregiversPressed() {
    showEmptyState.value = false;
  }

  void onConversationTap(ParentConversationModel item) {
    final updated = conversations.map((c) {
      return c.copyWith(isSelected: c.id == item.id);
    }).toList();
    conversations.assignAll(updated);
    Get.toNamed(AppRoutes.parentChatMessageThread, arguments: item);
  }
}

