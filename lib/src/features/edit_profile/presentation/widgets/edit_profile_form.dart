import 'package:alurei/src/features/edit_profile/presentation/controllers/edit_profile_controller.dart';
import 'package:alurei/src/features/edit_profile/presentation/widgets/relationship_dropdown.dart';
import 'package:alurei/src/imports/imports.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    super.key,
    required this.controller,
  });

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            label: LangKey.editProfile.name,
            controller: controller.nameController,
            validator: controller.validateName,
            textInputAction: controller.isParent
                ? TextInputAction.next
                : TextInputAction.done,
          ),
          SizedBox(height: AppSpacing.md.h),
          if (controller.isParent) ...[
            RelationshipDropdown(
              initialValue: controller.relationshipController.text,
              onChanged: (value) {
                controller.relationshipController.text = value;
              },
            ),
            SizedBox(height: AppSpacing.md.h),
          ],
          AppTextField(
            label: LangKey.editProfile.email,
            controller: controller.emailController,
            enabled: false,
            suffixIcon: _VerifiedBadge(),
          ),
          SizedBox(height: AppSpacing.md.h),
          AppTextField(
            label: LangKey.editProfile.phone,
            controller: controller.phoneController,
            enabled: false,
            suffixIcon: _VerifiedBadge(),
          ),
          if (controller.isParent) ...[
            SizedBox(height: AppSpacing.md.h),
            AppTextField(
              label: LangKey.editProfile.address,
              controller: controller.addressController,
              maxLines: 2,
              textInputAction: TextInputAction.done,
            ),
          ],
        ],
      ),
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm.w,
        vertical: AppSpacing.xs.h,
      ),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: AppBorders.full,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            IconsaxPlusLinear.verify,
            color: context.colors.onPrimary,
            size: 12.sp,
          ),
          SizedBox(width: AppSpacing.xs.w),
          Text(
            LangKey.editProfile.verified,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colors.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
