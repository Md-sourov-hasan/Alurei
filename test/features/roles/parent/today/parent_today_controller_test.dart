import 'package:alurei/src/features/roles/parent/today/data/repositories/parent_today_repository_impl.dart';
import 'package:alurei/src/features/roles/parent/today/data/sources/parent_today_data_source.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/controllers/parent_today_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ParentTodayRepositoryImpl repository;

  setUp(() {
    repository = ParentTodayRepositoryImpl(DummyParentTodayDataSource());
  });

  test('dummy repository maps children and ordered routine data', () async {
    final result = await repository.loadToday();
    final today = result.getOrElse((failure) => throw failure);

    expect(today.parentName, 'Monica Steve');
    expect(today.children, hasLength(2));
    expect(today.routine, hasLength(10));
    expect(today.routine.first.state.name, 'past');
    expect(today.routine[3].state.name, 'current');
    expect(today.routine.last.state.name, 'upcoming');
  });

  test('controller selects and adds children through the repository', () async {
    final controller = ParentTodayController(repository);

    await controller.loadToday();
    expect(controller.selectedChildId.value, 'child-eve');

    controller.selectedChild = 'child-rose';
    expect(controller.selectedChildId.value, 'child-rose');

    await controller.addChild();
    expect(controller.data.value?.children, hasLength(3));
    expect(controller.selectedChildId.value, 'new-child-1');
  });

  test('controller exposes functional routine and app-bar actions', () async {
    final controller = ParentTodayController(repository);
    await controller.loadToday();

    controller.toggleRoutineCompletion('outdoor');
    expect(controller.completedRoutineIds, contains('outdoor'));
    controller.toggleRoutineCompletion('outdoor');
    expect(controller.completedRoutineIds, isNot(contains('outdoor')));

    controller.openNotifications();
    controller.openMessages();
    expect(controller.notificationCount.value, 0);
    expect(controller.messageCount.value, 0);

    controller.toggleAiMenu();
    expect(controller.isAiMenuOpen.value, isTrue);
  });
}
