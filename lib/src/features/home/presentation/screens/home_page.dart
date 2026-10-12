import 'package:alurei/src/features/auth/domain/entities/user.dart';
import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';
import 'package:alurei/src/features/home/domain/entities/home_profile.dart';
import 'package:alurei/src/features/home/presentation/controllers/home_controller.dart';
import 'package:alurei/src/features/home/presentation/widgets/home_error_view.dart';
import 'package:alurei/src/features/home/presentation/widgets/home_footer.dart';
import 'package:alurei/src/features/home/presentation/widgets/home_profile_card.dart';
import 'package:alurei/src/features/home/presentation/widgets/home_role_menus.dart';
import 'package:alurei/src/imports/imports.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      body: SafeArea(
        child: Obx(() {
          final session = Get.find<SessionController>();
          final currentUser = session.user.value;
          final profile = controller.profile.value;
          final hasError = controller.errorMessage.value.isNotEmpty;

          if (hasError && profile == null) {
            return HomeErrorView(
              message: controller.errorMessage.value,
              onRetry: controller.fetchProfile,
            );
          }

          final displayProfile = profile ??
              _profileFromUser(currentUser) ??
              (controller.activeRole == AppUserRole.nanny
                  ? HomeProfile.dummyNanny
                  : HomeProfile.dummyParent);

          return Skeletonizer(
            enabled:
                controller.isLoading.value || session.isProfileLoading.value,
            child: RefreshIndicator(
              onRefresh: controller.fetchProfile,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg.w,
                  vertical: AppSpacing.xl.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HomeProfileCard(
                      profile: displayProfile,
                      onEditTapped: controller.onEditProfileTapped,
                      onMembershipTapped: controller.onMembershipTapped,
                    ),
                    SizedBox(height: AppSpacing.lg.h),
                    HomeRoleMenus(
                      role: controller.activeRole,
                      controller: controller,
                    ),
                    SizedBox(height: AppSpacing.xl.h),
                    HomeFooter(role: controller.activeRole),
                    SizedBox(height: AppSpacing.xl.h),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  HomeProfile? _profileFromUser(AppUser? user) {
    if (user == null) return null;
    return HomeProfile(
      user: user,
      parentProfile: user.role == AppUserRole.parent
          ? ParentHomeProfile(
              id: user.id,
              relationship: user.relationship,
              address: user.address,
            )
          : null,
    );
  }
}
