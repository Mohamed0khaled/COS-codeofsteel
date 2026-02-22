import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/quiz_repository.dart';

/// Use case to store API key securely.
class StoreApiKey implements UseCase<void, String> {
  final QuizRepository _repository;

  StoreApiKey(this._repository);

  @override
  Future<Either<Failure, void>> call(String apiKey) {
    return _repository.storeApiKey(apiKey);
  }
}
