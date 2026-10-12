import 'package:alurei/src/features/auth/domain/entities/user.dart';

class EditProfileResult {
  const EditProfileResult({
    required this.user,
    this.relationship,
    this.address,
  });

  final AppUser user;
  final String? relationship;
  final String? address;
}
