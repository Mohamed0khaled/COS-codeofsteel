import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:coursesapp/features/auth/domain/entities/user_entity.dart';

/// User model that extends UserEntity.
/// 
/// This model handles conversion from Firebase User to domain entity.
/// Only used in the data layer - domain layer only sees UserEntity.
class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    super.name,
    super.photoUrl,
    super.emailVerified,
  });

  /// Create UserModel from Firebase User object.
  factory UserModel.fromFirebaseUser(firebase_auth.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName,
      photoUrl: user.photoURL,
      emailVerified: user.emailVerified,
    );
  }

  /// Create UserModel from JSON map (for Firestore data).
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['username'] as String?,
      photoUrl: json['pro_image'] as String?,
      emailVerified: json['email_verified'] as bool? ?? false,
    );
  }

  /// Convert UserModel to JSON map (for Firestore storage).
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': name,
      'pro_image': photoUrl,
      'email_verified': emailVerified,
    };
  }

  /// Create a copy of UserModel with updated fields.
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? photoUrl,
    bool? emailVerified,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  /// Convert UserEntity to UserModel.
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      email: entity.email,
      name: entity.name,
      photoUrl: entity.photoUrl,
      emailVerified: entity.emailVerified,
    );
  }
}
