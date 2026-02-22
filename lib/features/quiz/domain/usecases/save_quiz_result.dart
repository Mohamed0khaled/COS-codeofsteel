import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/quiz_result_entity.dart';
import '../repositories/quiz_repository.dart';

/// Use case to save quiz result for a user.
class SaveQuizResult implements UseCase<void, SaveQuizResultParams> {
  final QuizRepository _repository;

  SaveQuizResult(this._repository);

  @override
  Future<Either<Failure, void>> call(SaveQuizResultParams params) {
    return _repository.saveQuizResult(params.userId, params.result);
  }
}

class SaveQuizResultParams extends Equatable {
  final String userId;
  final QuizResultEntity result;

  const SaveQuizResultParams({
    required this.userId,
    required this.result,
  });

  @override
  List<Object?> get props => [userId, result];
}
