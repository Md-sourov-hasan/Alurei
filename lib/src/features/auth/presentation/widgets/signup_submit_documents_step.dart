import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';
import 'package:alurei/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:alurei/src/features/auth/data/repositories/auth_repository_impl.dart';

class SignupSubmitDocumentsStep extends HookWidget {
  final void Function(String) onNext;

  const SignupSubmitDocumentsStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final selectedDoc = useState<String?>(null);
    final controller = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController(
            repository: Get.isRegistered<AuthRepository>()
                ? Get.find<AuthRepository>()
                : AuthRepositoryImpl(),
          ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        32.verticalSpace,

        Text(
          'Submit Documents',
          textAlign: TextAlign.center,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
            letterSpacing: -0.64,
          ),
        ),
        12.verticalSpace,

        Text(
          'Choose how you want to verify',
          textAlign: TextAlign.center,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.brandGrayText,
          ),
        ),
        48.verticalSpace,

        // Passport Card
        _buildDocCard(
          title: 'Passport',
          subtitle: "You'll need to capture a photo of your passport.",
          icon: IconsaxPlusBold.book_1,
          isSelected: selectedDoc.value == 'passport',
          onTap: () => selectedDoc.value = 'passport',
        ),

        24.verticalSpace,

        Center(
          child: Text(
            LangKey.auth.orText,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.brandGrayText,
            ),
          ),
        ),

        24.verticalSpace,

        // National ID Card
        _buildDocCard(
          title: 'National ID Card',
          subtitle: "You'll need to capture a photo of your passport.",
          icon: IconsaxPlusBold.cards,
          isSelected: selectedDoc.value == 'id_card',
          onTap: () => selectedDoc.value = 'id_card',
        ),

        48.verticalSpace,

        // Next Button
        Obx(() => AppButton(
              label: 'Next',
              isLoading: controller.isLoading.value,
              isFullWidth: true,
              onPressed: (selectedDoc.value == null || controller.isLoading.value)
                  ? null
                  : () => onNext(selectedDoc.value!),
            )),
        24.verticalSpace,
      ],
    );
  }

  Widget _buildDocCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F1F2) : AppColors.primaryBackgroundColor,
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : const Color(0xFFD3E0E2),
            width: 1.5.w,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFD7EAEB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: 24.w,
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    subtitle,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.brandGrayText,
                      height: 20 / 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
