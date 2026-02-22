import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// TODO: Migrate to AuthCubit - inject userId from repository instead of FirebaseAuth.instance
class UserData {
  final user = FirebaseAuth.instance.currentUser;
  int score = 0;
  int level = 0;
  String rank = "E";

  /// Safe getter for current user ID. Returns empty string if not logged in.
  /// TODO: Replace with injected userId from AuthCubit/Repository
  String get _currentUserId => FirebaseAuth.instance.currentUser?.uid ?? '';

  UserData() {
    updateRankAndLevel();
  }

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");

  // Helper method to update rank and level based on score
  Future<void> updateRankAndLevel() async {
    score = await getScore();
    if (score < 10) {
      level = 0;
      rank = "E";
    } else if (score >= 10 && score < 70) {
      level = 1;
      rank = "D";
    } else if (score >= 70 && score < 150) {
      level = 2;
      rank = "C";
    } else if (score >= 150 && score < 300) {
      level = 3;
      rank = "B";
    } else if (score >= 300 && score < 600) {
      level = 4;
      rank = "A";
    } else if (score > 600 && score < 1000) {
      level = 5;
      rank = "A+";
    } else if (score > 1000 && score < 1500) {
      level = 5;
      rank = "A++";
    } else if (score >= 1500) {
      level = 6;
      rank = "S";
    }
    updateLevel(level);
    updateRank(rank);
  }

  // Function to add or update the user's document in "users/{userId}/userdata"
  Future<void> addUser(String username) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User not authenticated.");
      return;
    }

    final userId = user.uid;
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      await userDoc.set({
        'username': username,
        'id': userId,
        'score': 0,
        'level': 0,
        "rank": "E",
        "pro_image": user.photoURL ?? "Default Image URL",
        "pspl": "C++",
      }, SetOptions(merge: true));
      print("User data added or updated successfully!");
    } catch (e) {
      print("Error adding user data: $e");
    }
  }

  Future<void> updateUserpspl(String PSPL) async {
    final userId = _currentUserId;
    if (userId.isEmpty) return; // Guard: user not logged in
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      await userDoc.update({'pspl': PSPL});
      print("pspl updated successfully!");
    } catch (e) {
      print("Error updating pspl: $e");
    }
  }

  Future<String> getUserpspl() async {
    final userId = _currentUserId;
    if (userId.isEmpty) return "Default PSPL"; // Guard: user not logged in
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      DocumentSnapshot doc = await userDoc.get();
      if (doc.exists) {
        final PSPL = (doc.data() as Map<String, dynamic>)['pspl'] as String?;
        if (PSPL != null) {
          return PSPL;
        } else {
          print("PSPL field is missing");
          return "Default PSPL"; // Provide a default PSPL
        }
      } else {
        print("User data document not found");
        return "Default PSPL"; // Provide a default PSPL
      }
    } catch (e) {
      print("Error retrieving PSPL: $e");
      return "Error PSPL"; // Provide a fallback PSPL in case of an error
    }
  }

  // Function to store or update the user's profile image URL
  Future<void> updateUserImage(String imageUrl) async {
    final userId = _currentUserId;
    if (userId.isEmpty) return; // Guard: user not logged in
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      await userDoc.update({'image_url': imageUrl});
      print("User image updated successfully!");
    } catch (e) {
      print("Error updating user image: $e");
    }
  }

  // Function to retrieve the user's profile image URL
  Future<String?> getUserImage() async {
    final userId = _currentUserId;
    if (userId.isEmpty) return null; // Guard: user not logged in
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      DocumentSnapshot doc = await userDoc.get();
      if (doc.exists) {
        return (doc.data() as Map<String, dynamic>)['image_url'] as String?;
      } else {
        print("User image not found in the document.");
      }
    } catch (e) {
      print("Error retrieving user image: $e");
    }
    return null; // Return null if no image URL is found
  }

  // Function to retrieve the username of the current user
  Future<String> getUsername() async {
    final userId = _currentUserId;
    if (userId.isEmpty) return "Guest"; // Guard: user not logged in
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      DocumentSnapshot doc = await userDoc.get();
      if (doc.exists) {
        final username =
            (doc.data() as Map<String, dynamic>)['username'] as String?;
        if (username != null) {
          return username;
        } else {
          print("Username field is missing");
          return "Default Username"; // Provide a default username
        }
      } else {
        print("User data document not found");
        return "Default Username"; // Provide a default username
      }
    } catch (e) {
      print("Error retrieving username: $e");
      return "Error Username"; // Provide a fallback username in case of an error
    }
  }

  // Function to retrieve the user ID
  // TODO: Inject userId from AuthCubit instead of accessing FirebaseAuth directly
  String getUserId() {
    return _currentUserId;
  }

  // Function to update the username of the current user
  Future<void> updateUsername(String newUsername) async {
    final userId = _currentUserId;
    if (userId.isEmpty) return; // Guard: user not logged in
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      await userDoc.update({'username': newUsername});
      print("Username updated successfully!");
    } catch (e) {
      print("Error updating username: $e");
    }
  }

  // Function to retrieve the user's score
  Future<int> getScore() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      DocumentSnapshot doc = await userDoc.get();
      if (doc.exists) {
        return (doc.data() as Map<String, dynamic>)['score'] ?? 0;
      }
    } catch (e) {
      print("Error retrieving score: $e");
    }
    return 0; // Default score
  }

  // Function to retrieve the user's level
  Future<int> getLevel() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      DocumentSnapshot doc = await userDoc.get();
      if (doc.exists) {
        return (doc.data() as Map<String, dynamic>)['level'] ?? 0;
      }
    } catch (e) {
      print("Error retrieving level: $e");
    }
    return 0; // Default level
  }

  // Function to retrieve the user's rank
  Future<String> getRank() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      DocumentSnapshot doc = await userDoc.get();
      if (doc.exists) {
        return (doc.data() as Map<String, dynamic>)['rank'] ?? "E";
      }
    } catch (e) {
      print("Error retrieving rank: $e");
    }
    return "E"; // Default rank
  }

  // Function to update the user's score
  Future<void> updateScore(int newScore) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      await userDoc.update({'score': newScore});
      score = newScore;
      updateRankAndLevel(); // Update rank and level locally
      print("Score updated successfully!");
    } catch (e) {
      print("Error updating score: $e");
    }
  }

  // Function to update the user's level
  Future<void> updateLevel(int newLevel) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      await userDoc.update({'level': newLevel});
      level = newLevel;
      print("Level updated successfully!");
    } catch (e) {
      print("Error updating level: $e");
    }
  }

  // Function to update the user's rank
  Future<void> updateRank(String newRank) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userDoc =
        usersCollection.doc(userId).collection("userdata").doc("info");

    try {
      await userDoc.update({'rank': newRank});
      rank = newRank;
      print("Rank updated successfully!");
    } catch (e) {
      print("Error updating rank: $e");
    }
  }
}
