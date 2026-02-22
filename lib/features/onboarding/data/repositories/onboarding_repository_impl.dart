import 'package:dartz/dartz.dart';
import 'package:coursesapp/core/errors/failures.dart';
import '../../domain/entities/onboarding_page_entity.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_datasource.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Either<Failure, List<OnboardingPageEntity>> getOnboardingPages() {
    try {
      final pages = localDataSource.getOnboardingPages();
      return Right(pages);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isOnboardingCompleted() async {
    try {
      final isCompleted = await localDataSource.isOnboardingCompleted();
      return Right(isCompleted);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completeOnboarding() async {
    try {
      await localDataSource.completeOnboarding();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
