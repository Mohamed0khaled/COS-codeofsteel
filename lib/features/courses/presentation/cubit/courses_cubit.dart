import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/course_entity.dart';
import '../../domain/usecases/add_course.dart';
import '../../domain/usecases/apply_discount_code.dart';
import '../../domain/usecases/check_course_ownership.dart';
import '../../domain/usecases/get_course_details.dart';
import '../../domain/usecases/get_favorite_courses.dart';
import '../../domain/usecases/get_finished_courses.dart';
import '../../domain/usecases/get_saved_courses.dart';
import '../../domain/usecases/purchase_course.dart';
import '../../domain/usecases/toggle_favorite.dart';
import '../../domain/usecases/toggle_saved.dart';
import '../../domain/usecases/update_course_progress.dart';
import 'courses_state.dart';

/// Cubit for managing course-related state.
class CoursesCubit extends Cubit<CoursesState> {
  final GetCourseDetails _getCourseDetails;
  final GetFavoriteCourses _getFavoriteCourses;
  final GetSavedCourses _getSavedCourses;
  final GetFinishedCourses _getFinishedCourses;
  final ToggleFavorite _toggleFavorite;
  final ToggleSaved _toggleSaved;
  final UpdateCourseProgress _updateCourseProgress;
  final AddCourse _addCourse;
  final CheckCourseOwnership _checkCourseOwnership;
  final ApplyDiscountCode _applyDiscountCode;
  final PurchaseCourse _purchaseCourse;

  CoursesCubit({
    required GetCourseDetails getCourseDetails,
    required GetFavoriteCourses getFavoriteCourses,
    required GetSavedCourses getSavedCourses,
    required GetFinishedCourses getFinishedCourses,
    required ToggleFavorite toggleFavorite,
    required ToggleSaved toggleSaved,
    required UpdateCourseProgress updateCourseProgress,
    required AddCourse addCourse,
    required CheckCourseOwnership checkCourseOwnership,
    required ApplyDiscountCode applyDiscountCode,
    required PurchaseCourse purchaseCourse,
  })  : _getCourseDetails = getCourseDetails,
        _getFavoriteCourses = getFavoriteCourses,
        _getSavedCourses = getSavedCourses,
        _getFinishedCourses = getFinishedCourses,
        _toggleFavorite = toggleFavorite,
        _toggleSaved = toggleSaved,
        _updateCourseProgress = updateCourseProgress,
        _addCourse = addCourse,
        _checkCourseOwnership = checkCourseOwnership,
        _applyDiscountCode = applyDiscountCode,
        _purchaseCourse = purchaseCourse,
        super(const CoursesInitial());

  /// Load details of a specific course
  Future<void> loadCourseDetails(String userId, int courseId) async {
    emit(const CoursesLoading());

    final result = await _getCourseDetails(
      GetCourseDetailsParams(userId: userId, courseId: courseId),
    );

    result.fold(
      (failure) => emit(CoursesError(failure.message)),
      (course) {
        if (course != null) {
          emit(CourseLoaded(course));
        } else {
          emit(const CourseNotFound());
        }
      },
    );
  }

  /// Load favorite courses
  Future<void> loadFavoriteCourses(String userId) async {
    emit(const CoursesLoading());

    final result = await _getFavoriteCourses(userId);

    result.fold(
      (failure) => emit(CoursesError(failure.message)),
      (courses) => emit(CoursesListLoaded(courses)),
    );
  }

  /// Load saved courses
  Future<void> loadSavedCourses(String userId) async {
    emit(const CoursesLoading());

    final result = await _getSavedCourses(userId);

    result.fold(
      (failure) => emit(CoursesError(failure.message)),
      (courses) => emit(CoursesListLoaded(courses)),
    );
  }

  /// Load finished courses
  Future<void> loadFinishedCourses(String userId) async {
    emit(const CoursesLoading());

    final result = await _getFinishedCourses(userId);

    result.fold(
      (failure) => emit(CoursesError(failure.message)),
      (courses) => emit(CoursesListLoaded(courses)),
    );
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(
    String userId,
    int courseId,
    bool currentStatus,
  ) async {
    final newStatus = !currentStatus;

    final result = await _toggleFavorite(
      ToggleFavoriteParams(
        userId: userId,
        courseId: courseId,
        favorite: newStatus,
      ),
    );

    result.fold(
      (failure) => emit(CoursesError(failure.message)),
      (_) => emit(FavoriteUpdated(courseId: courseId, isFavorite: newStatus)),
    );
  }

  /// Toggle saved status
  Future<void> toggleSaved(
    String userId,
    int courseId,
    bool currentStatus,
  ) async {
    final newStatus = !currentStatus;

    final result = await _toggleSaved(
      ToggleSavedParams(
        userId: userId,
        courseId: courseId,
        saved: newStatus,
      ),
    );

    result.fold(
      (failure) => emit(CoursesError(failure.message)),
      (_) => emit(SavedUpdated(courseId: courseId, isSaved: newStatus)),
    );
  }

  /// Update course progress
  Future<void> updateProgress(
    String userId,
    int courseId,
    int progress,
  ) async {
    final result = await _updateCourseProgress(
      UpdateCourseProgressParams(
        userId: userId,
        courseId: courseId,
        progress: progress,
      ),
    );

    result.fold(
      (failure) => emit(CoursesError(failure.message)),
      (_) => emit(ProgressUpdated(courseId: courseId, progress: progress)),
    );
  }

  /// Initialize a course for a user (creates if not exists)
  Future<void> initializeCourse(String userId, CourseEntity course) async {
    final result = await _addCourse(
      AddCourseParams(userId: userId, course: course),
    );

    result.fold(
      (failure) => emit(CoursesError(failure.message)),
      (_) => emit(CourseLoaded(course)),
    );
  }

  /// Check if user owns a course
  Future<void> checkOwnership(String userId, int courseId) async {
    emit(const CoursesLoading());

    final result = await _checkCourseOwnership(
      CheckCourseOwnershipParams(userId: userId, courseId: courseId),
    );

    result.fold(
      (failure) => emit(CoursesError(failure.message)),
      (isOwned) => emit(OwnershipChecked(courseId: courseId, isOwned: isOwned)),
    );
  }

  /// Apply discount code
  Future<void> applyDiscount(
    String userId,
    int courseId,
    String code,
    int currentPrice,
  ) async {
    final result = await _applyDiscountCode(
      ApplyDiscountCodeParams(
        userId: userId,
        courseId: courseId,
        code: code,
        currentPrice: currentPrice,
      ),
    );

    result.fold(
      (failure) => emit(CoursesError(failure.message)),
      (newPrice) => emit(DiscountApplied(courseId: courseId, newPrice: newPrice)),
    );
  }

  /// Purchase a course
  Future<void> purchaseCourse(String userId, int courseId) async {
    final result = await _purchaseCourse(
      PurchaseCourseParams(userId: userId, courseId: courseId),
    );

    result.fold(
      (failure) => emit(CoursesError(failure.message)),
      (_) => emit(CoursePurchased(courseId)),
    );
  }
}
