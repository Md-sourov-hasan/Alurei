import 'package:alurei/src/utils/utils.dart';

import '../../domain/entities/parent_today_data.dart';
import '../../domain/repositories/parent_today_repository.dart';
import '../models/parent_today_model.dart';
import '../sources/parent_today_data_source.dart';

class ParentTodayRepositoryImpl implements ParentTodayRepository {
  ParentTodayRepositoryImpl(this._dataSource);

  final ParentTodayDataSource _dataSource;

  @override
  FutureEither<ParentTodayData> loadToday() {
    return runTask(() async {
      final payload = await _dataSource.loadToday();
      return ParentTodayModel.fromMap(payload);
    });
  }

  @override
  FutureEither<List<ParentRoutineItem>> loadDailyTimeline(String childId) {
    return runTask(() async {
      final payload = await _dataSource.loadDailyTimeline(childId);
      return ParentTodayModel.timelineFromMap(payload);
    });
  }

  @override
  FutureEither<ParentChildProfileData> loadChildProfile(String childId) {
    return runTask(() async {
      final payload = await _dataSource.loadChildProfile(childId);
      return ParentTodayModel.profileFromMap(payload);
    });
  }

  @override
  FutureEither<ParentNannyProfileData> loadNannyProfile(String nannyId) {
    return runTask(() async {
      final payload = await _dataSource.loadNannyProfile(nannyId);
      return ParentTodayModel.nannyProfileFromMap(payload);
    });
  }

  @override
  FutureEither<ParentNannyActivityDetailsData> loadNannyActivityDetails(
    String taskId,
  ) {
    return runTask(() async {
      final payload = await _dataSource.loadNannyActivityDetails(taskId);
      return ParentTodayModel.nannyActivityDetailsFromMap(payload);
    });
  }

  @override
  FutureEither<ParentNannyPortfolioData> loadNannyPortfolio(String nannyId) {
    return runTask(() async {
      final payload = await _dataSource.loadNannyPortfolio(nannyId);
      return ParentTodayModel.nannyPortfolioFromMap(payload);
    });
  }

  @override
  FutureEither<void> saveChildProfile(Map<String, Object?> payload) {
    return runTask(() async {
      await _dataSource.saveChildProfile(payload);
    });
  }

  @override
  FutureEither<void> deleteChildProfile(String childId) {
    return runTask(() async {
      await _dataSource.deleteChildProfile(childId);
    });
  }

  @override
  FutureEither<void> removeNanny(String nannyId) {
    return runTask(() async {
      await _dataSource.removeNanny(nannyId);
    });
  }

  @override
  FutureEither<ParentTodayChild> addChild() {
    return runTask(() async {
      final child = await _dataSource.addChild();
      return ParentTodayChild(
        id: child['id']! as String,
        name: child['name']! as String,
        hasAllergy: child['has_allergy']! as bool,
        avatarAsset: child['avatar_asset'] as String?,
      );
    });
  }
}
