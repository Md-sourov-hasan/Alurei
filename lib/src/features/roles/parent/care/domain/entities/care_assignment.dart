class CareAssignment {
  const CareAssignment({
    required this.id,
    required this.moduleId,
    required this.childId,
    required this.nannyUserId,
    required this.assignedByUserId,
    required this.status,
    this.pointsEarned = 0,
    this.canRetakeQuiz = true,
    this.startedAt,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String moduleId;
  final String childId;
  final String nannyUserId;
  final String assignedByUserId;
  final String status;
  final int pointsEarned;
  final bool canRetakeQuiz;
  final String? startedAt;
  final String? completedAt;
  final String? createdAt;
  final String? updatedAt;

  factory CareAssignment.fromJson(Map<String, dynamic> json) {
    return CareAssignment(
      id: json['id'] as String? ?? '',
      moduleId: json['moduleId'] as String? ?? '',
      childId: json['childId'] as String? ?? '',
      nannyUserId: json['nannyUserId'] as String? ?? '',
      assignedByUserId: json['assignedByUserId'] as String? ?? '',
      status: json['status'] as String? ?? 'IN_PROGRESS',
      pointsEarned: (json['pointsEarned'] as num?)?.toInt() ?? 0,
      canRetakeQuiz: json['canRetakeQuiz'] as bool? ?? true,
      startedAt: json['startedAt'] as String?,
      completedAt: json['completedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'moduleId': moduleId,
        'childId': childId,
        'nannyUserId': nannyUserId,
        'assignedByUserId': assignedByUserId,
        'status': status,
        'pointsEarned': pointsEarned,
        'canRetakeQuiz': canRetakeQuiz,
        'startedAt': startedAt,
        'completedAt': completedAt,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
