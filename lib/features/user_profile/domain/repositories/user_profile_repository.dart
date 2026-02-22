import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/features/user_profile/domain/entities/user_profile_entity.dart';

/// Abstract repository interface for user profile operations
/// 
/// Implementations should handle Firebase Firestore operations
/// for the users/{userId}/userdata/info document
abstract class UserProfileRepository {
  /// Get the user profile for the given user ID
  Future<Either<Failure, UserProfileEntity>> getUserProfile(String userId);

  /// Create initial user profile data after registration
  Future<Either<Failure, Unit>> createUserProfile({
    required String userId,
    required String username,
    String? photoUrl,
  });

  /// Update the username
  Future<Either<Failure, Unit>> updateUsername({
    required String userId,
    required String newUsername,
  });

  /// Update the profile image URL
  Future<Either<Failure, Unit>> updateProfileImage({
    required String userId,
    required String imageUrl,
  });

  /// Update the preferred programming language
  Future<Either<Failure, Unit>> updatePspl({
    required String userId,
    required String pspl,
  });

  /// Update the score and recalculate rank/level
  Future<Either<Failure, UserProfileEntity>> updateScore({
    required String userId,
    required int newScore,
  });

  /// Get just the username
  Future<Either<Failure, String>> getUsername(String userId);

  /// Get just the score
  Future<Either<Failure, int>> getScore(String userId);

  /// Get just the rank
  Future<Either<Failure, String>> getRank(String userId);

  /// Get just the level
  Future<Either<Failure, int>> getLevel(String userId);

  /// Get the preferred programming language
  Future<Either<Failure, String>> getPspl(String userId);
}
