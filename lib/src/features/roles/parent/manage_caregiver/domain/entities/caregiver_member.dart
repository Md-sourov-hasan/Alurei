class CaregiverMember {
  const CaregiverMember({
    required this.id,
    required this.name,
    required this.roleCategory,
    required this.status,
    required this.caringFor,
    required this.avatarAsset,
    this.familyRelation,
  });

  final String id;
  final String name;
  final String roleCategory;
  final String status;
  final String caringFor;
  final String avatarAsset;
  final String? familyRelation;

  factory CaregiverMember.fromMap(Map<String, dynamic> map, String categoryKey) {
    String caringForText = '';
    if (map['childNames'] != null && map['childNames'] is List) {
      caringForText = (map['childNames'] as List).join(', ');
    }

    return CaregiverMember(
      id: map['id']?.toString() ?? map['accessId']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      roleCategory: categoryKey.toLowerCase(),
      status: map['status']?.toString().toLowerCase() ?? 'active',
      caringFor: caringForText.isNotEmpty ? caringForText : (map['caring_for']?.toString() ?? ''),
      avatarAsset: map['image']?.toString() ?? map['avatar']?.toString() ?? '',
      familyRelation: map['relationship']?.toString() ?? map['family_relation']?.toString(),
    );
  }
}
