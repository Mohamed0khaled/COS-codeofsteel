import 'package:equatable/equatable.dart';

/// User entity - core business object for authentication.
/// 
/// This entity is framework-agnostic and contains only
/// essential user data needed by the domain layer.
class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String? name;
  final String? photoUrl;
  final bool emailVerified;

  const UserEntity({
    required this.uid,
    required this.email,
    this.name,
    this.photoUrl,
    this.emailVerified = false,
  });

  /// Check if the user has verified their email
  bool get isEmailVerified => emailVerified;

  /// Check if the user has a display name
  bool get hasName => name != null && name!.isNotEmpty;

  /// Check if the user has a profile photo
  bool get hasPhoto => photoUrl != null && photoUrl!.isNotEmpty;

  @override
  List<Object?> get props => [uid, email, name, photoUrl, emailVerified];

  @override
  String toString() {
    return 'UserEntity(uid: $uid, email: $email, name: $name, emailVerified: $emailVerified)';
  }
}
