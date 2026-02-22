import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/code_evaluation_entity.dart';
import '../repositories/quiz_repository.dart';

/// Use case to evaluate code using AI.
class EvaluateCode implements UseCase<CodeEvaluationEntity, EvaluateCodeParams> {
  final QuizRepository _repository;

  EvaluateCode(this._repository);

  @override
  Future<Either<Failure, CodeEvaluationEntity>> call(EvaluateCodeParams params) {
    return _repository.evaluateCode(params.question, params.userCode);
  }
}

class EvaluateCodeParams extends Equatable {
  final String question;
  final String userCode;

  const EvaluateCodeParams({
    required this.question,
    required this.userCode,
  });

  @override
  List<Object?> get props => [question, userCode];
}
