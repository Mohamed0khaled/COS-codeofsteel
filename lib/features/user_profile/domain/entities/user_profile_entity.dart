import 'package:equatable/equatable.dart';

/// User profile entity representing the user's profile data
/// 
/// This entity contains all user-related data stored in Firestore
/// at the path: users/{userId}/userdata/info
class UserProfileEntity extends Equatable {
  final String id;
  final String username;
  final int score;
  final int level;
  final String rank;
  final String? imageUrl;
  final String pspl; // Preferred programming language

  const UserProfileEntity({
    required this.id,
    required this.username,
    required this.score,
    required this.level,
    required this.rank,
    this.imageUrl,
    required this.pspl,
  });

  /// Calculate rank based on score
  static String calculateRank(int score) {
    if (score < 10) return "E";
    if (score < 70) return "D";
    if (score < 150) return "C";
    if (score < 300) return "B";
    if (score < 600) return "A";
    if (score < 1000) return "A+";
    if (score < 1500) return "A++";
    return "S";
  }

  /// Calculate level based on score
  static int calculateLevel(int score) {
    if (score < 10) return 0;
    if (score < 70) return 1;
    if (score < 150) return 2;
    if (score < 300) return 3;
    if (score < 600) return 4;
    if (score < 1500) return 5;
    return 6;
  }

  /// Get progress color based on level
  static int getProgressTarget(int level) {
    switch (level) {
      case 0: return 10;
      case 1: return 70;
      case 2: return 150;
      case 3: return 300;
      case 4: return 600;
      case 5: return 1000;
      case 6: return 1500;
      default: return 10;
    }
  }

  /// Create a copy with updated fields
  UserProfileEntity copyWith({
    String? id,
    String? username,
    int? score,
    int? level,
    String? rank,
    String? imageUrl,
    String? pspl,
  }) {
    return UserProfileEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      score: score ?? this.score,
      level: level ?? this.level,
      rank: rank ?? this.rank,
      imageUrl: imageUrl ?? this.imageUrl,
      pspl: pspl ?? this.pspl,
    );
  }

  @override
  List<Object?> get props => [id, username, score, level, rank, imageUrl, pspl];
}
