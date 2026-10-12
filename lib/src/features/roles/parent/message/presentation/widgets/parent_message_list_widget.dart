import 'package:flutter/material.dart';

import '../../data/models/parent_conversation_model.dart';
import 'parent_message_tile_widget.dart';

/// Conversation list container widget.
class ParentMessageListWidget extends StatelessWidget {
  const ParentMessageListWidget({
    super.key,
    required this.conversations,
    this.onConversationTap,
  });

  final List<ParentConversationModel> conversations;
  final ValueChanged<ParentConversationModel>? onConversationTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final item = conversations[index];
        return ParentMessageTileWidget(
          conversation: item,
          onTap: () => onConversationTap?.call(item),
        );
      },
    );
  }
}
