/// Firebase Collection and Document Constants
/// 
/// Centralizes all Firebase paths to avoid hardcoding throughout the app.

class FirebaseConstants {
  FirebaseConstants._();

  // Collection names
  static const String usersCollection = 'users';
  static const String coursesCollection = 'courses';
  static const String discountCollection = 'discount';
  static const String problemsCollection = 'pms';

  // Document paths
  static const String userDataDoc = 'userdata';
  static const String userInfoDoc = 'info';

  // Field names - User
  static const String fieldUsername = 'username';
  static const String fieldUserId = 'id';
  static const String fieldScore = 'score';
  static const String fieldLevel = 'level';
  static const String fieldRank = 'rank';
  static const String fieldProfileImage = 'pro_image';
  static const String fieldPspl = 'pspl'; // Programming language preference

  // Field names - Course
  static const String fieldCourseId = 'id';
  static const String fieldCourseName = 'name';
  static const String fieldFavorite = 'favorite';
  static const String fieldSaved = 'saved';
  static const String fieldFinished = 'finished';
  static const String fieldProgress = 'progress';
  static const String fieldCardImage = 'card_image';
  static const String fieldOwned = 'owned';
  static const String fieldPrice = 'price';
}
