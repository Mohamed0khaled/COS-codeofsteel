import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../../domain/entities/locale_entity.dart';
import '../../domain/repositories/locale_repository.dart';
import '../datasources/locale_local_datasource.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  final LocaleLocalDataSource localDataSource;

  LocaleRepositoryImpl({required this.localDataSource});

  @override
  Either<Failure, LocaleEntity> getLocale() {
    try {
      final locale = localDataSource.getLocale();
      return Right(locale);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveLocale(String languageCode) async {
    try {
      await localDataSource.saveLocale(languageCode);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocaleEntity>> toggleLocale() async {
    try {
      final newLocale = await localDataSource.toggleLocale();
      return Right(newLocale);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
