import 'package:alurei/src/utils/utils.dart';

import '../entities/parent_ai_message.dart';

abstract interface class ParentAiRepository {
  FutureEither<List<ParentAiMessage>> loadInitialMessages();

  FutureEither<ParentAiMessage> sendMessage(String text);
}
