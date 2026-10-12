import 'package:get/get.dart';

import '../../data/repositories/bedtime_story_repository_impl.dart';
import '../../data/sources/bedtime_story_data_source.dart';
import '../../domain/repositories/bedtime_story_repository.dart';
import '../controllers/bedtime_story_controller.dart';

class BedtimeStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BedtimeStoryDataSource>(DummyBedtimeStoryDataSource.new);
    Get.lazyPut<BedtimeStoryRepository>(
      () => BedtimeStoryRepositoryImpl(Get.find<BedtimeStoryDataSource>()),
    );
    Get.lazyPut<BedtimeStoryController>(
      () => BedtimeStoryController(Get.find<BedtimeStoryRepository>()),
    );
  }
}
