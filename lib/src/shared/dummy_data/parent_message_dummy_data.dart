import '../../features/roles/parent/message/data/models/parent_conversation_model.dart';
import '../app_assets.dart';

/// Central dummy conversations fixture for Parent Messages based on Figma node 23315:58207.
final parentMessageDummyConversations = <ParentConversationModel>[
  ParentConversationModel(
    id: '1',
    participantName: 'Deepa Kumari',
    roleTitle: 'Nanny',
    avatarUrl: AppAssets.parentMessageAvatarDeepa,
    lastMessage: "Today's lunch has been....",
    timestamp: DateTime.now(),
    formattedTime: '10:42 AM',
    unreadCount: 1,
    isOnline: true,
    isSelected: true,
  ),
  ParentConversationModel(
    id: '2',
    participantName: 'Monica',
    roleTitle: 'Aunt',
    avatarUrl: AppAssets.parentMessageAvatarMonica,
    lastMessage: "Today's lunch has been....",
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    formattedTime: 'Yesterday',
    unreadCount: 0,
    isOnline: false,
    isSelected: false,
  ),
  ParentConversationModel(
    id: '3',
    participantName: 'Rose',
    roleTitle: 'Sibling',
    avatarUrl: AppAssets.parentMessageAvatarRose,
    lastMessage: "Today's lunch has been....",
    timestamp: DateTime.now().subtract(const Duration(days: 35)),
    formattedTime: '21 June',
    unreadCount: 0,
    isOnline: true,
    isSelected: false,
  ),
];
