import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/features/roles/parent/manage_caregiver/domain/entities/caregiver_member.dart';

class ManageCaregiverController extends GetxController {
  final RxList<CaregiverMember> caregivers = <CaregiverMember>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadCaregivers();
  }

  Future<void> loadCaregivers() async {
    isLoading.value = true;
    final result = await ManageCaregiverService.instance.fetchCaregivers();
    
    result.fold(
      (failure) {
        AppLogger.error('Failed to fetch caregivers: ${failure.message}');
        showGlobalToast(message: failure.message, status: 'error');
      },
      (data) {
        final List<CaregiverMember> list = [];
        final sections = data['sections'] as List<dynamic>?;
        if (sections != null) {
          for (final section in sections) {
            final key = section['key'] as String;
            final items = section['items'] as List<dynamic>? ?? [];
            for (final item in items) {
              list.add(CaregiverMember.fromMap(item as Map<String, dynamic>, key));
            }
          }
        }
        caregivers.assignAll(list);
      },
    );
    isLoading.value = false;
  }

  List<CaregiverMember> getByCategory(String category) {
    return caregivers.where((c) => c.roleCategory == category).toList();
  }

  void removeCaregiver(String id) {
    // TODO: implement API call to remove caregiver
    caregivers.removeWhere((c) => c.id == id);
    showGlobalToast(
      message: LangKey.parentToday.caregiverRemoved,
      status: 'success',
    );
  }

  Future<void> updatePermissions(String accessId, Map<String, bool> permissions) async {
    final result = await ManageCaregiverService.instance.updatePermissions(accessId, permissions);
    
    result.fold(
      (failure) {
        AppLogger.error('Failed to update permissions: ${failure.message}');
        showGlobalToast(message: failure.message, status: 'error');
      },
      (_) {
        // Silently succeed or show a small toast if desired.
        // showGlobalToast(message: 'Permissions updated', status: 'success');
      },
    );
  }

  Future<Map<String, bool>?> fetchPermissions(String accessId) async {
    isLoading.value = true;
    final result = await ManageCaregiverService.instance.fetchPermissions(accessId);
    isLoading.value = false;
    
    return result.fold(
      (failure) {
        AppLogger.error('Failed to fetch permissions: ${failure.message}');
        showGlobalToast(message: failure.message, status: 'error');
        return null;
      },
      (data) {
        final map = <String, bool>{};
        for (final item in data) {
          final itemMap = item as Map<String, dynamic>;
          map[itemMap['key'] as String] = itemMap['value'] as bool? ?? false;
        }
        return map;
      },
    );
  }
  // Invite Draft State
  String? inviteChildId;
  String? inviteRole;
  String? inviteRelationship;
  Map<String, bool> invitePermissions = {};

  void startInvite(String childId) {
    inviteChildId = childId;
    inviteRole = null;
    inviteRelationship = null;
    invitePermissions.clear();
  }

  void setInviteRole(String role, {String? relationship}) {
    inviteRole = role;
    inviteRelationship = relationship;
  }

  void setInvitePermissions(Map<String, bool> permissions) {
    invitePermissions = permissions;
  }

  Future<bool> sendInvite({
    String? invitedUserId,
    String? invitedName,
    String? invitedEmail,
    String? invitedPhone,
    required String inviteChannel,
  }) async {
    if (inviteChildId == null) {
      showGlobalToast(message: 'Child ID is missing', status: 'error');
      return false;
    }

    // Default permissions if they skipped or weren't provided. 
    // The UI should ideally enforce defaults, but we pass whatever is in invitePermissions.
    final body = <String, dynamic>{
      ...invitePermissions,
      'role': inviteRole ?? 'NANNY',
      if (inviteRelationship != null) 'relationship': inviteRelationship,
      if (invitedUserId != null) 'invitedUserId': invitedUserId,
      if (invitedName != null) 'invitedName': invitedName,
      if (invitedEmail != null) 'invitedEmail': invitedEmail,
      if (invitedPhone != null) 'invitedPhone': invitedPhone,
      'inviteChannel': inviteChannel,
    };

    isLoading.value = true;
    final result = await ManageCaregiverService.instance.inviteCaregiver(inviteChildId!, body);
    isLoading.value = false;

    return result.fold(
      (failure) {
        AppLogger.error('Failed to send invite: ${failure.message}');
        showGlobalToast(message: failure.message, status: 'error');
        return false;
      },
      (_) => true,
    );
  }
}
