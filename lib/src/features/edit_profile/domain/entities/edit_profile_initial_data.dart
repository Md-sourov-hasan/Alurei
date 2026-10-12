import 'package:alurei/src/features/auth/domain/entities/user.dart';

class EditProfileInitialData {
  const EditProfileInitialData({
    required this.user,
    this.relationship,
    this.address,
  });

  final AppUser user;
  final String? relationship;
  final String? address;
}
