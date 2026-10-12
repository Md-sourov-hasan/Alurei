import 'package:alurei/src/features/auth/data/models/user_model.dart';
import 'package:alurei/src/features/auth/domain/entities/user.dart';
import 'package:alurei/src/features/home/domain/entities/home_profile.dart';

class HomeProfileModel {
  const HomeProfileModel({
    required this.user,
    this.parentProfile,
    this.nannyProfile,
  });

  factory HomeProfileModel.fromJson(Map<String, Object?> json) {
    final data = json['data'];
    final payload =
        data is Map<Object?, Object?> ? data.cast<String, Object?>() : json;

    final user = UserModel.fromJson(payload);

    final parentPayload = payload['parentProfile'];
    final parentMap =
        parentPayload is Map<Object?, Object?> ? parentPayload : payload;
    final parentProfilePayload = user.role == AppUserRole.parent
        ? {
            ...parentMap.cast<String, Object?>(),
            if (payload['relationShip'] != null)
              'relationShip': payload['relationShip'],
            if (payload['relationship'] != null)
              'relationship': payload['relationship'],
          }
        : null;

    return HomeProfileModel(
      user: user,
      parentProfile: _ParentHomeProfileModel.fromJsonOrNull(
        parentProfilePayload,
      ),
      nannyProfile: _NannyHomeProfileModel.fromJsonOrNull(
        payload['nannyProfile'] ??
            (user.role == AppUserRole.nanny ? payload : null),
      ),
    );
  }

  final UserModel user;
  final _ParentHomeProfileModel? parentProfile;
  final _NannyHomeProfileModel? nannyProfile;

  HomeProfile toEntity() {
    return HomeProfile(
      user: user.toEntity(),
      parentProfile: parentProfile?.toEntity(),
      nannyProfile: nannyProfile?.toEntity(),
    );
  }
}

class _ParentHomeProfileModel {
  const _ParentHomeProfileModel({
    required this.id,
    this.address,
    this.street,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.relationship,
    this.membershipPlan,
  });

  factory _ParentHomeProfileModel.fromJson(Map<String, Object?> json) {
    return _ParentHomeProfileModel(
      id: json['id'] as String? ?? '',
      address: json['address'] as String?,
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      relationship: (json['relationShip'] ?? json['relationship']) as String?,
      membershipPlan: json['membershipPlan'] as String?,
    );
  }

  static _ParentHomeProfileModel? fromJsonOrNull(Object? value) {
    if (value is! Map<Object?, Object?>) return null;
    return _ParentHomeProfileModel.fromJson(value.cast<String, Object?>());
  }

  final String id;
  final String? address;
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? relationship;
  final String? membershipPlan;

  ParentHomeProfile toEntity() {
    return ParentHomeProfile(
      id: id,
      address: address,
      street: street,
      city: city,
      state: state,
      country: country,
      postalCode: postalCode,
      relationship: relationship,
      membershipPlan: membershipPlan,
    );
  }
}

class _NannyHomeProfileModel {
  const _NannyHomeProfileModel({
    required this.id,
    this.careScore,
  });

  factory _NannyHomeProfileModel.fromJson(Map<String, Object?> json) {
    return _NannyHomeProfileModel(
      id: json['id'] as String? ?? '',
      careScore: json['careScore'] as int?,
    );
  }

  static _NannyHomeProfileModel? fromJsonOrNull(Object? value) {
    if (value is! Map<Object?, Object?>) return null;
    return _NannyHomeProfileModel.fromJson(value.cast<String, Object?>());
  }

  final String id;
  final int? careScore;

  NannyHomeProfile toEntity() {
    return NannyHomeProfile(
      id: id,
      careScore: careScore,
    );
  }
}
