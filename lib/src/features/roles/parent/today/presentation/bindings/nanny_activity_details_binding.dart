import 'package:get/get.dart';

import '../../data/repositories/parent_today_repository_impl.dart';
import '../../data/sources/parent_today_data_source.dart';
import '../../domain/repositories/parent_today_repository.dart';
import '../controllers/nanny_activity_details_controller.dart';

class NannyActivityDetailsBinding extends Bindings {
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
    Get.lazyPut<NannyActivityDetailsController>(
      () => NannyActivityDetailsController(Get.find<ParentTodayRepository>()),
    );
  }
}
