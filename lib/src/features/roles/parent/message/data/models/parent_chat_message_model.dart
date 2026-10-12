import 'package:equatable/equatable.dart';

/// Data model representing an individual chat message in the Parent Message Thread.
class ParentChatMessageModel extends Equatable {
  const ParentChatMessageModel({
    required this.id,
    required this.senderName,
    required this.text,
    required this.formattedTime,
    required this.isOutgoing,
    this.senderAvatar,
    this.imageUrl,
    this.isRead = true,
    this.dateHeader,
  });

  final String id;
  final String senderName;
  final String text;
  final String formattedTime;
  final bool isOutgoing;
  final String? senderAvatar;
  final String? imageUrl;
  final bool isRead;
  final String? dateHeader;

  ParentChatMessageModel copyWith({
    String? id,
    String? senderName,
    String? text,
    String? formattedTime,
    bool? isOutgoing,
    String? senderAvatar,
    String? imageUrl,
    bool? isRead,
    String? dateHeader,
  }) {
    return ParentChatMessageModel(
      id: id ?? this.id,
      senderName: senderName ?? this.senderName,
      text: text ?? this.text,
      formattedTime: formattedTime ?? this.formattedTime,
      isOutgoing: isOutgoing ?? this.isOutgoing,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      imageUrl: imageUrl ?? this.imageUrl,
      isRead: isRead ?? this.isRead,
      dateHeader: dateHeader ?? this.dateHeader,
    );
  }

  @override
  List<Object?> get props => [
        id,
        senderName,
        text,
        formattedTime,
        isOutgoing,
        senderAvatar,
        imageUrl,
        isRead,
        dateHeader,
      ];
}
