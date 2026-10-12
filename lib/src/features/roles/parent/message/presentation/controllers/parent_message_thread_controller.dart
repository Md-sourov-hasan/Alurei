import 'package:alurei/src/shared/localization/generated/lang_key.g.dart';
import 'package:alurei/src/services/media_service.dart';
import 'package:alurei/src/shared/app_assets.dart';
import 'package:alurei/src/shared/helpers/show_toast.dart';
import 'package:alurei/src/shared/shared.dart';
import 'package:alurei/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../data/models/parent_chat_message_model.dart';
import '../../data/models/parent_conversation_model.dart';
import '../../domain/repositories/parent_message_repository.dart';

class ParentMessageThreadController extends GetxController {
  ParentMessageThreadController({
    required this.repository,
  });

  final ParentMessageRepository repository;

  final AudioRecorder _recorder = AudioRecorder();
  final isRecording = false.obs;

  final Rxn<ParentConversationModel> conversation = Rxn<ParentConversationModel>();
  final messages = <ParentChatMessageModel>[].obs;
  final isLoading = false.obs;

  final textController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is ParentConversationModel) {
      conversation.value = Get.arguments as ParentConversationModel;
    }
    loadThreadMessages();
  }

  Future<void> loadThreadMessages() async {
    try {
      isLoading.value = true;
      final convId = conversation.value?.id ?? '1';
      final result = await repository.fetchThreadMessages(convId);
      messages.assignAll(result);
      _scrollToBottom();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    final String currentTime = _formatCurrentTime();

    final newMessage = ParentChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderName: 'Parent',
      text: text,
      formattedTime: currentTime,
      isOutgoing: true,
      isRead: true,
    );

    textController.clear();
    messages.add(newMessage);
    _scrollToBottom();

    await repository.sendMessage(newMessage);
    _triggerDummyReply();
  }

  Future<void> onMicPressed() async {
    try {
      if (isRecording.value) {
        isRecording.value = false;
        showGlobalToast(message: LangKey.shared.voiceRecordedSending);

        final String currentTime = _formatCurrentTime();
        final newMessage = ParentChatMessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderName: 'Parent',
          text: '🎤 [Voice Message]',
          formattedTime: currentTime,
          isOutgoing: true,
          isRead: true,
        );

        messages.add(newMessage);
        _scrollToBottom();
        await repository.sendMessage(newMessage);
        _triggerDummyReply(contextType: 'voice');
      } else {
        final status = await Permission.microphone.request();
        if (!status.isGranted) {
          if (status.isPermanentlyDenied) {
            showGlobalToast(message: LangKey.shared.enableMicPermission);
            await openAppSettings();
          } else {
            showGlobalToast(message: LangKey.shared.micPermissionDenied);
          }
          return;
        }

        final dir = await getTemporaryDirectory();
        final path = '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
        await _recorder.start(const RecordConfig(encoder: AudioEncoder.aacLc), path: path);
        isRecording.value = true;
        showGlobalToast(message: LangKey.shared.recordingStarted);
      }
    } catch (e) {
      isRecording.value = false;
      showGlobalToast(message: LangKey.shared.failedToRecordVoice);
    }
  }

  Future<void> onAttachmentPressed() async {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: AppColors.whiteBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle bar
              Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.groceryNoteBorder,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              12.verticalSpace,
              ListTile(
                leading: Icon(
                  Icons.camera_alt_rounded,
                  color: AppColors.primaryColor,
                  size: 22.w,
                ),
                title: Text(
                  'Take a photo',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.headerTextColor,
                  ),
                ),
                onTap: () async {
                  Get.back();
                  final result = await MediaService.instance
                      .pickImage(source: ImageSource.camera);
                  result.fold(
                    (failure) => showGlobalToast(
                        message: failure.message.isNotEmpty
                            ? failure.message
                            : 'Camera permission denied or cancelled'),
                    (file) {
                      if (file != null) {
                        _sendImageMessage(file.path);
                      }
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library_rounded,
                  color: AppColors.primaryColor,
                  size: 22.w,
                ),
                title: Text(
                  'Gallery',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.headerTextColor,
                  ),
                ),
                onTap: () async {
                  Get.back();
                  final result = await MediaService.instance
                      .pickImage(source: ImageSource.gallery);
                  result.fold(
                    (failure) => showGlobalToast(
                        message: failure.message.isNotEmpty
                            ? failure.message
                            : 'Gallery permission denied or cancelled'),
                    (file) {
                      if (file != null) {
                        _sendImageMessage(file.path);
                      }
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.insert_drive_file_rounded,
                  color: AppColors.primaryColor,
                  size: 22.w,
                ),
                title: Text(
                  'Document',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.headerTextColor,
                  ),
                ),
                onTap: () async {
                  Get.back();
                  final result = await MediaService.instance.pickFiles();
                  result.fold(
                    (failure) => showGlobalToast(
                        message: failure.message.isNotEmpty
                            ? failure.message
                            : 'File selection cancelled'),
                    (files) {
                      if (files.isNotEmpty) {
                        _sendImageMessage(files.first.path);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendImageMessage(String path) {
    final String currentTime = _formatCurrentTime();
    final newMessage = ParentChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderName: 'Parent',
      text: '',
      imageUrl: path,
      formattedTime: currentTime,
      isOutgoing: true,
      isRead: true,
    );

    messages.add(newMessage);
    _scrollToBottom();
    repository.sendMessage(newMessage);
    _triggerDummyReply(contextType: 'image');
  }

  int _dummyResponseIndex = 0;
  final List<String> _dummyResponses = [
    "Thank you for the message! Everything is going well here. 😊",
    "Got it! I will update you shortly.",
    "Thanks for sharing! I've noted this down for today.",
    "Sounds great! Let me know if you need anything else.",
    "I'm keeping an eye on the schedule and will inform you if anything comes up. 👍",
  ];

  Future<void> _triggerDummyReply({String? contextType}) async {
    final String participantName = conversation.value?.participantName ?? 'Deepa Kumari';
    final String avatarUrl = conversation.value?.avatarUrl ?? AppAssets.parentMessageAvatarDeepa;

    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(milliseconds: 1200));

    String replyText;
    if (contextType == 'image') {
      replyText = "Thank you for sharing the photo! Looks great. 📷";
    } else if (contextType == 'voice') {
      replyText = "Received your voice note! Listening to it now. 🎤";
    } else {
      replyText = _dummyResponses[_dummyResponseIndex % _dummyResponses.length];
      _dummyResponseIndex++;
    }

    final replyMessage = ParentChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderName: participantName,
      text: replyText,
      formattedTime: _formatCurrentTime(),
      isOutgoing: false,
      isRead: true,
      senderAvatar: avatarUrl,
    );

    messages.add(replyMessage);
    _scrollToBottom();
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    _recorder.dispose();
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}

