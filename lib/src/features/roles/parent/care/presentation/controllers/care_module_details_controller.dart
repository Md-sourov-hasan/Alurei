import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/care_module_detail.dart';
import '../../domain/entities/care_module_item.dart';
import 'parent_care_controller.dart';

class CareModuleDetailsController extends GetxController {
  final moduleDetail = Rxn<CareModuleDetail>();
  final selectedOptionId = ''.obs;
  final isAnswered = false.obs;
  final isBookmarked = false.obs;

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is CareModuleItem) {
      isBookmarked.value = args.isBookmarked;
      fetchModuleDetail(args.id);
    } else if (args is String && args.isNotEmpty) {
      fetchModuleDetail(args);
    }
  }

  Future<void> fetchModuleDetail(String moduleId) async {
    isLoading.value = true;
    errorMessage.value = '';

    AppLogger.info(
      '🚀 [CareModuleDetailsController] Fetching module detail via API for id=$moduleId',
    );
    final result = await CareService.instance.getCareModuleDetail(moduleId);
    isLoading.value = false;

    result.fold(
      (failure) {
        AppLogger.error('Failed to fetch module detail: ${failure.message}');
        errorMessage.value = failure.message;
        moduleDetail.value = null;
      },
      (detail) {
        AppLogger.info(
          '✨ [CareModuleDetailsController] Loaded module detail: ${detail.title}',
        );
        moduleDetail.value = detail;
        isBookmarked.value = detail.isSaved;
      },
    );
  }

  void selectOption(String optionId) {
    selectedOptionId.value = optionId;
    isAnswered.value = true;
  }

  Future<void> toggleBookmark() async {
    final detail = moduleDetail.value;
    if (detail == null) return;

    final parentCareController = Get.isRegistered<ParentCareController>()
        ? Get.find<ParentCareController>()
        : null;
    final childId = parentCareController?.selectedChildId ?? '';

    final newBookmark = !isBookmarked.value;
    final result = newBookmark
        ? await CareService.instance.saveCareModule(
            detail.id,
            childId: childId.isNotEmpty ? childId : null,
          )
        : await CareService.instance.unsaveCareModule(
            detail.id,
            childId: childId.isNotEmpty ? childId : null,
          );

    result.fold(
      (failure) => showGlobalToast(message: failure.message),
      (resMap) {
        isBookmarked.value = newBookmark;
        if (Get.isRegistered<ParentCareController>()) {
          final parentCareController = Get.find<ParentCareController>();
          final dummyItem = CareModuleItem(
            id: detail.id,
            title: detail.title,
            durationText: '${detail.estimatedMinutes}m',
            coinsText: '${detail.coinReward} Coins',
            imageUrl: detail.coverImageUrl,
            category: detail.category,
            isBookmarked: !newBookmark,
            childId: childId,
          );
          parentCareController.toggleBookmark(dummyItem);
        } else {
          final message = resMap['message'] as String? ??
              (newBookmark
                  ? 'Care module saved successfully'
                  : 'Care module removed from saved list');
          showGlobalToast(message: message);
        }
      },
    );
  }

  Future<void> assignModule() async {
    final detail = moduleDetail.value;
    if (detail == null) return;

    final parentCareController = Get.isRegistered<ParentCareController>()
        ? Get.find<ParentCareController>()
        : null;

    final childId = parentCareController?.selectedChildId ?? '';
    final nannyUserId = parentCareController?.currentNannyUserId ?? '';

    if (childId.isEmpty) {
      showGlobalToast(message: 'Please select a child first');
      return;
    }

    final result = await CareService.instance.assignCareModule(
      moduleId: detail.id,
      childId: childId,
      nannyUserId: nannyUserId,
    );

    result.fold(
      (failure) => showGlobalToast(message: failure.message),
      (assignment) {
        showGlobalToast(
          message: '${detail.title} ${LangKey.parentCare.addedToWeek.tr()}',
        );
      },
    );
  }
}
