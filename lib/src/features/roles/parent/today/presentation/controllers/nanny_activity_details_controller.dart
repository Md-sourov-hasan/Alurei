import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';
import '../../domain/repositories/parent_today_repository.dart';

class NannyActivityDetailsController extends GetxController {
  NannyActivityDetailsController(this._repository);

  final ParentTodayRepository _repository;

  final details = Rxn<ParentNannyActivityDetailsData>();
  final isLoading = true.obs;
  final errorMessage = RxnString();

  String get taskId {
    final arguments = Get.arguments;
    if (arguments is Map && arguments['task_id'] is String) {
      return arguments['task_id']! as String;
    }
    return 'default';
  }

  @override
  void onInit() {
    super.onInit();
    loadDetails();
  }

  Future<void> loadDetails() async {
    isLoading.value = true;
    errorMessage.value = null;
    final result = await _repository.loadNannyActivityDetails(taskId);
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (value) => details.value = value,
    );
    isLoading.value = false;
  }
}
