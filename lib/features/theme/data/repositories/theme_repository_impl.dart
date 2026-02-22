import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../../domain/entities/theme_entity.dart';
import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_local_datasource.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl({required this.localDataSource});

  @override
  Either<Failure, ThemeEntity> getTheme() {
    try {
      final theme = localDataSource.getTheme();
      return Right(theme);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveTheme(bool isDarkMode) async {
    try {
      await localDataSource.saveTheme(isDarkMode);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ThemeEntity>> toggleTheme() async {
    try {
      final newTheme = await localDataSource.toggleTheme();
      return Right(newTheme);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
