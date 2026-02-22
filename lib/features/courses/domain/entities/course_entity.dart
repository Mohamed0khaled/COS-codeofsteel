import 'package:equatable/equatable.dart';

/// Domain entity representing a course.
/// This is the core business object, independent of data source.
class CourseEntity extends Equatable {
  final int id;
  final String name;
  final bool favorite;
  final bool saved;
  final bool finished;
  final int progress;
  final String cardImage;
  final bool owned;
  final int price;

  const CourseEntity({
    required this.id,
    required this.name,
    required this.favorite,
    required this.saved,
    required this.finished,
    required this.progress,
    required this.cardImage,
    required this.owned,
    required this.price,
  });

  /// Creates a copy with updated fields
  CourseEntity copyWith({
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
    return CourseEntity(
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

  @override
  List<Object?> get props => [
        id,
        name,
        favorite,
        saved,
        finished,
        progress,
        cardImage,
        owned,
        price,
      ];
}
