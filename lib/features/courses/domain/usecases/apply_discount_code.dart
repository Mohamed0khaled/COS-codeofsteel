import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/course_repository.dart';

/// Use case to apply a discount code to a course.
class ApplyDiscountCode implements UseCase<int, ApplyDiscountCodeParams> {
  final CourseRepository _repository;

  ApplyDiscountCode(this._repository);

  @override
  Future<Either<Failure, int>> call(ApplyDiscountCodeParams params) {
    return _repository.applyDiscountCode(
      params.userId,
      params.courseId,
      params.code,
      params.currentPrice,
    );
  }
}

class ApplyDiscountCodeParams extends Equatable {
  final String userId;
  final int courseId;
  final String code;
  final int currentPrice;

  const ApplyDiscountCodeParams({
    required this.userId,
    required this.courseId,
    required this.code,
    required this.currentPrice,
  });

  @override
  List<Object?> get props => [userId, courseId, code, currentPrice];
}
