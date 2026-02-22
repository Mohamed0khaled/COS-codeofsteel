import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/course_repository.dart';
import '../models/course_model.dart';

/// Implementation of CourseRepository using Firebase Firestore.
class CourseRepositoryImpl implements CourseRepository {
  final FirebaseFirestore _firestore;

  CourseRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference _coursesCollection(String userId) {
    return _firestore.collection('users').doc(userId).collection('courses');
  }

  @override
  Future<Either<Failure, CourseEntity?>> getCourseDetails(
    String userId,
    int courseId,
  ) async {
    try {
      final doc = await _coursesCollection(userId).doc(courseId.toString()).get();

      if (doc.exists) {
        final course = CourseModel.fromMap(doc.data() as Map<String, dynamic>);
        return Right(course);
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get course details: $e'));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses(
    String userId,
  ) async {
    try {
      final snapshot = await _coursesCollection(userId).get();
      final courses = snapshot.docs
          .map((doc) => CourseModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return Right(courses);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get courses: $e'));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getFavoriteCourses(
    String userId,
  ) async {
    try {
      final snapshot = await _coursesCollection(userId)
          .where('favorite', isEqualTo: true)
          .get();
      final courses = snapshot.docs
          .map((doc) => CourseModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return Right(courses);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get favorite courses: $e'));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getSavedCourses(
    String userId,
  ) async {
    try {
      final snapshot = await _coursesCollection(userId)
          .where('saved', isEqualTo: true)
          .get();
      final courses = snapshot.docs
          .map((doc) => CourseModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return Right(courses);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get saved courses: $e'));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getFinishedCourses(
    String userId,
  ) async {
    try {
      final snapshot = await _coursesCollection(userId)
          .where('finished', isEqualTo: true)
          .get();
      final courses = snapshot.docs
          .map((doc) => CourseModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return Right(courses);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get finished courses: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> addCourse(
    String userId,
    CourseEntity course,
  ) async {
    try {
      final model = CourseModel.fromEntity(course);
      await _coursesCollection(userId).doc(course.id.toString()).set(model.toMap());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to add course: $e'));
    }
  }

  Future<Either<Failure, void>> _updateField(
    String userId,
    int courseId,
    String field,
    dynamic value,
  ) async {
    try {
      await _coursesCollection(userId).doc(courseId.toString()).update({field: value});
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to update $field: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateFavorite(
    String userId,
    int courseId,
    bool favorite,
  ) async {
    return _updateField(userId, courseId, 'favorite', favorite);
  }

  @override
  Future<Either<Failure, void>> updateSaved(
    String userId,
    int courseId,
    bool saved,
  ) async {
    return _updateField(userId, courseId, 'saved', saved);
  }

  @override
  Future<Either<Failure, void>> updateFinished(
    String userId,
    int courseId,
    bool finished,
  ) async {
    return _updateField(userId, courseId, 'finished', finished);
  }

  @override
  Future<Either<Failure, void>> updateProgress(
    String userId,
    int courseId,
    int progress,
  ) async {
    return _updateField(userId, courseId, 'progress', progress);
  }

  @override
  Future<Either<Failure, void>> updateOwned(
    String userId,
    int courseId,
    bool owned,
  ) async {
    return _updateField(userId, courseId, 'owned', owned);
  }

  @override
  Future<Either<Failure, bool>> isCourseOwned(
    String userId,
    int courseId,
  ) async {
    try {
      final doc = await _coursesCollection(userId).doc(courseId.toString()).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return Right(data['owned'] as bool? ?? false);
      }
      return const Right(false);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to check ownership: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> courseExists(
    String userId,
    int courseId,
  ) async {
    try {
      final snapshot = await _coursesCollection(userId)
          .where('id', isEqualTo: courseId)
          .get();
      return Right(snapshot.docs.isNotEmpty);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to check course existence: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> applyDiscountCode(
    String userId,
    int courseId,
    String code,
    int currentPrice,
  ) async {
    try {
      final discountCollection = _firestore.collection('discount');
      final snapshot = await discountCollection.get();

      for (final doc in snapshot.docs) {
        final data = doc.data();
        for (final entry in data.entries) {
          if (entry.value is List && (entry.value as List).contains(code)) {
            int newPrice = currentPrice;

            if (entry.key == 'codes20') {
              newPrice = (currentPrice * 0.8).toInt();
            } else if (entry.key == 'codes40') {
              newPrice = (currentPrice * 0.6).toInt();
            }

            // Update price
            await _updateField(userId, courseId, 'price', newPrice);

            // Delete used code
            final updatedList = List.from(entry.value)..remove(code);
            await discountCollection.doc(doc.id).update({entry.key: updatedList});

            return Right(newPrice);
          }
        }
      }

      return Left(ServerFailure(message: 'Invalid discount code'));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to apply discount: $e'));
    }
  }
}
