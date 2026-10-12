import 'package:alurei/src/features/auth/domain/entities/user.dart';
import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';
import 'package:alurei/src/features/edit_profile/domain/entities/edit_profile_initial_data.dart';
import 'package:alurei/src/features/edit_profile/domain/entities/edit_profile_result.dart';
import 'package:alurei/src/features/home/domain/entities/home_profile.dart';
import 'package:alurei/src/features/home/domain/repositories/home_repository.dart';
import 'package:alurei/src/imports/imports.dart';

class HomeController extends GetxController {
  HomeController({
    required HomeRepository repository,
  }) : _repository = repository;

  final HomeRepository _repository;

  final Rx<HomeProfile?> profile = Rx<HomeProfile?>(null);
  final RxBool isLoading = false.obs;
  final errorMessage = ''.obs;

  AppUserRole get activeRole {
    return profile.value?.user.role ??
        Get.find<SessionController>().user.value?.role ??
        AppUserRole.parent;
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _repository.getCurrentProfile();
    isLoading.value = false;

    result.fold(
      (failure) async {
        if (failure is UnauthorizedFailure) {
          await _expireSession(failure.message);
          return;
        }
        errorMessage.value = failure.message;
      },
      (data) {
        profile.value = data;
        if (Get.isRegistered<SessionController>()) {
          Get.find<SessionController>().acceptAuthenticatedUser(data.user);
        }
      },
    );
  }

  Future<void> _expireSession(String message) async {
    errorMessage.value = message;
    if (Get.isRegistered<SessionController>()) {
      await Get.find<SessionController>().expireSession();
    }
    showGlobalToast(message: message, status: 'warning');
    if (Get.currentRoute != AppRoutes.login) {
      Get.offAllNamed<void>(AppRoutes.login);
    }
  }

  Future<void> onEditProfileTapped() async {
    final data = profile.value;
    final user = data?.user ??
        Get.find<SessionController>().user.value ??
        SessionController.defaultParentUser;

    final updated = await Get.toNamed<dynamic>(
      AppRoutes.editProfile,
      arguments: EditProfileInitialData(
        user: user,
        relationship: data?.parentProfile?.relationship,
        address: data?.parentProfile?.address,
      ),
    );
    if (updated is EditProfileResult) {
      _applyProfileUpdate(updated);
      await fetchProfile();
      _applyProfileUpdate(updated);
    } else if (updated == true) {
      await fetchProfile();
    }
  }

  void _applyProfileUpdate(EditProfileResult result) {
    final currentProfile = profile.value;
    if (currentProfile == null) {
      profile.value = HomeProfile(user: result.user);
      return;
    }

    profile.value = currentProfile.copyWith(
      user: result.user,
      parentProfile: _mergeParentProfile(currentProfile, result),
    );
  }

  ParentHomeProfile? _mergeParentProfile(
    HomeProfile currentProfile,
    EditProfileResult result,
  ) {
    if (result.user.role != AppUserRole.parent) {
      return currentProfile.parentProfile;
    }

    final currentParentProfile = currentProfile.parentProfile;
    if (currentParentProfile == null) {
      return ParentHomeProfile(
        id: '',
        relationship: result.relationship,
        address: result.address,
      );
    }

    return currentParentProfile.copyWith(
      relationship: result.relationship,
      address: result.address,
    );
  }

  void onMembershipTapped() {
    Get.toNamed<void>(AppRoutes.membership);
  }

  void onMyChildrenTapped() {
    Get.toNamed<dynamic>(AppRoutes.myChildren);
  }

  void onRewardsTapped() {
    Get.toNamed<void>(AppRoutes.rewards);
  }

  void onAlureiRewardsTapped() {
    Get.toNamed<void>(AppRoutes.rewards);
  }

  void onMyOffersTapped() {
    Get.toNamed<void>(AppRoutes.myOffer);
  }

  void onMyPortfolioTapped() {
    Get.toNamed<void>(AppRoutes.nannyPortfolio);
  }

  void onDocumentsTapped() {
    Get.toNamed<void>(AppRoutes.parentDocuments);
  }

  void onMyCaregiversTapped() {
    Get.toNamed<void>(AppRoutes.parentManageCaregivers);
  }

  void onSettingsTapped() {
    Get.toNamed<dynamic>(AppRoutes.settings);
  }

  void onLanguageTapped() {
    Get.toNamed<dynamic>(AppRoutes.language);
  }

  void onHelpCenterTapped() {
    showGlobalToast(message: LangKey.parentHome.helpCenter);
  }

  Future<void> onSignOutTapped(BuildContext context) async {
    final confirmed = await showAppConfirmationDialog(
      title: LangKey.nannyHome.signOutConfirmTitle,
      message: LangKey.nannyHome.signOutConfirmMessage,
      confirmLabel: LangKey.parentHome.signOut,
      cancelLabel: LangKey.parentToday.cancel,
      confirmButtonColor: context.colors.error,
    );

    if (confirmed ?? false) {
      await Get.find<SessionController>().logout();
      if (Get.currentRoute != AppRoutes.login) {
        Get.offAllNamed<void>(AppRoutes.login);
      }
    }
  }
}
