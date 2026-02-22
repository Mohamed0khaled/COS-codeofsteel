import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coursesapp/features/user_profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:coursesapp/features/user_profile/domain/usecases/update_username_usecase.dart';
import 'package:coursesapp/features/user_profile/domain/usecases/update_profile_image_usecase.dart';
import 'package:coursesapp/features/user_profile/domain/usecases/update_score_usecase.dart';
import 'package:coursesapp/features/user_profile/domain/usecases/create_user_profile_usecase.dart';
import 'package:coursesapp/features/user_profile/presentation/cubit/profile_state.dart';

/// Cubit for managing user profile state.
/// 
/// Handles all profile-related business operations and state transitions.
class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUsernameUseCase _updateUsernameUseCase;
  final UpdateProfileImageUseCase _updateProfileImageUseCase;
  final UpdateScoreUseCase _updateScoreUseCase;
  final CreateUserProfileUseCase _createUserProfileUseCase;

  ProfileCubit({
    required GetUserProfileUseCase getUserProfileUseCase,
    required UpdateUsernameUseCase updateUsernameUseCase,
    required UpdateProfileImageUseCase updateProfileImageUseCase,
    required UpdateScoreUseCase updateScoreUseCase,
    required CreateUserProfileUseCase createUserProfileUseCase,
  })  : _getUserProfileUseCase = getUserProfileUseCase,
        _updateUsernameUseCase = updateUsernameUseCase,
        _updateProfileImageUseCase = updateProfileImageUseCase,
        _updateScoreUseCase = updateScoreUseCase,
        _createUserProfileUseCase = createUserProfileUseCase,
        super(const ProfileInitial());

  /// Load the user profile for the given user ID
  Future<void> loadProfile(String userId) async {
    if (userId.isEmpty) {
      emit(const ProfileError('User not logged in'));
      return;
    }

    emit(const ProfileLoading());

    final result = await _getUserProfileUseCase(
      GetUserProfileParams(userId: userId),
    );

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  /// Refresh the profile data
  Future<void> refreshProfile(String userId) async {
    if (userId.isEmpty) return;

    // Keep current profile while refreshing
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileUpdating(currentState.profile));
    } else {
      emit(const ProfileLoading());
    }

    final result = await _getUserProfileUseCase(
      GetUserProfileParams(userId: userId),
    );

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  /// Update the username
  Future<void> updateUsername({
    required String userId,
    required String newUsername,
  }) async {
    final currentState = state;
    if (currentState is! ProfileLoaded) return;

    emit(ProfileUpdating(currentState.profile));

    final result = await _updateUsernameUseCase(
      UpdateUsernameParams(userId: userId, newUsername: newUsername),
    );

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) {
        final updatedProfile = currentState.profile.copyWith(username: newUsername);
        emit(ProfileUpdateSuccess(
          profile: updatedProfile,
          message: 'Username updated successfully',
        ));
        // Return to loaded state after success
        emit(ProfileLoaded(updatedProfile));
      },
    );
  }

  /// Update the profile image
  Future<void> updateProfileImage({
    required String userId,
    required String imageUrl,
  }) async {
    final currentState = state;
    if (currentState is! ProfileLoaded) return;

    emit(ProfileUpdating(currentState.profile));

    final result = await _updateProfileImageUseCase(
      UpdateProfileImageParams(userId: userId, imageUrl: imageUrl),
    );

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) {
        final updatedProfile = currentState.profile.copyWith(imageUrl: imageUrl);
        emit(ProfileUpdateSuccess(
          profile: updatedProfile,
          message: 'Profile image updated successfully',
        ));
        emit(ProfileLoaded(updatedProfile));
      },
    );
  }

  /// Update the score
  Future<void> updateScore({
    required String userId,
    required int newScore,
  }) async {
    final currentState = state;
    if (currentState is! ProfileLoaded) return;

    emit(ProfileUpdating(currentState.profile));

    final result = await _updateScoreUseCase(
      UpdateScoreParams(userId: userId, newScore: newScore),
    );

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (updatedProfile) {
        emit(ProfileUpdateSuccess(
          profile: updatedProfile,
          message: 'Score updated successfully',
        ));
        emit(ProfileLoaded(updatedProfile));
      },
    );
  }

  /// Create initial profile for a new user
  Future<void> createProfile({
    required String userId,
    required String username,
    String? photoUrl,
  }) async {
    emit(const ProfileLoading());

    final result = await _createUserProfileUseCase(
      CreateUserProfileParams(
        userId: userId,
        username: username,
        photoUrl: photoUrl,
      ),
    );

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => loadProfile(userId), // Load the newly created profile
    );
  }
}
