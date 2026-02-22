import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/quiz_result_entity.dart';
import '../repositories/quiz_repository.dart';

/// Use case to get quiz history for a user.
class GetQuizHistory implements UseCase<List<QuizResultEntity>, GetQuizHistoryParams> {
  final QuizRepository _repository;

  GetQuizHistory(this._repository);

  @override
  Future<Either<Failure, List<QuizResultEntity>>> call(GetQuizHistoryParams params) {
    return _repository.getQuizHistory(params.userId, params.courseId);
  }
}

class GetQuizHistoryParams extends Equatable {
  final String userId;
  final String courseId;

  const GetQuizHistoryParams({
    required this.userId,
    required this.courseId,
  });

  @override
  List<Object?> get props => [userId, courseId];
}
