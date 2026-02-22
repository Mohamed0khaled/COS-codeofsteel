import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:coursesapp/core/errors/exceptions.dart';
import 'package:coursesapp/core/constants/firebase_constants.dart';
import 'package:coursesapp/features/auth/data/models/user_model.dart';

/// Abstract interface for auth remote data source.
/// 
/// Defines all remote authentication operations.
abstract class AuthRemoteDataSource {
  /// Sign in with email and password.
  /// Throws [AuthException] on failure.
  Future<UserModel> login({
    required String email,
    required String password,
  });

  /// Register with email, password, and optional username.
  /// Throws [AuthException] on failure.
  Future<UserModel> register({
    required String email,
    required String password,
    String? username,
  });

  /// Sign in with Google.
  /// Throws [AuthException] on failure.
  Future<UserModel> signInWithGoogle();

  /// Get current authenticated user.
  /// Throws [AuthException] if no user is logged in.
  Future<UserModel> getCurrentUser();

  /// Sign out current user.
  /// Throws [AuthException] on failure.
  Future<void> logout();

  /// Send email verification.
  /// Throws [AuthException] on failure.
  Future<void> sendEmailVerification();

  /// Reload user data from Firebase.
  /// Throws [AuthException] on failure.
  Future<UserModel> reloadUser();

  /// Stream of auth state changes.
  Stream<UserModel?> get authStateChanges;
}

/// Implementation of AuthRemoteDataSource using Firebase.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException(message: 'Login failed. No user returned.');
      }

      return UserModel.fromFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        message: _mapFirebaseAuthError(e.code),
        code: e.code.hashCode,
      );
    } catch (e) {
      throw AuthException(message: 'Login failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    String? username,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const AuthException(message: 'Registration failed. No user returned.');
      }

      final user = credential.user!;

      // Store user data in Firestore
      await _createUserDocument(user.uid, username, email, user.photoURL);

      // Send email verification
      await user.sendEmailVerification();

      return UserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        message: _mapFirebaseAuthError(e.code),
        code: e.code.hashCode,
      );
    } catch (e) {
      throw AuthException(message: 'Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw const AuthException(message: 'Google Sign-In was cancelled.');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw const AuthException(message: 'Google Sign-In failed. No user returned.');
      }

      final user = userCredential.user!;

      // Create or update user document in Firestore
      await _createUserDocument(
        user.uid,
        user.displayName,
        user.email ?? '',
        user.photoURL,
      );

      return UserModel.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        message: _mapFirebaseAuthError(e.code),
        code: e.code.hashCode,
      );
    } catch (e) {
      throw AuthException(message: 'Google Sign-In failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw const AuthException(message: 'No user is currently signed in.');
      }

      return UserModel.fromFirebaseUser(user);
    } catch (e) {
      throw AuthException(message: 'Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw AuthException(message: 'Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw const AuthException(message: 'No user is currently signed in.');
      }

      await user.sendEmailVerification();
    } catch (e) {
      throw AuthException(message: 'Failed to send verification email: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> reloadUser() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw const AuthException(message: 'No user is currently signed in.');
      }

      await user.reload();
      final refreshedUser = _firebaseAuth.currentUser;

      if (refreshedUser == null) {
        throw const AuthException(message: 'Failed to reload user.');
      }

      return UserModel.fromFirebaseUser(refreshedUser);
    } catch (e) {
      throw AuthException(message: 'Failed to reload user: ${e.toString()}');
    }
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    });
  }

  /// Create or update user document in Firestore.
  Future<void> _createUserDocument(
    String uid,
    String? username,
    String email,
    String? photoUrl,
  ) async {
    final userDoc = _firestore
        .collection(FirebaseConstants.usersCollection)
        .doc(uid)
        .collection(FirebaseConstants.userDataDoc)
        .doc(FirebaseConstants.userInfoDoc);

    await userDoc.set({
      FirebaseConstants.fieldUsername: username ?? 'User',
      FirebaseConstants.fieldUserId: uid,
      FirebaseConstants.fieldScore: 0,
      FirebaseConstants.fieldLevel: 0,
      FirebaseConstants.fieldRank: 'E',
      FirebaseConstants.fieldProfileImage: photoUrl ?? '',
      FirebaseConstants.fieldPspl: 'C++',
    }, SetOptions(merge: true));
  }

  /// Map Firebase Auth error codes to user-friendly messages.
  String _mapFirebaseAuthError(String code) {
    switch (code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      case 'invalid-credential':
        return 'The email or password is incorrect.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
