import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';
import '../../domain/repositories/parent_today_repository.dart';

class NannyProfileController extends GetxController {
  NannyProfileController(this._repository);

  final ParentTodayRepository _repository;

  final profile = Rxn<ParentNannyProfileData>();
  final selectedTab = ParentNannyProfileTab.overview.obs;
  final isLoading = true.obs;
  final isRemoving = false.obs;
  final errorMessage = RxnString();

  String get nannyId {
    final arguments = Get.arguments;
    if (arguments is Map && arguments['nanny_id'] is String) {
      return arguments['nanny_id']! as String;
    }
    return 'nanny-deepa';
  }

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    errorMessage.value = null;
    final result = await _repository.loadNannyProfile(nannyId);
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (value) => profile.value = value,
    );
    isLoading.value = false;
  }

  set tab(ParentNannyProfileTab tab) => selectedTab.value = tab;

  Future<void> removeNanny() async {
    isRemoving.value = true;
    final result = await _repository.removeNanny(nannyId);
    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (_) {
        showGlobalToast(message: LangKey.parentToday.nannyRemoved);
        Get.until((route) => route.settings.name != AppRoutes.nannyProfile);
      },
    );
    isRemoving.value = false;
  }
}
