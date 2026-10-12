import '../../features/roles/parent/Ai/domain/entities/parent_ai_message.dart';

abstract final class ParentAiDummyData {
  static final List<ParentAiMessage> initialMessages = [
    ParentAiMessage(
      id: 'msg-1',
      text: 'What healthy breakfast can I prepare for Eve tomorrow?',
      isUser: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ParentAiMessage(
      id: 'msg-2',
      text:
          "Based on Eve's preferences and nutrition history, here are three breakfast ideas rich in protein and calcium:",
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      listItems: const [
        'Banana Oat Pancakes',
        'Greek Yogurt with Fresh Fruit',
        'Vegetable Egg Muffins',
      ],
      followUpQuestion:
          'Would you like me to add the ingredients to your grocery list?',
    ),
    ParentAiMessage(
      id: 'msg-3',
      text: 'What healthy breakfast can I prepare for Eve tomorrow?',
      isUser: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ];

  static const List<String> defaultSuggestions = [
    'What should Eve eat today?',
    'Suggest a healthy lunch',
    'Suggest learning activities',
  ];

  static const List<String> defaultHistory = [
    'What healthy breakfast...',
    'Daily Activities & Recipes',
    'Daily Activities & Recipes',
  ];
}
