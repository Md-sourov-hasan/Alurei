import 'dart:async';
import 'dart:io';

import 'package:alurei/src/imports/imports.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';

import '../../domain/entities/bedtime_story_data.dart';
import '../../domain/repositories/bedtime_story_repository.dart';

class BedtimeStoryController extends GetxController {
  BedtimeStoryController(this._repository);

  final BedtimeStoryRepository _repository;
  final AudioPlayer _player = AudioPlayer();
  final AudioRecorder _recorder = AudioRecorder();

  final story = Rxn<BedtimeStoryData>();
  final familyTracks = <BedtimeStoryAudio>[].obs;
  final isLoading = true.obs;
  final errorMessage = RxnString();
  final transcriptExpanded = true.obs;
  final activeTrackId = RxnString();
  final isPlaying = false.obs;
  final positions = <String, Duration>{}.obs;
  final durations = <String, Duration>{}.obs;
  final isRecording = false.obs;
  final isRecordingPaused = false.obs;
  final recordingDuration = Duration.zero.obs;
  final recordingLevel = 0.0.obs;
  final isHistory = false.obs;

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration>? _durationSub;
  StreamSubscription<void>? _completeSub;
  StreamSubscription<PlayerState>? _stateSub;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Timer? _previewTimer;
  Timer? _recordingTimer;
  String? _recordingPath;

  @override
  void onInit() {
    super.onInit();
    _positionSub = _player.onPositionChanged.listen(_setActivePosition);
    _durationSub = _player.onDurationChanged.listen(_setActiveDuration);
    _completeSub = _player.onPlayerComplete.listen((_) => _completePlayback());
    _stateSub = _player.onPlayerStateChanged.listen(_setPlayerState);
    loadStory();
  }

  Future<void> loadStory() async {
    isLoading.value = true;
    errorMessage.value = null;
    final args = Get.arguments;
    final childId = args is Map && args['child_id'] is String
        ? args['child_id']! as String
        : 'child-eve';
    final childName = args is Map && args['child_name'] is String
        ? args['child_name']! as String
        : 'Eve';
    isHistory.value = args is Map && args['isHistory'] == true;

    final result = await _repository.loadStory(
      childId: childId,
      childName: childName,
    );
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (value) {
        story.value = value;
        familyTracks.assignAll(value.familyTracks);
        _seedTrack(value.generatedTrack);
        for (final track in value.familyTracks) {
          _seedTrack(track);
        }
      },
    );
    isLoading.value = false;
  }

  void toggleTranscript() => transcriptExpanded.toggle();

  Future<void> togglePlayback(BedtimeStoryAudio track) async {
    if (activeTrackId.value == track.id && isPlaying.value) {
      await pausePlayback();
      return;
    }
    if (isRecording.value) {
      await finishRecording(save: false);
    }
    await _player.stop();
    _previewTimer?.cancel();
    activeTrackId.value = track.id;
    isPlaying.value = true;

    final source = _sourceForTrack(track);
    if (source == null) {
      _startPreviewTimer(track.id);
      return;
    }

    try {
      await _player.play(source);
      final position = positions[track.id] ?? Duration.zero;
      if (position > Duration.zero) await _player.seek(position);
    } catch (error, stackTrace) {
      AppLogger.error('Unable to play bedtime story audio', [
        error,
        stackTrace,
      ]);
      _completePlayback();
      showGlobalToast(
        message: LangKey.parentToday.bedtimeStoryPlaybackError,
        status: 'error',
      );
    }
  }

  Future<void> pausePlayback() async {
    await _player.pause();
    _previewTimer?.cancel();
    isPlaying.value = false;
  }

  Future<void> seekTrack(BedtimeStoryAudio track, double value) async {
    final next = Duration(seconds: value.round());
    positions[track.id] = next;
    positions.refresh();
    if (activeTrackId.value == track.id && _sourceForTrack(track) != null) {
      await _player.seek(next);
    }
  }

  Future<void> startRecording() async {
    if (isRecording.value) return;
    await _player.stop();
    _previewTimer?.cancel();
    activeTrackId.value = null;
    isPlaying.value = false;
    final allowed = await _requestMicrophonePermission();
    if (!allowed) return;

    final directory = await getApplicationDocumentsDirectory();
    final path =
        '${directory.path}/bedtime-story-${DateTime.now().millisecondsSinceEpoch}.m4a';
    try {
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: path,
      );
      _recordingPath = path;
      recordingDuration.value = Duration.zero;
      isRecording.value = true;
      isRecordingPaused.value = false;
      _startRecordingClock();
      _startRecordingAmplitude();
    } catch (error, stackTrace) {
      AppLogger.error('Unable to start bedtime story recording', [
        error,
        stackTrace,
      ]);
      showGlobalToast(
        message: LangKey.parentToday.bedtimeStoryRecordingError,
        status: 'error',
      );
    }
  }

  Future<void> pauseOrResumeRecording() async {
    if (!isRecording.value) {
      await startRecording();
      return;
    }
    if (isRecordingPaused.value) {
      await resumeRecording();
      return;
    }
    await pauseRecording();
  }

  Future<void> pauseRecording() async {
    if (!isRecording.value || isRecordingPaused.value) return;
    try {
      await _recorder.pause();
      _recordingTimer?.cancel();
      _amplitudeSub?.cancel();
      recordingLevel.value = 0;
      isRecordingPaused.value = true;
    } catch (error, stackTrace) {
      AppLogger.error('Unable to pause bedtime story recording', [
        error,
        stackTrace,
      ]);
      showGlobalToast(
        message: LangKey.parentToday.bedtimeStoryRecordingError,
        status: 'error',
      );
    }
  }

  Future<void> resumeRecording() async {
    if (!isRecording.value || !isRecordingPaused.value) return;
    try {
      await _recorder.resume();
      isRecordingPaused.value = false;
      _startRecordingClock();
      _startRecordingAmplitude();
    } catch (error, stackTrace) {
      AppLogger.error('Unable to resume bedtime story recording', [
        error,
        stackTrace,
      ]);
      showGlobalToast(
        message: LangKey.parentToday.bedtimeStoryRecordingError,
        status: 'error',
      );
    }
  }

  Future<void> finishRecording({
    required bool save,
    String? title,
  }) async {
    if (!isRecording.value) return;
    _recordingTimer?.cancel();
    _amplitudeSub?.cancel();
    recordingLevel.value = 0;
    isRecording.value = false;
    isRecordingPaused.value = false;
    String? path;
    try {
      path = await _recorder.stop() ?? _recordingPath;
    } catch (error, stackTrace) {
      AppLogger.error('Unable to stop bedtime story recording', [
        error,
        stackTrace,
      ]);
      path = _recordingPath;
    }
    _recordingPath = null;
    if (!save || path == null) {
      await _deleteFile(path);
      recordingDuration.value = Duration.zero;
      return;
    }

    final duration = recordingDuration.value.inSeconds < 1
        ? const Duration(seconds: 1)
        : recordingDuration.value;
    final recordingTitle = title?.trim();
    final track = BedtimeStoryAudio(
      id: 'recording-${DateTime.now().microsecondsSinceEpoch}',
      title: recordingTitle?.isNotEmpty ?? false
          ? recordingTitle!
          : LangKey.parentToday.myBedtimeStory,
      duration: duration,
      position: Duration.zero,
      canDelete: true,
      filePath: path,
    );
    familyTracks.insert(0, track);
    _seedTrack(track);
    recordingDuration.value = Duration.zero;
  }

  void _startRecordingClock() {
    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => recordingDuration.value += const Duration(seconds: 1),
    );
  }

  void _startRecordingAmplitude() {
    _amplitudeSub?.cancel();
    _amplitudeSub = _recorder
        .onAmplitudeChanged(const Duration(milliseconds: 120))
        .listen(_setRecordingAmplitude);
  }

  Future<void> deleteTrack(BedtimeStoryAudio track) async {
    if (!track.canDelete) return;
    if (activeTrackId.value == track.id) {
      await _player.stop();
      _previewTimer?.cancel();
      activeTrackId.value = null;
      isPlaying.value = false;
    }
    familyTracks.removeWhere((item) => item.id == track.id);
    positions.remove(track.id);
    durations.remove(track.id);
    await _deleteFile(track.filePath);
  }

  void _seedTrack(BedtimeStoryAudio track) {
    positions[track.id] = track.position;
    durations[track.id] = track.duration;
  }

  Source? _sourceForTrack(BedtimeStoryAudio track) {
    if (track.filePath != null) return DeviceFileSource(track.filePath!);
    if (track.assetPath != null) return AssetSource(track.assetPath!);
    return null;
  }

  Future<bool> _requestMicrophonePermission() async {
    if (await _recorder.hasPermission()) return true;

    showGlobalToast(
      message: LangKey.parentToday.microphonePermissionRequired,
      status: 'error',
    );
    return false;
  }

  void _setRecordingAmplitude(Amplitude amplitude) {
    final normalized = ((amplitude.current + 60) / 60).clamp(0.0, 1.0);
    recordingLevel.value = normalized.toDouble();
  }

  void _setPlayerState(PlayerState state) {
    if (activeTrackId.value == null) return;
    isPlaying.value = state == PlayerState.playing;
  }

  void _setActivePosition(Duration position) {
    final id = activeTrackId.value;
    if (id == null) return;
    positions[id] = position;
    positions.refresh();
  }

  void _setActiveDuration(Duration duration) {
    final id = activeTrackId.value;
    if (id == null) return;
    durations[id] = duration;
    durations.refresh();
  }

  void _startPreviewTimer(String id) {
    _previewTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final duration = durations[id] ?? Duration.zero;
      final next =
          (positions[id] ?? Duration.zero) + const Duration(seconds: 1);
      if (duration > Duration.zero && next >= duration) {
        positions[id] = duration;
        positions.refresh();
        _completePlayback();
        return;
      }
      positions[id] = next;
      positions.refresh();
    });
  }

  void _completePlayback() {
    _previewTimer?.cancel();
    final id = activeTrackId.value;
    if (id != null) {
      final duration = durations[id] ?? Duration.zero;
      if ((positions[id] ?? Duration.zero) >= duration) {
        positions[id] = Duration.zero;
      }
    }
    activeTrackId.value = null;
    isPlaying.value = false;
  }

  Future<void> _deleteFile(String? path) async {
    if (path == null) return;
    try {
      final file = File(path);
      if (await file.exists()) await file.delete();
    } catch (error, stackTrace) {
      AppLogger.error('Unable to delete bedtime story recording', [
        error,
        stackTrace,
      ]);
    }
  }

  @override
  void onClose() {
    _positionSub?.cancel();
    _durationSub?.cancel();
    _completeSub?.cancel();
    _stateSub?.cancel();
    _amplitudeSub?.cancel();
    _previewTimer?.cancel();
    _recordingTimer?.cancel();
    _player.dispose();
    _recorder.dispose();
    super.onClose();
  }
}
