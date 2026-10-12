import 'dart:io';

import 'package:alurei/src/features/auth/domain/entities/user.dart';
import 'package:alurei/src/features/edit_profile/domain/entities/edit_profile_result.dart';
import 'package:alurei/src/utils/utils.dart';

abstract class EditProfileRepository {
  FutureEither<EditProfileResult> updateProfile({
    required AppUserRole role,
    required String fullName,
    String? phoneNumber,
    String? preferredLanguage,
    String? relationship,
    String? address,
    File? profilePicture,
  });
}
