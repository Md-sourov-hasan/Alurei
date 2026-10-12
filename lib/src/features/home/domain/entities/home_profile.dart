import 'package:alurei/src/features/auth/domain/entities/user.dart';

class HomeProfile {
  const HomeProfile({
    required this.user,
    this.parentProfile,
    this.nannyProfile,
  });

  final AppUser user;
  final ParentHomeProfile? parentProfile;
  final NannyHomeProfile? nannyProfile;

  String? get profilePictureUrl => user.profilePictureUrl;

  HomeProfile copyWith({
    AppUser? user,
    ParentHomeProfile? parentProfile,
    NannyHomeProfile? nannyProfile,
  }) {
    return HomeProfile(
      user: user ?? this.user,
      parentProfile: parentProfile ?? this.parentProfile,
      nannyProfile: nannyProfile ?? this.nannyProfile,
    );
  }

  static const HomeProfile dummyParent = HomeProfile(
    user: AppUser(
      id: 'dummy_parent',
      email: 'monica@example.com',
      fullName: 'Monica Steeve',
      role: AppUserRole.parent,
    ),
    parentProfile: ParentHomeProfile(
      id: 'dummy_parent_profile',
      relationship: 'Mother',
      address: 'Dubai, UAE',
    ),
  );

  static const HomeProfile dummyNanny = HomeProfile(
    user: AppUser(
      id: 'dummy_nanny',
      email: 'deepa@example.com',
      fullName: 'Deepa Kumari',
      role: AppUserRole.nanny,
    ),
    nannyProfile: NannyHomeProfile(
      id: 'dummy_nanny_profile',
      careScore: 90,
    ),
  );
}

class ParentHomeProfile {
  const ParentHomeProfile({
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

  final String id;
  final String? address;
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? relationship;
  final String? membershipPlan;

  ParentHomeProfile copyWith({
    String? id,
    String? address,
    String? street,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? relationship,
    String? membershipPlan,
  }) {
    return ParentHomeProfile(
      id: id ?? this.id,
      address: address ?? this.address,
      street: street ?? this.street,
      city: city ?? this.city,
      country: country ?? this.country,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      relationship: relationship ?? this.relationship,
      membershipPlan: membershipPlan ?? this.membershipPlan,
    );
  }
}

class NannyHomeProfile {
  const NannyHomeProfile({
    required this.id,
    this.careScore,
  });

  final String id;
  final int? careScore;
}
