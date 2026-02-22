import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursesapp/features/user_profile/data/models/user_profile_model.dart';
import 'package:coursesapp/features/user_profile/domain/entities/user_profile_entity.dart';

/// Remote data source for user profile operations
/// 
/// Handles all Firestore interactions for user profile data
/// Document path: users/{userId}/userdata/info
abstract class UserProfileRemoteDataSource {
  /// Get the complete user profile
  Future<UserProfileModel> getUserProfile(String userId);

  /// Create initial user profile
  Future<void> createUserProfile({
    required String userId,
    required String username,
    String? photoUrl,
  });

  /// Update username
  Future<void> updateUsername({
    required String userId,
    required String newUsername,
  });

  /// Update profile image URL
  Future<void> updateProfileImage({
    required String userId,
    required String imageUrl,
  });

  /// Update preferred programming language
  Future<void> updatePspl({
    required String userId,
    required String pspl,
  });

  /// Update score and recalculate rank/level
  Future<UserProfileModel> updateScore({
    required String userId,
    required int newScore,
  });

  /// Get username only
  Future<String> getUsername(String userId);

  /// Get score only
  Future<int> getScore(String userId);

  /// Get rank only
  Future<String> getRank(String userId);

  /// Get level only
  Future<int> getLevel(String userId);

  /// Get preferred programming language
  Future<String> getPspl(String userId);
}

/// Implementation of UserProfileRemoteDataSource using Firebase Firestore
class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  UserProfileRemoteDataSourceImpl({required this.firestore});

  /// Reference to the user's profile document
  DocumentReference _userDocRef(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('userdata')
        .doc('info');
  }

  @override
  Future<UserProfileModel> getUserProfile(String userId) async {
    final doc = await _userDocRef(userId).get();
    
    if (!doc.exists) {
      throw Exception('User profile not found');
    }
    
    return UserProfileModel.fromJson(
      doc.data() as Map<String, dynamic>,
      userId,
    );
  }

  @override
  Future<void> createUserProfile({
    required String userId,
    required String username,
    String? photoUrl,
  }) async {
    final profile = UserProfileModel.initial(
      userId: userId,
      username: username,
      photoUrl: photoUrl,
    );
    
    await _userDocRef(userId).set(profile.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> updateUsername({
    required String userId,
    required String newUsername,
  }) async {
    await _userDocRef(userId).update({'username': newUsername});
  }

  @override
  Future<void> updateProfileImage({
    required String userId,
    required String imageUrl,
  }) async {
    await _userDocRef(userId).update({'image_url': imageUrl});
  }

  @override
  Future<void> updatePspl({
    required String userId,
    required String pspl,
  }) async {
    await _userDocRef(userId).update({'pspl': pspl});
  }

  @override
  Future<UserProfileModel> updateScore({
    required String userId,
    required int newScore,
  }) async {
    // Calculate new rank and level
    final newRank = UserProfileEntity.calculateRank(newScore);
    final newLevel = UserProfileEntity.calculateLevel(newScore);

    await _userDocRef(userId).update({
      'score': newScore,
      'rank': newRank,
      'level': newLevel,
    });

    // Return updated profile
    return getUserProfile(userId);
  }

  @override
  Future<String> getUsername(String userId) async {
    final doc = await _userDocRef(userId).get();
    if (!doc.exists) return 'Unknown';
    
    final data = doc.data() as Map<String, dynamic>;
    return data['username'] as String? ?? 'Unknown';
  }

  @override
  Future<int> getScore(String userId) async {
    final doc = await _userDocRef(userId).get();
    if (!doc.exists) return 0;
    
    final data = doc.data() as Map<String, dynamic>;
    return data['score'] as int? ?? 0;
  }

  @override
  Future<String> getRank(String userId) async {
    final doc = await _userDocRef(userId).get();
    if (!doc.exists) return 'E';
    
    final data = doc.data() as Map<String, dynamic>;
    return data['rank'] as String? ?? 'E';
  }

  @override
  Future<int> getLevel(String userId) async {
    final doc = await _userDocRef(userId).get();
    if (!doc.exists) return 0;
    
    final data = doc.data() as Map<String, dynamic>;
    return data['level'] as int? ?? 0;
  }

  @override
  Future<String> getPspl(String userId) async {
    final doc = await _userDocRef(userId).get();
    if (!doc.exists) return 'C++';
    
    final data = doc.data() as Map<String, dynamic>;
    return data['pspl'] as String? ?? 'C++';
  }
}
