import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import 'package:coursesapp/features/user_profile/data/datasources/user_profile_remote_datasource.dart';
import 'package:coursesapp/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:coursesapp/features/user_profile/domain/repositories/user_profile_repository.dart';

/// Implementation of UserProfileRepository
/// 
/// Handles error mapping from data source exceptions to Failure objects
class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;

  UserProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile(String userId) async {
    try {
      final profile = await remoteDataSource.getUserProfile(userId);
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get user profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createUserProfile({
    required String userId,
    required String username,
    String? photoUrl,
  }) async {
    try {
      await remoteDataSource.createUserProfile(
        userId: userId,
        username: username,
        photoUrl: photoUrl,
      );
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to create user profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUsername({
    required String userId,
    required String newUsername,
  }) async {
    try {
      await remoteDataSource.updateUsername(
        userId: userId,
        newUsername: newUsername,
      );
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to update username: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfileImage({
    required String userId,
    required String imageUrl,
  }) async {
    try {
      await remoteDataSource.updateProfileImage(
        userId: userId,
        imageUrl: imageUrl,
      );
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to update profile image: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePspl({
    required String userId,
    required String pspl,
  }) async {
    try {
      await remoteDataSource.updatePspl(
        userId: userId,
        pspl: pspl,
      );
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to update PSPL: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> updateScore({
    required String userId,
    required int newScore,
  }) async {
    try {
      final profile = await remoteDataSource.updateScore(
        userId: userId,
        newScore: newScore,
      );
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to update score: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> getUsername(String userId) async {
    try {
      final username = await remoteDataSource.getUsername(userId);
      return Right(username);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get username: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> getScore(String userId) async {
    try {
      final score = await remoteDataSource.getScore(userId);
      return Right(score);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get score: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> getRank(String userId) async {
    try {
      final rank = await remoteDataSource.getRank(userId);
      return Right(rank);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get rank: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> getLevel(String userId) async {
    try {
      final level = await remoteDataSource.getLevel(userId);
      return Right(level);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get level: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> getPspl(String userId) async {
    try {
      final pspl = await remoteDataSource.getPspl(userId);
      return Right(pspl);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get PSPL: ${e.toString()}'));
    }
  }
}
