import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/bedtime_story_data.dart';
import '../controllers/bedtime_story_controller.dart';
import '../widgets/bedtime_story_widgets.dart';

class BedtimeStoryScreen extends GetView<BedtimeStoryController> {
  const BedtimeStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.parentToday.bedtimeStoryScreenTitle,
        showDivider: true,
        titleFontWeight: FontWeight.w500,
        onPressed: Get.back<void>,
      ),
      body: Obx(() {
        final data = controller.story.value;
        if (controller.isLoading.value) {
          return AppLoading(message: LangKey.parentToday.loading);
        }
        if (data == null) {
          return _BedtimeStoryError(
            message: controller.errorMessage.value ??
                LangKey.parentToday.unableToLoad,
            onRetry: controller.loadStory,
          );
        }
        return _BedtimeStoryContent(data: data, controller: controller);
      }),
    );
  }
}

class _BedtimeStoryContent extends StatelessWidget {
  const _BedtimeStoryContent({
    required this.data,
    required this.controller,
  });

  final BedtimeStoryData data;
  final BedtimeStoryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final generatedPosition = controller.positions[data.generatedTrack.id] ??
          data.generatedTrack.position;
      final generatedDuration = controller.durations[data.generatedTrack.id] ??
          data.generatedTrack.duration;

      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: context.appColors.elevatedBackground,
              padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
              child: BedtimeStoryHeroCard(
                coverAsset: data.coverAsset,
                title: data.coverTitle,
                heroLabel: data.heroLabel,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: context.appColors.elevatedBackground,
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
              child: Column(
                children: [
                  BedtimeStorySectionHeader(
                    title: LangKey.parentToday.alureiBedtimeStories,
                    action: Icon(
                      IconsaxPlusLinear.archive_add,
                      size: 20.sp,
                      color: context.colors.primary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  BedtimeStoryAudioCard(
                    track: data.generatedTrack,
                    title: LangKey.parentToday.listenToStory,
                    position: generatedPosition,
                    duration: generatedDuration,
                    playing: controller.activeTrackId.value ==
                            data.generatedTrack.id &&
                        controller.isPlaying.value,
                    onPlayPause: () =>
                        controller.togglePlayback(data.generatedTrack),
                    onSeek: (value) =>
                        controller.seekTrack(data.generatedTrack, value),
                  ),
                  SizedBox(height: 16.h),
                  BedtimeStoryTranscriptPanel(
                    expanded: controller.transcriptExpanded.value,
                    transcript: data.transcript,
                    onToggle: controller.toggleTranscript,
                  ),
                ],
              ),
            ),
          ),
          if (!controller.isHistory.value)
            SliverToBoxAdapter(
              child: Container(
                color: context.appColors.elevatedBackground,
                margin: EdgeInsets.only(top: 16.h),
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
                child: Column(
                  children: [
                    BedtimeStoryInfoNote(
                      text: LangKey.parentToday.bedtimeStoryGeneratingNotice
                          .replaceAll('{}', data.childName),
                    ),
                    SizedBox(height: 16.h),
                    BedtimeStoryRecorderPanel(
                      recording: controller.isRecording.value,
                      paused: controller.isRecordingPaused.value,
                      duration: controller.recordingDuration.value,
                      level: controller.recordingLevel.value,
                      onRecordToggle: controller.pauseOrResumeRecording,
                      onCancel: () => controller.finishRecording(save: false),
                      onSave: () => _saveRecording(context),
                    ),
                  ],
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Container(
              color: context.appColors.elevatedBackground,
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BedtimeStorySectionHeader(
                    title: LangKey.parentToday.familyBedtimeStories,
                  ),
                  SizedBox(height: 16.h),
                  ...controller.familyTracks.map(
                    (track) => Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: BedtimeStoryAudioCard(
                        track: track,
                        position:
                            controller.positions[track.id] ?? Duration.zero,
                        duration:
                            controller.durations[track.id] ?? track.duration,
                        playing: controller.activeTrackId.value == track.id &&
                            controller.isPlaying.value,
                        backgroundColor: AppColors.bedtimeStoryFamilyPlayer,
                        onPlayPause: () => controller.togglePlayback(track),
                        onSeek: (value) => controller.seekTrack(track, value),
                        onDelete: track.canDelete
                            ? () {
                                showAppConfirmationDialog(
                                  title: 'Delete Story?',
                                  message:
                                      'Are you sure you want to delete this story?\nThis action cannot be undone.',
                                  confirmLabel: 'Delete',
                                  cancelLabel: 'Cancel',
                                  primaryConfirm: true,
                                  confirmButtonColor: AppColors.errorColor,
                                  confirmButtonTextColor: AppColors.whiteColor,
                                  headerIcon: Container(
                                    width: 56.w,
                                    height: 56.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.supportingRedShade,
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        IconsaxPlusLinear.trash,
                                        color: AppColors.errorColor,
                                        size: 28.w,
                                      ),
                                    ),
                                  ),
                                ).then((confirmed) {
                                  if (confirmed ?? false) {
                                    controller.deleteTrack(track);
                                  }
                                });
                              }
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: context.appColors.elevatedBackground,
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
              child: AppButton(
                label: 'View insight',
                onPressed: () {},
                isFullWidth: true,
              ),
            ),
          ),
        ],
      );
    });
  }

  Future<void> _saveRecording(BuildContext context) async {
    await controller.pauseRecording();
    final title = await showAppDialog<String>(
      child: const _SaveRecordingDialog(),
    );
    if (title == null) return;
    await controller.finishRecording(save: true, title: title);
  }
}

class _SaveRecordingDialog extends HookWidget {
  const _SaveRecordingDialog();

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    return Dialog(
      backgroundColor: context.appColors.elevatedBackground,
      shape: const RoundedRectangleBorder(borderRadius: AppBorders.xl),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LangKey.parentToday.saveRecordingTitle,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 20.sp,
                height: 30 / 20,
                fontWeight: FontWeight.w600,
                color: context.appColors.primaryText,
              ),
            ),
            SizedBox(height: 16.h),
            AppTextField(
              controller: textController,
              label: LangKey.parentToday.storyNameLabel,
              hint: LangKey.parentToday.storyNameHint,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(textController),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: LangKey.parentToday.cancel,
                    variant: ButtonVariant.outline,
                    onPressed: () => Get.back<void>(),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: AppButton(
                    label: LangKey.parentToday.saveRecording,
                    onPressed: () => _submit(textController),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submit(TextEditingController controller) {
    final value = controller.text.trim();
    Get.back<String>(
      result: value.isEmpty ? LangKey.parentToday.myBedtimeStory : value,
    );
  }
}

class _BedtimeStoryError extends StatelessWidget {
  const _BedtimeStoryError({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              IconsaxPlusLinear.danger,
              size: 48.sp,
              color: context.colors.error,
            ),
            SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium,
            ),
            SizedBox(height: AppSpacing.md),
            AppButton(
              label: LangKey.parentToday.retry,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
