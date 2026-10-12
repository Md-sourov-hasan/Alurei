import 'package:get/get.dart';

import '../../data/repositories/parent_today_repository_impl.dart';
import '../../data/sources/parent_today_data_source.dart';
import '../../domain/repositories/parent_today_repository.dart';
import '../controllers/parent_today_controller.dart';

class ParentTodayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentTodayDataSource>(ApiParentTodayDataSource.new);
    Get.lazyPut<ParentTodayRepository>(
      () => ParentTodayRepositoryImpl(Get.find<ParentTodayDataSource>()),
    );
    Get.lazyPut<ParentTodayController>(
      () => ParentTodayController(Get.find<ParentTodayRepository>()),
    );
  }
}
