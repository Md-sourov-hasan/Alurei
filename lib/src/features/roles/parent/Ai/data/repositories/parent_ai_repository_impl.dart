import 'package:alurei/src/shared/dummy_data/parent_ai_dummy_data.dart';
import 'package:alurei/src/utils/utils.dart';

import '../../domain/entities/parent_ai_message.dart';
import '../../domain/repositories/parent_ai_repository.dart';

class ParentAiRepositoryImpl implements ParentAiRepository {
  const ParentAiRepositoryImpl();

  @override
  FutureEither<List<ParentAiMessage>> loadInitialMessages() {
    return runTask(() async {
      return ParentAiDummyData.initialMessages;
    });
  }

  @override
  FutureEither<ParentAiMessage> sendMessage(String text) {
    return runTask(() async {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      return ParentAiMessage(
        id: 'reply-${DateTime.now().millisecondsSinceEpoch}',
        text: 'Thank you for your question! Here are personalized suggestions for your child based on your profile details.',
        isUser: false,
        timestamp: DateTime.now(),
        listItems: const [
          'Option A: Balanced nutrition & hydration plan',
          'Option B: Interactive learning activity for today',
        ],
        followUpQuestion: 'Would you like more details on any of these choices?',
      );
    });
  }
}
