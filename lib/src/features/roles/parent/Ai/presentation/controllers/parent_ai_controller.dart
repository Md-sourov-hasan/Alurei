import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/services/media_service.dart';
import 'package:alurei/src/shared/dummy_data/parent_ai_dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../domain/entities/parent_ai_message.dart';
import '../../domain/repositories/parent_ai_repository.dart';

class ParentAiController extends GetxController {
  ParentAiController(this._repository);

  final ParentAiRepository _repository;

  final messages = <ParentAiMessage>[].obs;
  final suggestions = <String>[].obs;
  final historyItems = <String>[].obs;
  final isLoading = false.obs;

  final textController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  final AudioRecorder _recorder = AudioRecorder();
  final isRecording = false.obs;

  @override
  void onClose() {
    _recorder.dispose();
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> _loadInitialData() async {
    isLoading.value = true;
    suggestions.assignAll(ParentAiDummyData.defaultSuggestions);
    historyItems.assignAll(ParentAiDummyData.defaultHistory);

    final result = await _repository.loadInitialMessages();
    result.fold(
      (failure) {},
      (data) {
        messages.assignAll(data);
      },
    );

    isLoading.value = false;
    _scrollToBottom();
  }

  void selectHistoryItem(String title) {
    sendMessage(title);
  }

  Future<void> sendMessage([String? textOverride]) async {
    final text = (textOverride ?? textController.text).trim();
    if (text.isEmpty) return;

    if (textOverride == null) {
      textController.clear();
    }

    final userMsg = ParentAiMessage(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    messages.add(userMsg);
    _scrollToBottom();

    isLoading.value = true;
    final result = await _repository.sendMessage(text);
    result.fold(
      (failure) {
        isLoading.value = false;
      },
      (responseMsg) {
        messages.add(responseMsg);
        isLoading.value = false;
        _scrollToBottom();
      },
    );
  }

  Future<void> onMicPressed() async {
    try {
      if (isRecording.value) {
        isRecording.value = false;
        showGlobalToast(message: LangKey.shared.voiceRecordedSending);
        sendMessage('🎤 [Voice Message]');
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
        final path =
            '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
        await _recorder.start(const RecordConfig(encoder: AudioEncoder.aacLc),
            path: path);
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
                        sendImageMessage(file.path);
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
                        sendImageMessage(file.path);
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
                        sendImageMessage(files.first.path);
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

  Future<void> sendImageMessage(String imagePath) async {
    final userMsg = ParentAiMessage(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      text: '',
      imageUrl: imagePath,
      isUser: true,
      timestamp: DateTime.now(),
    );

    messages.add(userMsg);
    _scrollToBottom();

    isLoading.value = true;
    final result = await _repository.sendMessage('📷 [Attached Photo]');
    result.fold(
      (failure) {
        isLoading.value = false;
      },
      (responseMsg) {
        messages.add(responseMsg);
        isLoading.value = false;
        _scrollToBottom();
      },
    );
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
}
