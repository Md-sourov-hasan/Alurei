import '../../features/roles/parent/message/data/models/parent_chat_message_model.dart';
import '../app_assets.dart';

/// Central dummy thread messages fixture based on Figma Node 23315:58284.
final parentMessageThreadDummyMessages = <ParentChatMessageModel>[
  const ParentChatMessageModel(
    id: 'msg_1',
    senderName: 'Parent',
    text: 'What healthy breakfast can I prepare for Eve tomorrow?',
    formattedTime: '08:30 AM',
    isOutgoing: true,
    isRead: true,
    dateHeader: 'Today',
  ),
  const ParentChatMessageModel(
    id: 'msg_2',
    senderName: 'Deepa Kumari',
    senderAvatar: AppAssets.parentMessageAvatarDeepa,
    text: 'What healthy breakfast can I prepare for Eve tomorrow?',
    formattedTime: '08:30 AM',
    isOutgoing: false,
  ),
  const ParentChatMessageModel(
    id: 'msg_3',
    senderName: 'Deepa Kumari',
    senderAvatar: AppAssets.parentMessageAvatarDeepa,
    text: "Eve enjoyed today's painting session.",
    imageUrl: AppAssets.parentMessageBabyImage,
    formattedTime: '08:30 AM',
    isOutgoing: false,
  ),
  const ParentChatMessageModel(
    id: 'msg_4',
    senderName: 'Parent',
    text: 'What healthy breakfast can I prepare for Eve tomorrow?',
    formattedTime: '08:30 AM',
    isOutgoing: true,
    isRead: true,
  ),
];
