import 'package:equatable/equatable.dart';

class BedtimeStoryAudio extends Equatable {
  const BedtimeStoryAudio({
    required this.id,
    required this.title,
    required this.duration,
    required this.position,
    required this.canDelete,
    this.assetPath,
    this.filePath,
  });

  final String id;
  final String title;
  final Duration duration;
  final Duration position;
  final bool canDelete;
  final String? assetPath;
  final String? filePath;

  BedtimeStoryAudio copyWith({
    String? id,
    String? title,
    Duration? duration,
    Duration? position,
    bool? canDelete,
    String? assetPath,
    String? filePath,
  }) {
    return BedtimeStoryAudio(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      canDelete: canDelete ?? this.canDelete,
      assetPath: assetPath ?? this.assetPath,
      filePath: filePath ?? this.filePath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        duration,
        position,
        canDelete,
        assetPath,
        filePath,
      ];
}

class BedtimeStoryData extends Equatable {
  const BedtimeStoryData({
    required this.childName,
    required this.coverAsset,
    required this.coverTitle,
    required this.heroLabel,
    required this.generatedTrack,
    required this.transcript,
    required this.familyTracks,
  });

  final String childName;
  final String coverAsset;
  final String coverTitle;
  final String heroLabel;
  final BedtimeStoryAudio generatedTrack;
  final String transcript;
  final List<BedtimeStoryAudio> familyTracks;

  BedtimeStoryData copyWith({
    String? childName,
    String? coverAsset,
    String? coverTitle,
    String? heroLabel,
    BedtimeStoryAudio? generatedTrack,
    String? transcript,
    List<BedtimeStoryAudio>? familyTracks,
  }) {
    return BedtimeStoryData(
      childName: childName ?? this.childName,
      coverAsset: coverAsset ?? this.coverAsset,
      coverTitle: coverTitle ?? this.coverTitle,
      heroLabel: heroLabel ?? this.heroLabel,
      generatedTrack: generatedTrack ?? this.generatedTrack,
      transcript: transcript ?? this.transcript,
      familyTracks: familyTracks ?? this.familyTracks,
    );
  }

  @override
  List<Object?> get props => [
        childName,
        coverAsset,
        coverTitle,
        heroLabel,
        generatedTrack,
        transcript,
        familyTracks,
      ];
}
