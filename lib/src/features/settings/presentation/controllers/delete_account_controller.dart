import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';
import 'package:alurei/src/features/settings/domain/repositories/settings_repository.dart';
import '../../../../imports/imports.dart';

class DeleteAccountController extends GetxController {
  DeleteAccountController({
    required SettingsRepository repository,
  }) : _repository = repository;

  final SettingsRepository _repository;
  final TextEditingController detailsController = TextEditingController();

  final selectedReason = ''.obs;
  final isLoading = false.obs;

  List<String> get reasons => [
        LangKey.deleteAccountScreen.reasonTooExpensive,
        LangKey.deleteAccountScreen.reasonNotUsingEnough,
        LangKey.deleteAccountScreen.reasonSwitchingProviders,
        LangKey.deleteAccountScreen.reasonSomethingElse,
      ];

  @override
  void onInit() {
    super.onInit();
    selectedReason.value = reasons.first;
  }

  @override
  void onClose() {
    detailsController.dispose();
    super.onClose();
  }

  set reason(String reason) {
    selectedReason.value = reason;
  }

  Future<void> onDeletePressed() async {
    final confirmed = await showAppConfirmationDialog(
      title: LangKey.deleteAccountScreen.confirmTitle,
      message: LangKey.deleteAccountScreen.confirmMessage,
      confirmLabel: LangKey.deleteAccountScreen.delete,
      cancelLabel: LangKey.deleteAccountScreen.cancel,
      confirmButtonColor: AppColors.groceryMissingRed,
    );

    if (confirmed ?? false) {
      await _executeAccountDeletion();
    }
  }

  Future<void> _executeAccountDeletion() async {
    isLoading.value = true;
    AppLogger.info('Submitting delete account request');
    final result = await _repository.deleteAccount(
      reason: selectedReason.value,
      details: detailsController.text.trim(),
    );
    isLoading.value = false;

    await result.fold(
      (failure) async {
        AppLogger.warning('Delete account failed: ${failure.runtimeType}');
        showGlobalToast(message: failure.message, status: 'error');
      },
      (message) async {
        if (Get.isRegistered<SessionController>()) {
          await Get.find<SessionController>().expireSession();
        }

        showGlobalToast(
          message: message.isEmpty
              ? LangKey.deleteAccountScreen.accountDeleted
              : message,
        );
      },
    );
  }
}
