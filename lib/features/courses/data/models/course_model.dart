import '../../domain/entities/course_entity.dart';

/// Data model for Course with JSON/Firestore serialization.
/// Extends the domain entity to add data layer functionality.
class CourseModel extends CourseEntity {
  const CourseModel({
    required super.id,
    required super.name,
    required super.favorite,
    required super.saved,
    required super.finished,
    required super.progress,
    required super.cardImage,
    required super.owned,
    required super.price,
  });

  /// Factory constructor to create a CourseModel from Firestore data
  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as int? ?? 0,
      name: map['name'] as String? ?? '',
      favorite: map['favorite'] as bool? ?? false,
      saved: map['saved'] as bool? ?? false,
      finished: map['finished'] as bool? ?? false,
      progress: map['progress'] as int? ?? 0,
      cardImage: map['card_image'] as String? ?? '',
      owned: map['owned'] as bool? ?? false,
      price: map['price'] as int? ?? 0,
    );
  }

  /// Converts a CourseModel to a Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'favorite': favorite,
      'saved': saved,
      'finished': finished,
      'progress': progress,
      'card_image': cardImage,
      'owned': owned,
      'price': price,
    };
  }

  /// Creates a CourseModel from a domain entity
  factory CourseModel.fromEntity(CourseEntity entity) {
    return CourseModel(
      id: entity.id,
      name: entity.name,
      favorite: entity.favorite,
      saved: entity.saved,
      finished: entity.finished,
      progress: entity.progress,
      cardImage: entity.cardImage,
      owned: entity.owned,
      price: entity.price,
    );
  }

  /// Creates a copy with updated fields
  @override
  CourseModel copyWith({
    int? id,
    String? name,
    bool? favorite,
    bool? saved,
    bool? finished,
    int? progress,
    String? cardImage,
    bool? owned,
    int? price,
  }) {
    return CourseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      favorite: favorite ?? this.favorite,
      saved: saved ?? this.saved,
      finished: finished ?? this.finished,
      progress: progress ?? this.progress,
      cardImage: cardImage ?? this.cardImage,
      owned: owned ?? this.owned,
      price: price ?? this.price,
    );
  }
}
