import '../../data/models/parent_chat_message_model.dart';
import '../../data/models/parent_conversation_model.dart';

abstract interface class ParentMessageRepository {
  Future<List<ParentConversationModel>> fetchConversations();
  Future<List<ParentChatMessageModel>> fetchThreadMessages(String conversationId);
  Future<ParentChatMessageModel> sendMessage(ParentChatMessageModel message);
}
