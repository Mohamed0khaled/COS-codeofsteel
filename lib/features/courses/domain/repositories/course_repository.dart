import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/course_entity.dart';

/// Abstract repository defining course operations.
/// Implementation details are in the data layer.
abstract class CourseRepository {
  /// Gets details of a specific course for a user
  Future<Either<Failure, CourseEntity?>> getCourseDetails(
    String userId,
    int courseId,
  );

  /// Gets all courses for a user
  Future<Either<Failure, List<CourseEntity>>> getAllCourses(String userId);

  /// Gets all favorite courses for a user
  Future<Either<Failure, List<CourseEntity>>> getFavoriteCourses(String userId);

  /// Gets all saved courses for a user
  Future<Either<Failure, List<CourseEntity>>> getSavedCourses(String userId);

  /// Gets all finished courses for a user
  Future<Either<Failure, List<CourseEntity>>> getFinishedCourses(String userId);

  /// Adds a new course for a user
  Future<Either<Failure, void>> addCourse(String userId, CourseEntity course);

  /// Updates favorite status
  Future<Either<Failure, void>> updateFavorite(
    String userId,
    int courseId,
    bool favorite,
  );

  /// Updates saved status
  Future<Either<Failure, void>> updateSaved(
    String userId,
    int courseId,
    bool saved,
  );

  /// Updates finished status
  Future<Either<Failure, void>> updateFinished(
    String userId,
    int courseId,
    bool finished,
  );

  /// Updates progress
  Future<Either<Failure, void>> updateProgress(
    String userId,
    int courseId,
    int progress,
  );

  /// Updates owned status
  Future<Either<Failure, void>> updateOwned(
    String userId,
    int courseId,
    bool owned,
  );

  /// Checks if a course is owned by a user
  Future<Either<Failure, bool>> isCourseOwned(String userId, int courseId);

  /// Checks if a course exists for a user
  Future<Either<Failure, bool>> courseExists(String userId, int courseId);

  /// Applies a discount code to a course
  Future<Either<Failure, int>> applyDiscountCode(
    String userId,
    int courseId,
    String code,
    int currentPrice,
  );

  /// Fetches global courses catalog and syncs to user's collection
  /// Returns all courses (merging global catalog with user-specific data)
  Future<Either<Failure, List<CourseEntity>>> syncAndGetAllCourses(
    String userId,
  );
}
