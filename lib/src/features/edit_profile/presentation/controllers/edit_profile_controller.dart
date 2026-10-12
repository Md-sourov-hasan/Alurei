import 'dart:io';

import 'package:alurei/src/features/auth/domain/entities/user.dart';
import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';
import 'package:alurei/src/features/edit_profile/domain/entities/edit_profile_initial_data.dart';
import 'package:alurei/src/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:alurei/src/imports/imports.dart';

class EditProfileController extends GetxController {
  EditProfileController({
    required EditProfileRepository repository,
  }) : _repository = repository;

  final EditProfileRepository _repository;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final relationshipController = TextEditingController();
  final addressController = TextEditingController();

  final Rx<File?> selectedImage = Rx<File?>(null);
  final isSubmitting = false.obs;
  final errorMessage = ''.obs;

  late AppUser _user;
  String? _initialPhotoUrl;

  AppUserRole get role => _user.role;
  bool get isParent => role == AppUserRole.parent;
  String? get initialPhotoUrl => _initialPhotoUrl;

  @override
  void onInit() {
    super.onInit();
    _hydrate();
  }

  void _hydrate() {
    final args = Get.arguments;
    final fallbackUser = Get.find<SessionController>().user.value;

    final initialData = args is EditProfileInitialData ? args : null;
    _user = initialData?.user ??
        fallbackUser ??
        SessionController.defaultParentUser;
    _initialPhotoUrl = _user.photoUrl;

    nameController.text = _user.name ?? '';
    emailController.text = _user.email;
    phoneController.text = _user.phoneNumber ?? '';
    relationshipController.text = _relationshipApiValue(
      initialData?.relationship,
    );
    addressController.text = initialData?.address ?? '';
  }

  Future<void> pickFromCamera() {
    return _pickImage(ImageSource.camera);
  }

  Future<void> pickFromGallery() {
    return _pickImage(ImageSource.gallery);
  }

  Future<void> _pickImage(ImageSource source) async {
    errorMessage.value = '';
    final result = await MediaService.instance.pickImage(
      source: source,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        showGlobalToast(message: failure.message, status: 'error');
      },
      (file) {
        if (file != null) {
          selectedImage.value = file;
          AppLogger.info('Profile image selected from ${source.name}');
        }
      },
    );
  }

  Future<void> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (isSubmitting.value) return;

    isSubmitting.value = true;
    errorMessage.value = '';
    AppLogger.info('Submitting profile update');

    final result = await _repository.updateProfile(
      role: role,
      fullName: nameController.text,
      phoneNumber: phoneController.text,
      preferredLanguage: _user.preferredLanguage,
      relationship: isParent ? relationshipController.text : null,
      address: isParent ? addressController.text : null,
      profilePicture: selectedImage.value,
    );
    isSubmitting.value = false;

    result.fold(
      (failure) {
        final message = failure.message.isNotEmpty
            ? failure.message
            : LangKey.editProfile.profileUpdateFailed;
        errorMessage.value = message;
        AppLogger.warning('Profile update failed: ${failure.runtimeType}');
        showGlobalToast(message: message, status: 'error');
      },
      (data) {
        Get.find<SessionController>().acceptAuthenticatedUser(data.user);
        AppLogger.info('Profile update completed');
        showGlobalToast(message: LangKey.editProfile.profileUpdated);
        Get.back(result: data);
      },
    );
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LangKey.editProfile.nameRequired;
    }
    return null;
  }

  String _relationshipApiValue(String? value) {
    switch (value?.toUpperCase()) {
      case 'MOTHER':
      case 'INA':
      case 'الأم':
      case 'මව':
        return 'Mother';
      case 'FATHER':
      case 'AMA':
      case 'الأب':
      case 'පියා':
        return 'Father';
      case 'GUARDIAN':
      case 'GURDIAN':
      case 'TAGAPAG-ALAGA':
      case 'ولي الأمر':
      case 'භාරකරු':
        return 'Guardian';
      case 'SIBLING':
      case 'KAPATID':
      case 'الأخ/الأخت':
      case 'සහෝදරයා/සහෝදරිය':
        return 'Sibling';
      case 'GRANDFATHER':
      case 'LOLO':
      case 'الجد':
      case 'සීයා':
        return 'Grandfather';
      case 'GRANDMOTHER':
      case 'LOLA':
      case 'الجدة':
      case 'ආච්චි':
        return 'Grandmother';
      case 'UNCLE':
      case 'TIYO':
      case 'العم/الخال':
      case 'මාමා':
        return 'Uncle';
      case 'AUNT':
      case 'TIYA':
      case 'العمة/الخالة':
      case 'නැන්දා':
        return 'Aunt';
      case 'RELATIVE':
      case 'KAMAG-ANAK':
      case 'قريب':
      case 'ඥාතියෙක්':
        return 'Relative';
      default:
        return (value?.isNotEmpty ?? false) ? value! : 'Father';
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    relationshipController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
