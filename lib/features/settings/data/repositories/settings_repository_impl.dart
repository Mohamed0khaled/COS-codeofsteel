import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../../domain/entities/settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;
  final SettingsRemoteDataSource remoteDataSource;
  final FirebaseAuth firebaseAuth;

  SettingsRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.firebaseAuth,
  });

  String? get _currentUserId => firebaseAuth.currentUser?.uid;

  @override
  Future<Either<Failure, SettingsEntity>> getSettings() async {
    try {
      final settings = localDataSource.getSettings();
      return Right(settings);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setDarkMode(bool isDarkMode) async {
    try {
      await localDataSource.setDarkMode(isDarkMode);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setLanguage(String languageCode) async {
    try {
      await localDataSource.setLanguage(languageCode);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setProgrammingLanguage(String language) async {
    try {
      await localDataSource.setProgrammingLanguage(language);
      
      // Also sync to Firestore if user is logged in
      final userId = _currentUserId;
      if (userId != null) {
        await remoteDataSource.syncProgrammingLanguage(userId, language);
      }
      
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFirstLaunch() async {
    try {
      final isFirst = await localDataSource.isFirstLaunch();
      return Right(isFirst);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completeFirstLaunch() async {
    try {
      await localDataSource.completeFirstLaunch();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
