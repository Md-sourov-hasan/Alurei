import 'dart:io';

import 'package:alurei/src/features/auth/domain/entities/user.dart';
import 'package:alurei/src/features/edit_profile/data/models/edit_profile_result_model.dart';
import 'package:alurei/src/features/edit_profile/domain/entities/edit_profile_result.dart';
import 'package:alurei/src/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:fpdart/fpdart.dart';

class EditProfileRepositoryImpl implements EditProfileRepository {
  EditProfileRepositoryImpl({
    AuthService? authService,
    AuthSessionStorageService? sessionStorage,
  })  : _authService = authService ?? AuthService.instance,
        _sessionStorage = sessionStorage ?? AuthSessionStorageService.instance;

  final AuthService _authService;
  final AuthSessionStorageService _sessionStorage;

  @override
  FutureEither<EditProfileResult> updateProfile({
    required AppUserRole role,
    required String fullName,
    String? phoneNumber,
    String? preferredLanguage,
    String? relationship,
    String? address,
    File? profilePicture,
  }) async {
    final normalizedRelationship = _normalizeRelationship(relationship);

    final fields = <String, dynamic>{
      'fullName': fullName.trim(),
      if (phoneNumber?.trim().isNotEmpty ?? false)
        'phoneNumber': phoneNumber!.trim(),
      if (preferredLanguage?.trim().isNotEmpty ?? false)
        'preferredLanguage': preferredLanguage!.trim(),
      if (role == AppUserRole.parent && normalizedRelationship != null)
        'relationShip': normalizedRelationship,
    };

    final result = await _authService.updateCurrentUser(
      fields: fields,
      profilePicture: profilePicture,
    );

    return result.fold(
      (failure) async => left(failure),
      (payload) async {
        if (payload == null) {
          return left(
              const ServerFailure('Profile update response was empty.'));
        }

        try {
          final entity = EditProfileResultModel.fromJson(payload).toEntity();
          final updatedResult = EditProfileResult(
            user: entity.user,
            relationship: entity.relationship ?? normalizedRelationship,
            address: entity.address,
          );
          final stored = await _sessionStorage.updateStoredUser(
            _toStoredUserMap(updatedResult),
          );
          return stored.fold(
            (failure) {
              AppLogger.error(
                'Failed to persist updated profile locally',
                failure.error,
              );
              return left(failure);
            },
            (_) => right(updatedResult),
          );
        } catch (error, stack) {
          AppLogger.error(
              'Failed to parse profile response: $error', error, stack);
          return left(
            ServerFailure('Invalid profile update response: $error',
                error: error),
          );
        }
      },
    );
  }

  String? _normalizeRelationship(String? value) {
    final normalizedValue = value?.trim().toUpperCase();
    if (normalizedValue == null || normalizedValue.isEmpty) return null;

    const values = {
      'FATHER': 'FATHER',
      'MOTHER': 'MOTHER',
      'GUARDIAN': 'Gurdian',
      'GURDIAN': 'Gurdian',
      'SIBLING': 'SIBLING',
      'GRANDFATHER': 'GRANDFATHER',
      'GRANDMOTHER': 'GRANDMOTHER',
      'UNCLE': 'UNCLE',
      'AUNT': 'AUNT',
      'RELATIVE': 'RELATIVE',
    };

    return values[normalizedValue] ?? normalizedValue;
  }

  Map<String, Object?> _toStoredUserMap(EditProfileResult result) {
    final user = result.user;
    return {
      'id': user.id,
      'fullName': user.fullName,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'profilePictureUrl': user.profilePictureUrl,
      'preferredLanguage': user.preferredLanguage,
      'role': user.role.apiValue,
      'isEmailVerified': user.isEmailVerified,
      'isPhoneVerified': user.isPhoneVerified,
      'isActive': user.isActive,
      'verificationStatus': user.verificationStatus,
      'relationShip': result.relationship,
      'address': result.address,
    };
  }
}
