import 'package:alurei/src/utils/utils.dart';

import '../../domain/entities/bedtime_story_data.dart';
import '../../domain/repositories/bedtime_story_repository.dart';
import '../models/bedtime_story_model.dart';
import '../sources/bedtime_story_data_source.dart';

class BedtimeStoryRepositoryImpl implements BedtimeStoryRepository {
  BedtimeStoryRepositoryImpl(this._dataSource);

  final BedtimeStoryDataSource _dataSource;

  @override
  FutureEither<BedtimeStoryData> loadStory({
    required String childId,
    required String childName,
  }) {
    return runTask(() async {
      final payload = await _dataSource.loadStory(
        childId: childId,
        childName: childName,
      );
      return BedtimeStoryModel.fromMap(payload);
    });
  }
}
