import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/widgets/child_profile/todays_child_profile_widgets.dart';
import 'package:alurei/src/features/roles/parent/manage_caregiver/domain/entities/caregiver_member.dart';
import 'package:alurei/src/features/roles/parent/manage_caregiver/presentation/controllers/manage_caregiver_controller.dart';
import 'package:alurei/src/features/roles/parent/manage_caregiver/presentation/widgets/caregiver_bottom_sheet_widgets.dart';
import 'package:alurei/src/features/roles/parent/manage_caregiver/presentation/widgets/manage_caregiver_widgets.dart';
import 'package:alurei/src/features/roles/parent/manage_caregiver/presentation/widgets/remove_caregiver_dialog.dart';

class ManageCaregiverScreen extends StatelessWidget {
  const ManageCaregiverScreen({super.key});

  ManageCaregiverController get controller {
    if (!Get.isRegistered<ManageCaregiverController>()) {
      Get.put(ManageCaregiverController());
    }
    return Get.find<ManageCaregiverController>();
  }

  void _confirmRemoveCaregiver(BuildContext context, CaregiverMember c) {
    showDialog<void>(
      context: context,
      builder: (_) => RemoveCaregiverDialog(
        name: c.name,
        roleCategory: c.roleCategory,
        onConfirm: () => controller.removeCaregiver(c.id),
      ),
    );
  }

  void _openWhoAreYouInviting(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) => WhoAreYouInvitingBottomSheet(
        onSelectNanny: () {
          Get.find<ManageCaregiverController>().setInviteRole('NANNY');
          Navigator.of(sheetContext).pop();
          _openNannyPermissions(context);
        },
        onSelectParents: () {
          Get.find<ManageCaregiverController>().setInviteRole('PARENT');
          Navigator.of(sheetContext).pop();
          _openParentPermissions(context);
        },
        onSelectFamilyMember: () {
          Navigator.of(sheetContext).pop();
          _openMemberIdentity(context);
        },
      ),
    );
  }

  void _openMemberIdentity(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
        ),
        child: MemberIdentityBottomSheet(
          childName: 'Eve',
          onNext: (data) {
            final controller = Get.find<ManageCaregiverController>();
            controller.setInviteRole('FAMILY_MEMBER', relationship: data['relation']?.toUpperCase());
            Navigator.of(sheetContext).pop();
            _openMembersPermissions(context);
          },
        ),
      ),
    );
  }

  void _openNannyPermissions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) => CaregiverPermissionsBottomSheet(
        title: LangKey.parentToday.nannyAccessPermissions,
        permissions: [
          PermissionItemModel(
            key: 'manageDailyPlans',
            title: LangKey.parentToday.manageDailyPlans,
            description: LangKey.parentToday.manageDailyPlansNannyDesc,
            initialValue: false,
          ),
          PermissionItemModel(
            key: 'manageGroceryLists',
            title: LangKey.parentToday.manageGroceryLists,
            description: LangKey.parentToday.manageGroceryListsNannyDesc,
            initialValue: true,
          ),
          PermissionItemModel(
            key: 'editChildProfile',
            title: LangKey.parentToday.editChildProfile,
            description: LangKey.parentToday.editChildProfileNannyDesc,
            initialValue: false,
          ),
          PermissionItemModel(
            key: 'accessChildInsights',
            title: LangKey.parentToday.accessChildInsights,
            description: LangKey.parentToday.accessChildInsightsNannyDesc,
            initialValue: false,
          ),
        ],
        onNext: (permissions) {
          Get.find<ManageCaregiverController>().setInvitePermissions(permissions);
          Navigator.of(sheetContext).pop();
          _openAssignNannyForm(context);
        },
      ),
    );
  }

  
  void _openNannyManagePermissions(BuildContext context, CaregiverMember caregiver) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) => FutureBuilder<Map<String, bool>?>(
        future: controller.fetchPermissions(caregiver.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CaregiverBottomSheetContainer(
              title: LangKey.parentToday.nannyAccessPermissions,
              showBackButton: true,
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Center(
                  child: CircularProgressIndicator(color: context.colors.primary),
                ),
              ),
            );
          }

          final fetchedMap = snapshot.data ?? {};
          return CaregiverPermissionsBottomSheet(
            title: LangKey.parentToday.nannyAccessPermissions,
            showNoticeBanner: false,
            showNextButton: false,
            showBackButton: true,
            onPermissionToggled: (updated) => controller.updatePermissions(caregiver.id, updated),
            permissions: [
              PermissionItemModel(
                key: 'manageDailyPlans',
                title: LangKey.parentToday.manageDailyPlans,
                description: LangKey.parentToday.manageDailyPlansNannyDesc,
                initialValue: fetchedMap['manageDailyPlans'] ?? false,
              ),
              PermissionItemModel(
                key: 'manageGroceryLists',
                title: LangKey.parentToday.manageGroceryLists,
                description: LangKey.parentToday.manageGroceryListsNannyDesc,
                initialValue: fetchedMap['manageGroceryLists'] ?? true,
              ),
              PermissionItemModel(
                key: 'editChildProfile',
                title: LangKey.parentToday.editChildProfile,
                description: LangKey.parentToday.editChildProfileNannyDesc,
                initialValue: fetchedMap['editChildProfile'] ?? false,
              ),
              PermissionItemModel(
                key: 'accessChildInsights',
                title: LangKey.parentToday.accessChildInsights,
                description: LangKey.parentToday.accessChildInsightsNannyDesc,
                initialValue: fetchedMap['accessChildInsights'] ?? false,
              ),
            ],
          );
        },
      ),
    );
  }

  void _openParentManagePermissions(BuildContext context, CaregiverMember caregiver) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) => FutureBuilder<Map<String, bool>?>(
        future: controller.fetchPermissions(caregiver.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CaregiverBottomSheetContainer(
              title: LangKey.parentToday.parentAccessPermissions,
              showBackButton: true,
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Center(
                  child: CircularProgressIndicator(color: context.colors.primary),
                ),
              ),
            );
          }

          final fetchedMap = snapshot.data ?? {};
          return CaregiverPermissionsBottomSheet(
            title: LangKey.parentToday.parentAccessPermissions,
            showNoticeBanner: false,
            showNextButton: false,
            showBackButton: true,
            onPermissionToggled: (updated) => controller.updatePermissions(caregiver.id, updated),
            permissions: [
              PermissionItemModel(
                key: 'manageDailyPlans',
                title: LangKey.parentToday.manageDailyPlans,
                description: LangKey.parentToday.manageDailyPlansParentDesc,
                initialValue: fetchedMap['manageDailyPlans'] ?? true,
              ),
              PermissionItemModel(
                key: 'manageSubscriptionBilling',
                title: LangKey.parentToday.manageSubscriptionBilling,
                description: LangKey.parentToday.manageSubscriptionBillingDesc,
                initialValue: fetchedMap['manageSubscriptionBilling'] ?? false,
              ),
              PermissionItemModel(
                key: 'manageNanniesFamilyMembers',
                title: LangKey.parentToday.manageNanniesFamilyMembers,
                description: LangKey.parentToday.manageNanniesFamilyMembersDesc,
                initialValue: fetchedMap['manageNanniesFamilyMembers'] ?? true,
              ),
              PermissionItemModel(
                key: 'manageGroceryOrders',
                title: LangKey.parentToday.manageGroceryOrders,
                description: LangKey.parentToday.manageGroceryOrdersDesc,
                initialValue: fetchedMap['manageGroceryOrders'] ?? false,
              ),
              PermissionItemModel(
                key: 'manageChildProfiles',
                title: LangKey.parentToday.manageChildProfiles,
                description: LangKey.parentToday.manageChildProfilesDesc,
                initialValue: fetchedMap['manageChildProfiles'] ?? false,
              ),
              PermissionItemModel(
                key: 'addOrRemoveChildren',
                title: LangKey.parentToday.addOrRemoveChildren,
                description: LangKey.parentToday.addOrRemoveChildrenDesc,
                initialValue: fetchedMap['addOrRemoveChildren'] ?? false,
              ),
            ],
          );
        },
      ),
    );
  }

  void _openFamilyMemberManagePermissions(BuildContext context, CaregiverMember caregiver) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) => FutureBuilder<Map<String, bool>?>(
        future: controller.fetchPermissions(caregiver.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CaregiverBottomSheetContainer(
              title: LangKey.parentToday.familyAccessPermissions,
              showBackButton: true,
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Center(
                  child: CircularProgressIndicator(color: context.colors.primary),
                ),
              ),
            );
          }

          final fetchedMap = snapshot.data ?? {};
          return CaregiverPermissionsBottomSheet(
            title: LangKey.parentToday.familyAccessPermissions,
            showNoticeBanner: false,
            showNextButton: false,
            showBackButton: true,
            onPermissionToggled: (updated) => controller.updatePermissions(caregiver.id, updated),
            permissions: [
              PermissionItemModel(
                key: 'dailyActivitiesRecipes',
                title: LangKey.parentToday.dailyActivitiesRecipes,
                description: LangKey.parentToday.dailyActivitiesRecipesDesc,
                initialValue: fetchedMap['dailyActivitiesRecipes'] ?? true,
              ),
              PermissionItemModel(
                key: 'manageDailyPlans',
                title: LangKey.parentToday.manageDailyPlans,
                description: LangKey.parentToday.manageDailyPlansMemberDesc,
                initialValue: fetchedMap['manageDailyPlans'] ?? false,
              ),
              PermissionItemModel(
                key: 'careTeamManagement',
                title: LangKey.parentToday.careTeamManagement,
                description: LangKey.parentToday.careTeamManagementDesc,
                initialValue: fetchedMap['careTeamManagement'] ?? false,
              ),
              PermissionItemModel(
                key: 'groceryManagement',
                title: LangKey.parentToday.groceryManagement,
                description: LangKey.parentToday.groceryManagementDesc,
                initialValue: fetchedMap['groceryManagement'] ?? false,
              ),
              PermissionItemModel(
                key: 'groceryOrdering',
                title: LangKey.parentToday.groceryOrdering,
                description: LangKey.parentToday.groceryOrderingDesc,
                initialValue: fetchedMap['groceryOrdering'] ?? false,
              ),
              PermissionItemModel(
                key: 'careLearningAccess',
                title: LangKey.parentToday.careLearningAccess,
                description: LangKey.parentToday.careLearningAccessDesc,
                initialValue: fetchedMap['careLearningAccess'] ?? true,
              ),
              PermissionItemModel(
                key: 'nannyDevelopment',
                title: LangKey.parentToday.nannyDevelopment,
                description: LangKey.parentToday.nannyDevelopmentDesc,
                initialValue: fetchedMap['nannyDevelopment'] ?? false,
              ),
              PermissionItemModel(
                key: 'childInsightsProgress',
                title: LangKey.parentToday.childInsightsProgress,
                description: LangKey.parentToday.childInsightsProgressDesc,
                initialValue: fetchedMap['childInsightsProgress'] ?? true,
              ),
              PermissionItemModel(
                key: 'memoriesStories',
                title: LangKey.parentToday.memoriesStories,
                description: LangKey.parentToday.memoriesStoriesDesc,
                initialValue: fetchedMap['memoriesStories'] ?? true,
              ),
            ],
          );
        },
      ),
    );
  }

  void _openParentPermissions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) => CaregiverPermissionsBottomSheet(
        title: LangKey.parentToday.parentAccessPermissions,
        permissions: [
          PermissionItemModel(
            key: 'manageDailyPlans',
            title: LangKey.parentToday.manageDailyPlans,
            description: LangKey.parentToday.manageDailyPlansParentDesc,
            initialValue: true,
          ),
          PermissionItemModel(
            key: 'manageSubscriptionBilling',
            title: LangKey.parentToday.manageSubscriptionBilling,
            description: LangKey.parentToday.manageSubscriptionBillingDesc,
            initialValue: false,
          ),
          PermissionItemModel(
            key: 'manageNanniesFamilyMembers',
            title: LangKey.parentToday.manageNanniesFamilyMembers,
            description: LangKey.parentToday.manageNanniesFamilyMembersDesc,
            initialValue: true,
          ),
          PermissionItemModel(
            key: 'manageGroceryOrders',
            title: LangKey.parentToday.manageGroceryOrders,
            description: LangKey.parentToday.manageGroceryOrdersDesc,
            initialValue: false,
          ),
          PermissionItemModel(
            key: 'manageChildProfiles',
            title: LangKey.parentToday.manageChildProfiles,
            description: LangKey.parentToday.manageChildProfilesDesc,
            initialValue: false,
          ),
        ],
        onNext: (permissions) {
          Get.find<ManageCaregiverController>().setInvitePermissions(permissions);
          Navigator.of(sheetContext).pop();
          _openAssignNannyForm(context);
        },
      ),
    );
  }

  
  void _openMembersPermissions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) => CaregiverPermissionsBottomSheet(
        title: LangKey.parentToday.membersAccessPermissions,
        permissions: [
          PermissionItemModel(
            key: 'dailyActivitiesRecipes',
            title: LangKey.parentToday.dailyActivitiesRecipes,
            description: LangKey.parentToday.dailyActivitiesRecipesDesc,
            initialValue: true,
          ),
          PermissionItemModel(
            key: 'manageDailyPlans',
            title: LangKey.parentToday.manageDailyPlans,
            description: LangKey.parentToday.manageDailyPlansMemberDesc,
            initialValue: false,
          ),
          PermissionItemModel(
            key: 'careTeamManagement',
            title: LangKey.parentToday.careTeamManagement,
            description: LangKey.parentToday.careTeamManagementDesc,
            initialValue: false,
          ),
          PermissionItemModel(
            key: 'groceryManagement',
            title: LangKey.parentToday.groceryManagement,
            description: LangKey.parentToday.groceryManagementDesc,
            initialValue: false,
          ),
          PermissionItemModel(
            key: 'groceryOrdering',
            title: LangKey.parentToday.groceryOrdering,
            description: LangKey.parentToday.groceryOrderingDesc,
            initialValue: false,
          ),
          PermissionItemModel(
            key: 'careLearningAccess',
            title: LangKey.parentToday.careLearningAccess,
            description: LangKey.parentToday.careLearningAccessDesc,
            initialValue: true,
          ),
          PermissionItemModel(
            key: 'nannyDevelopment',
            title: LangKey.parentToday.nannyDevelopment,
            description: LangKey.parentToday.nannyDevelopmentDesc,
            initialValue: false,
          ),
          PermissionItemModel(
            key: 'childInsightsProgress',
            title: LangKey.parentToday.childInsightsProgress,
            description: LangKey.parentToday.childInsightsProgressDesc,
            initialValue: true,
          ),
          PermissionItemModel(
            key: 'memoriesStories',
            title: LangKey.parentToday.memoriesStories,
            description: LangKey.parentToday.memoriesStoriesDesc,
            initialValue: true,
          ),
        ],
        onNext: (permissions) {
          Get.find<ManageCaregiverController>().setInvitePermissions(permissions);
          Navigator.of(sheetContext).pop();
          _openAssignNannyForm(context);
        },
      ),
    );
  }

  
  void _openAssignNannyForm(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
        ),
        child: AssignNannyBottomSheet(
          onInviteSent: (data) async {
            final controller = Get.find<ManageCaregiverController>();
            final success = await controller.sendInvite(
              invitedUserId: data['invitedUserId'],
              invitedName: data['invitedName'],
              invitedEmail: data['invitedEmail'],
              invitedPhone: data['invitedPhone'],
              inviteChannel: data['inviteChannel'] ?? 'EMAIL',
            );
            if (success && context.mounted) {
              await showDialog<void>(
                context: context,
                builder: (_) => const InvitationSentDialog(),
              );
              controller.loadCaregivers();
            }
          },
        ),
      ),
    );
  }

  void _openSelectChild(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) => SelectChildBottomSheet(
        onBack: () {
          Navigator.of(sheetContext).pop();
        },
        onChildSelected: (child) {
          Get.find<ManageCaregiverController>().startInvite(child['id'] as String);
          Navigator.of(sheetContext).pop();
          _openWhoAreYouInviting(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.parentToday.manageCaregivers,
        showDivider: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: context.colors.primary),
          );
        }

        final accountOwners = controller.getByCategory('account_owner');
        final nannies = controller.getByCategory('nanny');
        final parents = controller.getByCategory('parent');
        final familyMembers = controller.getByCategory('family_member');

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (accountOwners.isNotEmpty) ...[
                CaregiverSectionHeader(
                  title: LangKey.parentToday.accountOwner,
                  isSecondary: false,
                ),
                SizedBox(height: 12.h),
                ...accountOwners.map(
                  (c) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CaregiverCard(
                      caregiver: c,
                      onManagePermissions: () =>
                          _openParentManagePermissions(context, c),
                      onRemove: () => _confirmRemoveCaregiver(context, c),
                    ),
                  ),
                ),
              ],
              if (nannies.isNotEmpty) ...[
                CaregiverSectionHeader(
                  title: LangKey.parentToday.nanny,
                  isSecondary: true,
                ),
                SizedBox(height: 12.h),
                ...nannies.map(
                  (c) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CaregiverCard(
                      caregiver: c,
                      onManagePermissions: () =>
                          _openNannyManagePermissions(context, c),
                      onRemove: () => _confirmRemoveCaregiver(context, c),
                    ),
                  ),
                ),
              ],
              if (parents.isNotEmpty) ...[
                CaregiverSectionHeader(
                  title: LangKey.parentToday.parent,
                  isSecondary: false,
                ),
                SizedBox(height: 12.h),
                ...parents.map(
                  (c) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CaregiverCard(
                      caregiver: c,
                      onManagePermissions: () =>
                          _openParentManagePermissions(context, c),
                      onRemove: () => _confirmRemoveCaregiver(context, c),
                    ),
                  ),
                ),
              ],
              if (familyMembers.isNotEmpty) ...[
                CaregiverSectionHeader(
                  title: LangKey.parentToday.familyMember,
                  isSecondary: false,
                ),
                SizedBox(height: 12.h),
                ...familyMembers.map(
                  (c) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CaregiverCard(
                      caregiver: c,
                      onManagePermissions: () =>
                          _openFamilyMemberManagePermissions(context, c),
                      onRemove: () => _confirmRemoveCaregiver(context, c),
                    ),
                  ),
                ),
              ],
              SizedBox(height: 8.h),
              AssignCaregiverDashedButton(
                onPressed: () => _openSelectChild(context),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      }),
    );
  }
}
