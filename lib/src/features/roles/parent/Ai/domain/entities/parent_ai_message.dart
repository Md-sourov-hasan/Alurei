import 'package:flutter/foundation.dart';

@immutable
class ParentAiMessage {
  const ParentAiMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.imageUrl,
    this.listItems = const [],
    this.followUpQuestion,
  });

  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? imageUrl;
  final List<String> listItems;
  final String? followUpQuestion;
}
