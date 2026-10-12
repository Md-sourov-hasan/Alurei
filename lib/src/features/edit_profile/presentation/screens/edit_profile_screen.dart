import 'package:alurei/src/features/edit_profile/presentation/controllers/edit_profile_controller.dart';
import 'package:alurei/src/features/edit_profile/presentation/widgets/edit_profile_avatar_picker.dart';
import 'package:alurei/src/features/edit_profile/presentation/widgets/edit_profile_form.dart';
import 'package:alurei/src/imports/imports.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.editProfile.editProfile,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.ml.w,
            vertical: AppSpacing.lg.h,
          ),
          child: Column(
            children: [
              Obx(
                () => EditProfileAvatarPicker(
                  imageFile: controller.selectedImage.value,
                  photoUrl: controller.initialPhotoUrl,
                  onCameraTap: controller.pickFromCamera,
                  onGalleryTap: controller.pickFromGallery,
                ),
              ),
              SizedBox(height: AppSpacing.xl.h),
              EditProfileForm(controller: controller),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.ml.w),
          child: Obx(
            () => AppButton(
              label: LangKey.editProfile.save,
              isLoading: controller.isSubmitting.value,
              onPressed:
                  controller.isSubmitting.value ? null : controller.submit,
            ),
          ),
        ),
      ),
    );
  }
}
