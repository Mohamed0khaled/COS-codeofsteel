import 'package:equatable/equatable.dart';
import '../../domain/entities/course_entity.dart';

/// Base state for courses
abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CoursesInitial extends CoursesState {
  const CoursesInitial();
}

/// Loading state
class CoursesLoading extends CoursesState {
  const CoursesLoading();
}

/// State when a single course is loaded
class CourseLoaded extends CoursesState {
  final CourseEntity course;

  const CourseLoaded(this.course);

  @override
  List<Object?> get props => [course];
}

/// State when course is not found
class CourseNotFound extends CoursesState {
  const CourseNotFound();
}

/// State when a list of courses is loaded
class CoursesListLoaded extends CoursesState {
  final List<CourseEntity> courses;

  const CoursesListLoaded(this.courses);

  @override
  List<Object?> get props => [courses];
}

/// State when favorite status is updated
class FavoriteUpdated extends CoursesState {
  final int courseId;
  final bool isFavorite;

  const FavoriteUpdated({
    required this.courseId,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [courseId, isFavorite];
}

/// State when saved status is updated
class SavedUpdated extends CoursesState {
  final int courseId;
  final bool isSaved;

  const SavedUpdated({
    required this.courseId,
    required this.isSaved,
  });

  @override
  List<Object?> get props => [courseId, isSaved];
}

/// State when progress is updated
class ProgressUpdated extends CoursesState {
  final int courseId;
  final int progress;

  const ProgressUpdated({
    required this.courseId,
    required this.progress,
  });

  @override
  List<Object?> get props => [courseId, progress];
}

/// State when course is purchased
class CoursePurchased extends CoursesState {
  final int courseId;

  const CoursePurchased(this.courseId);

  @override
  List<Object?> get props => [courseId];
}

/// State when discount is applied
class DiscountApplied extends CoursesState {
  final int courseId;
  final int newPrice;

  const DiscountApplied({
    required this.courseId,
    required this.newPrice,
  });

  @override
  List<Object?> get props => [courseId, newPrice];
}

/// State when ownership is checked
class OwnershipChecked extends CoursesState {
  final int courseId;
  final bool isOwned;

  const OwnershipChecked({
    required this.courseId,
    required this.isOwned,
  });

  @override
  List<Object?> get props => [courseId, isOwned];
}

/// Error state
class CoursesError extends CoursesState {
  final String message;

  const CoursesError(this.message);

  @override
  List<Object?> get props => [message];
}
