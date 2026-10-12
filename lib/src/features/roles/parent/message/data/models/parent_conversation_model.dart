class ParentConversationModel {
  const ParentConversationModel({
    required this.id,
    required this.participantName,
    required this.avatarUrl,
    required this.lastMessage,
    required this.timestamp,
    this.roleTitle,
    this.formattedTime,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isSelected = false,
  });

  final String id;
  final String participantName;
  final String avatarUrl;
  final String lastMessage;
  final DateTime timestamp;
  final String? roleTitle;
  final String? formattedTime;
  final int unreadCount;
  final bool isOnline;
  final bool isSelected;

  ParentConversationModel copyWith({
    String? id,
    String? participantName,
    String? avatarUrl,
    String? lastMessage,
    DateTime? timestamp,
    String? roleTitle,
    String? formattedTime,
    int? unreadCount,
    bool? isOnline,
    bool? isSelected,
  }) {
    return ParentConversationModel(
      id: id ?? this.id,
      participantName: participantName ?? this.participantName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      timestamp: timestamp ?? this.timestamp,
      roleTitle: roleTitle ?? this.roleTitle,
      formattedTime: formattedTime ?? this.formattedTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
