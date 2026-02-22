import '../../domain/entities/solution_entity.dart';

/// Model for Solution with JSON serialization
class SolutionModel extends SolutionEntity {
  const SolutionModel({
    required super.id,
    required super.problemId,
    required super.userId,
    required super.code,
    required super.language,
    required super.level,
    required super.submittedAt,
  });

  /// Create from JSON map
  factory SolutionModel.fromJson(Map<String, dynamic> json) {
    return SolutionModel(
      id: json['id'] as String? ?? '',
      problemId: json['problemId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      code: json['code'] as String? ?? '',
      language: json['language'] as String? ?? 'cpp',
      level: json['level'] as int? ?? 0,
      submittedAt: json['submittedAt'] != null
          ? DateTime.parse(json['submittedAt'] as String)
          : DateTime.now(),
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'problemId': problemId,
      'userId': userId,
      'code': code,
      'language': language,
      'level': level,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }

  /// Create from entity
  factory SolutionModel.fromEntity(SolutionEntity entity) {
    return SolutionModel(
      id: entity.id,
      problemId: entity.problemId,
      userId: entity.userId,
      code: entity.code,
      language: entity.language,
      level: entity.level,
      submittedAt: entity.submittedAt,
    );
  }
}
