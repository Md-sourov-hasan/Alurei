import 'package:get/get.dart';

import '../../data/repositories/parent_today_repository_impl.dart';
import '../../data/sources/parent_today_data_source.dart';
import '../../domain/repositories/parent_today_repository.dart';
import '../controllers/todays_child_profile_controller.dart';

class TodaysChildProfileBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ParentTodayDataSource>()) {
      Get.lazyPut<ParentTodayDataSource>(DummyParentTodayDataSource.new);
    }
    if (!Get.isRegistered<ParentTodayRepository>()) {
      Get.lazyPut<ParentTodayRepository>(
        () => ParentTodayRepositoryImpl(Get.find<ParentTodayDataSource>()),
      );
    }
    Get.lazyPut<TodaysChildProfileController>(
      () => TodaysChildProfileController(Get.find<ParentTodayRepository>()),
    );
  }
}
