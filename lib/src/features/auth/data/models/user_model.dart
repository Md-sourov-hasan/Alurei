import '../../domain/entities/user.dart';

/// Transport model for the backend user payload.
class UserModel {
  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.relationship,
    required this.address,
    required this.preferredLanguage,
    required this.role,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isActive,
    required this.verificationStatus,
  });

  factory UserModel.fromJson(Map<String, Object?> json) {
    return UserModel(
      id: json['id']! as String,
      fullName: json['fullName'] as String?,
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      relationship: (json['relationShip'] ?? json['relationship']) as String?,
      address: json['address'] as String?,
      preferredLanguage: json['preferredLanguage'] as String? ?? 'en',
      role: AppUserRole.fromApi(json['role']! as String),
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? (json['status'] == 'ACTIVE'),
      verificationStatus: json['verificationStatus'] as String?,
    );
  }

  final String id;
  final String? fullName;
  final String email;
  final String? phoneNumber;
  final String? profilePictureUrl;
  final String? relationship;
  final String? address;
  final String preferredLanguage;
  final AppUserRole role;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isActive;
  final String? verificationStatus;

  AppUser toEntity() {
    return AppUser(
      id: id,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      profilePictureUrl: profilePictureUrl,
      relationship: relationship,
      address: address,
      preferredLanguage: preferredLanguage,
      role: role,
      isEmailVerified: isEmailVerified,
      isPhoneVerified: isPhoneVerified,
      isActive: isActive,
      verificationStatus: verificationStatus,
    );
  }

  Map<String, Object?> toStorageMap() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'profilePictureUrl': profilePictureUrl,
        'relationShip': relationship,
        'address': address,
        'preferredLanguage': preferredLanguage,
        'role': role.apiValue,
        'isEmailVerified': isEmailVerified,
        'isPhoneVerified': isPhoneVerified,
        'isActive': isActive,
        'verificationStatus': verificationStatus,
      };
}

/// Successful `/auth/signin` response.
class SignInResponseModel {
  const SignInResponseModel({
    required this.message,
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory SignInResponseModel.fromJson(Map<String, Object?> json) {
    final dataMap = json.containsKey('data') && json['data'] is Map
        ? (json['data']! as Map<Object?, Object?>).cast<String, Object?>()
        : json;

    return SignInResponseModel(
      message: (dataMap['message'] ?? json['message']) as String? ?? '',
      user: UserModel.fromJson(
        (dataMap['user']! as Map<Object?, Object?>).cast<String, Object?>(),
      ),
      accessToken: dataMap['accessToken']! as String,
      refreshToken: dataMap['refreshToken']! as String,
    );
  }

  final String message;
  final UserModel user;
  final String accessToken;
  final String refreshToken;
}
