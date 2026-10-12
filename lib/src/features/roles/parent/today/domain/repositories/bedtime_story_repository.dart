import 'package:alurei/src/utils/utils.dart';

import '../entities/bedtime_story_data.dart';

abstract interface class BedtimeStoryRepository {
  FutureEither<BedtimeStoryData> loadStory({
    required String childId,
    required String childName,
  });
}
