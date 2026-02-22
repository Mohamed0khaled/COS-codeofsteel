import 'package:coursesapp/features/user_profile/domain/entities/user_profile_entity.dart';

/// Data model for user profile that handles JSON serialization
/// 
/// Maps to Firestore document at: users/{userId}/userdata/info
class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.id,
    required super.username,
    required super.score,
    required super.level,
    required super.rank,
    super.imageUrl,
    required super.pspl,
  });

  /// Create model from Firestore document data
  factory UserProfileModel.fromJson(Map<String, dynamic> json, String id) {
    return UserProfileModel(
      id: id,
      username: json['username'] as String? ?? 'Unknown',
      score: json['score'] as int? ?? 0,
      level: json['level'] as int? ?? 0,
      rank: json['rank'] as String? ?? 'E',
      imageUrl: json['pro_image'] as String? ?? json['image_url'] as String?,
      pspl: json['pspl'] as String? ?? 'C++',
    );
  }

  /// Convert model to Firestore document data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'score': score,
      'level': level,
      'rank': rank,
      'pro_image': imageUrl,
      'pspl': pspl,
    };
  }

  /// Create initial profile data for new users
  factory UserProfileModel.initial({
    required String userId,
    required String username,
    String? photoUrl,
  }) {
    return UserProfileModel(
      id: userId,
      username: username,
      score: 0,
      level: 0,
      rank: 'E',
      imageUrl: photoUrl,
      pspl: 'C++',
    );
  }

  /// Create a copy with updated fields
  @override
  UserProfileModel copyWith({
    String? id,
    String? username,
    int? score,
    int? level,
    String? rank,
    String? imageUrl,
    String? pspl,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      username: username ?? this.username,
      score: score ?? this.score,
      level: level ?? this.level,
      rank: rank ?? this.rank,
      imageUrl: imageUrl ?? this.imageUrl,
      pspl: pspl ?? this.pspl,
    );
  }
}
