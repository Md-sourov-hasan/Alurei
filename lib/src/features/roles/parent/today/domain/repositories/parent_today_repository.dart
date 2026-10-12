import 'package:alurei/src/utils/utils.dart';

import '../entities/parent_today_data.dart';

abstract interface class ParentTodayRepository {
  FutureEither<ParentTodayData> loadToday();

  FutureEither<List<ParentRoutineItem>> loadDailyTimeline(String childId);

  FutureEither<ParentChildProfileData> loadChildProfile(String childId);

  FutureEither<ParentNannyProfileData> loadNannyProfile(String nannyId);

  FutureEither<ParentNannyActivityDetailsData> loadNannyActivityDetails(
    String taskId,
  );

  FutureEither<ParentNannyPortfolioData> loadNannyPortfolio(String nannyId);

  FutureEither<void> saveChildProfile(Map<String, Object?> payload);

  FutureEither<void> deleteChildProfile(String childId);

  FutureEither<void> removeNanny(String nannyId);

  FutureEither<ParentTodayChild> addChild();
}
