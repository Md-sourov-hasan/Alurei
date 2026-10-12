import 'package:equatable/equatable.dart';

enum AppUserRole {
  parent('PARENT'),
  nanny('NANNY');

  const AppUserRole(this.apiValue);

  final String apiValue;

  static AppUserRole fromApi(String value) {
    return AppUserRole.values.firstWhere(
      (role) => role.apiValue == value.toUpperCase(),
      orElse: () => throw FormatException('Unsupported user role: $value'),
    );
  }
}

class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.email,
    required this.role,
    this.fullName,
    this.phoneNumber,
    this.profilePictureUrl,
    this.relationship,
    this.address,
    this.preferredLanguage = 'en',
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.isActive = true,
    this.verificationStatus,
  });

  final String id;
  final String email;
  final AppUserRole role;
  final String? fullName;
  final String? phoneNumber;
  final String? profilePictureUrl;
  final String? relationship;
  final String? address;
  final String preferredLanguage;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isActive;
  final String? verificationStatus;

  String? get name => fullName;
  String? get photoUrl => profilePictureUrl;

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => id.isNotEmpty;

  AppUser copyWith({
    String? id,
    String? email,
    AppUserRole? role,
    String? fullName,
    String? phoneNumber,
    String? profilePictureUrl,
    String? relationship,
    String? address,
    String? preferredLanguage,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    bool? isActive,
    String? verificationStatus,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      relationship: relationship ?? this.relationship,
      address: address ?? this.address,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isActive: isActive ?? this.isActive,
      verificationStatus: verificationStatus ?? this.verificationStatus,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        role,
        fullName,
        phoneNumber,
        profilePictureUrl,
        relationship,
        address,
        preferredLanguage,
        isEmailVerified,
        isPhoneVerified,
        isActive,
        verificationStatus,
      ];
}
