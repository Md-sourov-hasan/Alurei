import '../../domain/entities/bedtime_story_data.dart';

class BedtimeStoryAudioModel {
  const BedtimeStoryAudioModel._();

  static BedtimeStoryAudio fromMap(Map<String, Object?> map) {
    return BedtimeStoryAudio(
      id: map['id']! as String,
      title: map['title']! as String,
      duration: Duration(seconds: map['duration_seconds']! as int),
      position: Duration(seconds: map['position_seconds']! as int),
      canDelete: map['can_delete']! as bool,
      assetPath: map['asset_path'] as String?,
      filePath: map['file_path'] as String?,
    );
  }
}

class BedtimeStoryModel {
  const BedtimeStoryModel._();

  static BedtimeStoryData fromMap(Map<String, Object?> map) {
    final generatedTrack = map['generated_track']! as Map<String, Object?>;
    final familyTracks = map['family_tracks']! as List<Object?>;

    return BedtimeStoryData(
      childName: map['child_name']! as String,
      coverAsset: map['cover_asset']! as String,
      coverTitle: map['cover_title']! as String,
      heroLabel: map['hero_label']! as String,
      generatedTrack: BedtimeStoryAudioModel.fromMap(generatedTrack),
      transcript: map['transcript']! as String,
      familyTracks: familyTracks
          .cast<Map<String, Object?>>()
          .map(BedtimeStoryAudioModel.fromMap)
          .toList(growable: false),
    );
  }
}
