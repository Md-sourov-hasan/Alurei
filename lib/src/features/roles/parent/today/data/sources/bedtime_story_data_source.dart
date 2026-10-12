import 'package:alurei/src/shared/dummy_data/dummy_data.dart';

abstract interface class BedtimeStoryDataSource {
  Future<Map<String, Object?>> loadStory({
    required String childId,
    required String childName,
  });
}

class DummyBedtimeStoryDataSource implements BedtimeStoryDataSource {
  @override
  Future<Map<String, Object?>> loadStory({
    required String childId,
    required String childName,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return {
      ...BedtimeStoryDummyData.story,
      'child_name': childName,
      'hero_label': 'Hero: $childName',
      'cover_title': "$childName story inspired by today's adventures.",
    };
  }
}
