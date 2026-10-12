import 'package:alurei/src/shared/dummy_data/dummy_data.dart';
import 'package:alurei/src/shared/dummy_data/parent_message_thread_dummy_data.dart';

import '../../domain/repositories/parent_message_repository.dart';
import '../models/parent_chat_message_model.dart';
import '../models/parent_conversation_model.dart';

class ParentMessageRepositoryImpl implements ParentMessageRepository {
  @override
  Future<List<ParentConversationModel>> fetchConversations() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return parentMessageDummyConversations;
  }

  @override
  Future<List<ParentChatMessageModel>> fetchThreadMessages(
      String conversationId) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return parentMessageThreadDummyMessages;
  }

  @override
  Future<ParentChatMessageModel> sendMessage(
      ParentChatMessageModel message) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return message;
  }
}
