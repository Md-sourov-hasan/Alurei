import 'package:alurei/src/imports/imports.dart';

class ManageCaregiverService {
  ManageCaregiverService._();
  static final ManageCaregiverService instance = ManageCaregiverService._();

  FutureEither<Map<String, dynamic>> fetchCaregivers() async {
    return runTask(() async {
      final response = await AppConfig.dio.get(ApiEndpoints.manageCaregivers);
      return response.data['data'] as Map<String, dynamic>;
    });
  }

  FutureEither<void> updatePermissions(String accessId, Map<String, dynamic> permissions) async {
    return runTask(() async {
      await AppConfig.dio.patch(
        ApiEndpoints.updateCaregiverPermissions(accessId),
        data: permissions,
      );
    });
  }

  FutureEither<List<dynamic>> fetchPermissions(String accessId) async {
    return runTask(() async {
      final response = await AppConfig.dio.get(
        ApiEndpoints.updateCaregiverPermissions(accessId),
      );
      return response.data['data']['permissionFields'] as List<dynamic>;
    });
  }

  FutureEither<List<dynamic>> fetchChildren() async {
    return runTask(() async {
      final response = await AppConfig.dio.get(
        ApiEndpoints.caregiversChildren,
      );
      return response.data['data'] as List<dynamic>;
    });
  }

  FutureEither<void> inviteCaregiver(String childId, Map<String, dynamic> body) async {
    return runTask(() async {
      await AppConfig.dio.post(
        ApiEndpoints.inviteCaregiver(childId),
        data: body,
      );
    });
  }

  FutureEither<List<dynamic>> fetchNannies({int page = 1, int limit = 20, String? search}) async {
    return runTask(() async {
      final response = await AppConfig.dio.get(
        ApiEndpoints.caregiversNannies(page: page, limit: limit, search: search),
      );
      return response.data['data'] as List<dynamic>;
    });
  }
}
