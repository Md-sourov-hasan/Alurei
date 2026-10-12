import 'package:alurei/src/features/auth/data/models/user_model.dart';
import 'package:alurei/src/features/edit_profile/domain/entities/edit_profile_result.dart';

class EditProfileResultModel {
  const EditProfileResultModel({
    required this.user,
    this.relationship,
    this.address,
  });

  factory EditProfileResultModel.fromJson(Map<String, Object?> json) {
    final data = json['data'];
    final payload =
        data is Map<Object?, Object?> ? data.cast<String, Object?>() : json;

    final userMap = payload['user'] is Map<Object?, Object?>
        ? (payload['user']! as Map<Object?, Object?>).cast<String, Object?>()
        : payload;

    return EditProfileResultModel(
      user: UserModel.fromJson(userMap),
      relationship:
          (payload['relationship'] ?? payload['relationShip']) as String?,
      address: payload['address'] as String?,
    );
  }

  final UserModel user;
  final String? relationship;
  final String? address;

  EditProfileResult toEntity() {
    return EditProfileResult(
      user: user.toEntity(),
      relationship: relationship,
      address: address,
    );
  }
}
