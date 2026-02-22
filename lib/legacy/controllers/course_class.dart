import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  int id;
  String name;
  bool favorite;
  bool saved;
  bool finished;
  int progress;
  String cardImage;
  bool owned;
  int price;

  Course(
      {required this.id,
      required this.name,
      required this.favorite,
      required this.saved,
      required this.finished,
      required this.progress,
      required this.cardImage,
      required this.owned,
      required this.price});

  // Converts a Course object into a Map for storing in Firestore
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
      'price': price
    };
  }

  // Factory constructor to create a Course object from Firestore data
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] as int,
      name: map['name'] as String,
      favorite: map['favorite'] as bool,
      saved: map['saved'] as bool,
      finished: map['finished'] as bool,
      progress: map['progress'] as int,
      cardImage: map['card_image'] as String,
      owned: map['owned'] as bool,
      price: map['price'] as int,
    );
  }
}

// Firebase functions to update course data
class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Update a specific field for a course
  Future<void> updateCourseField({
    required String userId,
    required int courseId,
    required String field,
    required dynamic value,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('courses')
          .doc(courseId.toString())
          .update({field: value});
    } catch (e) {
      print('Error updating course field: $e');
    }
  }

  // Update card_image for a specific course
  Future<void> updateCardImage(
      String userId, int courseId, String cardImage) async {
    await updateCourseField(
      userId: userId,
      courseId: courseId,
      field: 'card_image',
      value: cardImage,
    );
  }

  Future<void> updateFavorite(
      String userId, int courseId, bool favorite) async {
    await updateCourseField(
      userId: userId,
      courseId: courseId,
      field: 'favorite',
      value: favorite,
    );
  }

  Future<void> updateSaved(String userId, int courseId, bool saved) async {
    await updateCourseField(
      userId: userId,
      courseId: courseId,
      field: 'saved',
      value: saved,
    );
  }

  Future<void> updateFinished(
      String userId, int courseId, bool finished) async {
    await updateCourseField(
      userId: userId,
      courseId: courseId,
      field: 'finished',
      value: finished,
    );
  }

  Future<void> updateProgress(String userId, int courseId, int progress) async {
    await updateCourseField(
      userId: userId,
      courseId: courseId,
      field: 'progress',
      value: progress,
    );
  }

  Future<void> updatePrice(String userId, int courseId, int price) async {
    await updateCourseField(
      userId: userId,
      courseId: courseId,
      field: 'price',
      value: price,
    );
  }

  Future<int> getCourseProgress(String userId, int courseId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('courses')
          .doc(courseId.toString())
          .get();

      if (doc.exists) {
        return (doc.data() as Map<String, dynamic>)['progress'] as int? ?? 0;
      } else {
        print('Course not found');
        return 0; // Default progress if the course does not exist
      }
    } catch (e) {
      print('Error fetching course progress: $e');
      return 0; // Default progress in case of an error
    }
  }

  Future<int> getCoursePrice(String userId, int courseId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('courses')
          .doc(courseId.toString())
          .get();

      if (doc.exists) {
        return (doc.data() as Map<String, dynamic>)['price'] as int? ?? 0;
      } else {
        print('Course not found');
        return 0; // Default progress if the course does not exist
      }
    } catch (e) {
      print('Error fetching course progress: $e');
      return 0; // Default progress in case of an error
    }
  }

  Future<void> updateOwned(String userId, int courseId, bool owned) async {
    await updateCourseField(
      userId: userId,
      courseId: courseId,
      field: 'owned',
      value: owned,
    );
  }

  Future<void> addCourse(String userId, Course course) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('courses')
          .doc(course.id.toString())
          .set(course.toMap()); // This will now include cardImage
    } catch (e) {
      print('Error adding course: $e');
    }
  }

  // Retrieve all favorite courses for the current user
  Future<List<Course>> getFavoriteCourses(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('courses')
          .where('favorite', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => Course.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching favorite courses: $e');
      return [];
    }
  }

  // Retrieve all saved courses for the current user
  Future<List<Course>> getSavedCourses(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('courses')
          .where('saved', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => Course.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching saved courses: $e');
      return [];
    }
  }

  // Retrieve all finished courses for the current user
  Future<List<Course>> getFinishedCourses(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('courses')
          .where('finished', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => Course.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching finished courses: $e');
      return [];
    }
  }

  // Fetches current values of all fields for a specific course
  Future<Course?> getCourseDetails(String userId, int courseId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('courses')
          .doc(courseId.toString())
          .get();

      if (doc.exists) {
        return Course.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        print('Course not found');
        return null;
      }
    } catch (e) {
      print('Error fetching course details: $e');
      return null;
    }
  }

  Future<bool> isCourseOwned(String userId, int courseId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('courses')
          .doc(courseId.toString())
          .get();

      if (doc.exists) {
        return (doc.data() as Map<String, dynamic>)['owned'] ?? false;
      } else {
        print('Course not found');
        return false;
      }
    } catch (e) {
      print('Error checking if course is owned: $e');
      return false;
    }
  }

  Future<bool> courseExists(String userId, int courseId) async {
    try {
      CollectionReference coursesCollection =
          _firestore.collection('users').doc(userId).collection('courses');

      QuerySnapshot querySnapshot =
          await coursesCollection.where('id', isEqualTo: courseId).get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking if course exists: $e");
      return false;
    }
  }

  Future<void> checkCode(String userId, String code, int course_id, int old_price) async {
    try {
      CollectionReference discountCollection =
          FirebaseFirestore.instance.collection('discount');

      QuerySnapshot querySnapshot = await discountCollection.get();
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        for (var field in data.entries) {
          if (field.value is List && field.value.contains(code)) {
            print('Code "$code" found in list "${field.key}"');
            if (field.key == "codes20") {
              int new_price = (old_price * (80 / 100)).toInt();
              updatePrice(userId, course_id, new_price);
              deleteCode(code);
            } else if (field.key == "codes40") {
              int new_price = (old_price * (60 / 100)).toInt();
              updatePrice(userId, course_id, new_price);
              deleteCode(code);
            }
            return;
          }
        }
      }
      print('Code "$code" not found.');
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  // Function to get a random question based on level
  Future<String?> getRandomQuestion(int level) async {
    String levelKey = "level$level";

    try {
      // Fetch the questions for the specified level
      QuerySnapshot querySnapshot = await _firestore.collection("pms").get();
      print(
          "Questions fetched: ${querySnapshot.docs.length}"); // Debugging line

      // Check if there are any questions
      if (querySnapshot.docs.isEmpty) {
        return null; // No questions available
      }

      // Assuming the document structure contains a field for each level
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

      // Access the questions for the selected level
      List<String>? levelQuestions = List<String>.from(data[levelKey] ?? []);
      print("Level $level Questions: $levelQuestions");

      // Check if there are any questions for the level
      if (levelQuestions.isEmpty) {
        return null; // No questions for this level
      }

      // Select a random question from the level
      int randomIndex = Random().nextInt(levelQuestions.length);
      return levelQuestions[randomIndex]; // Return the random question
    } catch (e) {
      print("Error fetching question: $e");
      return null; // Handle error appropriately
    }
  }

  Future<void> deleteCode(String code) async {
    try {
      CollectionReference discountCollection =
          FirebaseFirestore.instance.collection('discount');
      QuerySnapshot querySnapshot = await discountCollection.get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        for (var field in data.entries) {
          if (field.value is List && field.value.contains(code)) {
            List updatedList = List.from(field.value)..remove(code);

            await discountCollection.doc(doc.id).update({
              field.key: updatedList,
            });

            print(
                'Code "$code" deleted from list "${field.key}" in document "${doc.id}".');
            return;
          }
        }
      }

      print('Code "$code" not found.');
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
