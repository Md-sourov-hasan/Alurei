import 'package:alurei/src/services/parent_children_service.dart';
import 'package:alurei/src/shared/dummy_data/dummy_data.dart';
import 'package:alurei/src/utils/utils.dart';

abstract interface class ParentTodayDataSource {
  Future<Map<String, Object?>> loadToday();

  Future<Map<String, Object?>> loadDailyTimeline(String childId);

  Future<Map<String, Object?>> loadChildProfile(String childId);

  Future<Map<String, Object?>> loadNannyProfile(String nannyId);

  Future<Map<String, Object?>> loadNannyActivityDetails(String taskId);

  Future<Map<String, Object?>> loadNannyPortfolio(String nannyId);

  Future<void> saveChildProfile(Map<String, Object?> payload);

  Future<void> deleteChildProfile(String childId);

  Future<void> removeNanny(String nannyId);

  Future<Map<String, Object?>> addChild();
}

class DummyParentTodayDataSource implements ParentTodayDataSource {
  var _addedChildCount = 0;

  @override
  Future<Map<String, Object?>> loadToday() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return ParentTodayDummyData.dashboard;
  }

  @override
  Future<Map<String, Object?>> loadDailyTimeline(String childId) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const {'timeline': <Map<String, Object?>>[]};
  }

  @override
  Future<Map<String, Object?>> loadChildProfile(String childId) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return ParentTodayDummyData.childProfile(childId);
  }

  @override
  Future<Map<String, Object?>> loadNannyProfile(String nannyId) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return ParentTodayDummyData.nannyProfile(nannyId);
  }

  @override
  Future<Map<String, Object?>> loadNannyActivityDetails(String taskId) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return ParentTodayDummyData.nannyActivityDetails(taskId);
  }

  @override
  Future<Map<String, Object?>> loadNannyPortfolio(String nannyId) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return ParentTodayDummyData.nannyPortfolio(nannyId);
  }

  @override
  Future<void> saveChildProfile(Map<String, Object?> payload) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> deleteChildProfile(String childId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> removeNanny(String nannyId) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<Map<String, Object?>> addChild() async {
    _addedChildCount++;
    return ParentTodayDummyData.addedChild(_addedChildCount);
  }
}

class ApiParentTodayDataSource extends DummyParentTodayDataSource {
  ApiParentTodayDataSource({
    ParentChildrenService? parentChildrenService,
  }) : _parentChildrenService =
            parentChildrenService ?? ParentChildrenService.instance;

  final ParentChildrenService _parentChildrenService;

  @override
  Future<Map<String, Object?>> loadToday() async {
    final children = await _unwrap(_parentChildrenService.getChildren());
    return {
      'parent_name': '',
      'avatar_asset': '',
      'notification_count': 0,
      'message_count': 0,
      'children': children
          .map<Map<String, Object?>>((child) => child.cast<String, Object?>())
          .toList(growable: false),
      'routine': const <Map<String, Object?>>[],
    };
  }

  @override
  Future<Map<String, Object?>> loadDailyTimeline(String childId) async {
    final timeline = await _unwrap(
      _parentChildrenService.getChildDailyTimeline(childId),
    );
    return timeline.cast<String, Object?>();
  }

  @override
  Future<void> deleteChildProfile(String childId) async {
    await _unwrap(_parentChildrenService.deleteChild(childId));
  }

  Future<T> _unwrap<T>(FutureEither<T> operation) async {
    final result = await operation;
    return result.fold((failure) => throw failure, (value) => value);
  }
}
