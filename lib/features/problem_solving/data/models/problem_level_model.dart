import '../../domain/entities/problem_level_entity.dart';

/// Model for ProblemLevel with JSON serialization
class ProblemLevelModel extends ProblemLevelEntity {
  const ProblemLevelModel({
    required super.level,
    required super.name,
    required super.displayName,
    required super.totalScore,
    required super.accuracyScore,
    required super.efficiencyScore,
    required super.readabilityScore,
    required super.imagePath,
  });

  /// Create from JSON map
  factory ProblemLevelModel.fromJson(Map<String, dynamic> json) {
    return ProblemLevelModel(
      level: json['level'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      totalScore: json['totalScore'] as int? ?? 0,
      accuracyScore: json['accuracyScore'] as int? ?? 0,
      efficiencyScore: json['efficiencyScore'] as int? ?? 0,
      readabilityScore: json['readabilityScore'] as int? ?? 0,
      imagePath: json['imagePath'] as String? ?? '',
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'name': name,
      'displayName': displayName,
      'totalScore': totalScore,
      'accuracyScore': accuracyScore,
      'efficiencyScore': efficiencyScore,
      'readabilityScore': readabilityScore,
      'imagePath': imagePath,
    };
  }

  /// Create from entity
  factory ProblemLevelModel.fromEntity(ProblemLevelEntity entity) {
    return ProblemLevelModel(
      level: entity.level,
      name: entity.name,
      displayName: entity.displayName,
      totalScore: entity.totalScore,
      accuracyScore: entity.accuracyScore,
      efficiencyScore: entity.efficiencyScore,
      readabilityScore: entity.readabilityScore,
      imagePath: entity.imagePath,
    );
  }
}
