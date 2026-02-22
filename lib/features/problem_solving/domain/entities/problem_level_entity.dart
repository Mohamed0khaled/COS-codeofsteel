import 'package:equatable/equatable.dart';

/// Entity representing a difficulty level with scoring rules
class ProblemLevelEntity extends Equatable {
  final int level;
  final String name;
  final String displayName;
  final int totalScore;
  final int accuracyScore;
  final int efficiencyScore;
  final int readabilityScore;
  final String imagePath;

  const ProblemLevelEntity({
    required this.level,
    required this.name,
    required this.displayName,
    required this.totalScore,
    required this.accuracyScore,
    required this.efficiencyScore,
    required this.readabilityScore,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [
        level,
        name,
        displayName,
        totalScore,
        accuracyScore,
        efficiencyScore,
        readabilityScore,
        imagePath,
      ];

  /// Factory for creating level E (Easiest)
  factory ProblemLevelEntity.levelE() => const ProblemLevelEntity(
        level: 0,
        name: 'E',
        displayName: 'Easy',
        totalScore: 5,
        accuracyScore: 2,
        efficiencyScore: 2,
        readabilityScore: 1,
        imagePath: 'images/levelcards/E.png',
      );

  /// Factory for creating level D
  factory ProblemLevelEntity.levelD() => const ProblemLevelEntity(
        level: 1,
        name: 'D',
        displayName: 'Beginner',
        totalScore: 7,
        accuracyScore: 3,
        efficiencyScore: 3,
        readabilityScore: 1,
        imagePath: 'images/levelcards/D.png',
      );

  /// Factory for creating level C
  factory ProblemLevelEntity.levelC() => const ProblemLevelEntity(
        level: 2,
        name: 'C',
        displayName: 'Intermediate',
        totalScore: 10,
        accuracyScore: 4,
        efficiencyScore: 4,
        readabilityScore: 2,
        imagePath: 'images/levelcards/C.png',
      );

  /// Factory for creating level B
  factory ProblemLevelEntity.levelB() => const ProblemLevelEntity(
        level: 3,
        name: 'B',
        displayName: 'Advanced',
        totalScore: 15,
        accuracyScore: 6,
        efficiencyScore: 6,
        readabilityScore: 3,
        imagePath: 'images/levelcards/B.png',
      );

  /// Factory for creating level A
  factory ProblemLevelEntity.levelA() => const ProblemLevelEntity(
        level: 4,
        name: 'A',
        displayName: 'Expert',
        totalScore: 30,
        accuracyScore: 14,
        efficiencyScore: 14,
        readabilityScore: 2,
        imagePath: 'images/levelcards/A.png',
      );

  /// Factory for creating level A+
  factory ProblemLevelEntity.levelAPlus() => const ProblemLevelEntity(
        level: 5,
        name: 'A+',
        displayName: 'Master',
        totalScore: 50,
        accuracyScore: 22,
        efficiencyScore: 22,
        readabilityScore: 6,
        imagePath: 'images/levelcards/Ap.png',
      );

  /// Factory for creating level S (Hardest)
  factory ProblemLevelEntity.levelS() => const ProblemLevelEntity(
        level: 6,
        name: 'S',
        displayName: 'Legendary',
        totalScore: 70,
        accuracyScore: 30,
        efficiencyScore: 30,
        readabilityScore: 10,
        imagePath: 'images/levelcards/S.png',
      );

  /// Get all available levels
  static List<ProblemLevelEntity> getAllLevels() => [
        ProblemLevelEntity.levelE(),
        ProblemLevelEntity.levelD(),
        ProblemLevelEntity.levelC(),
        ProblemLevelEntity.levelB(),
        ProblemLevelEntity.levelA(),
        ProblemLevelEntity.levelAPlus(),
        ProblemLevelEntity.levelS(),
      ];

  /// Get level by index
  static ProblemLevelEntity getByLevel(int level) {
    switch (level) {
      case 0:
        return ProblemLevelEntity.levelE();
      case 1:
        return ProblemLevelEntity.levelD();
      case 2:
        return ProblemLevelEntity.levelC();
      case 3:
        return ProblemLevelEntity.levelB();
      case 4:
        return ProblemLevelEntity.levelA();
      case 5:
        return ProblemLevelEntity.levelAPlus();
      case 6:
        return ProblemLevelEntity.levelS();
      default:
        return ProblemLevelEntity.levelE();
    }
  }
}
