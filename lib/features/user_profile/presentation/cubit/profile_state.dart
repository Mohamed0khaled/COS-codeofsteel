import 'package:equatable/equatable.dart';
import 'package:coursesapp/features/user_profile/domain/entities/user_profile_entity.dart';

/// Base class for all profile states
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any data is loaded
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Loading state while fetching profile data
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// Profile data loaded successfully
class ProfileLoaded extends ProfileState {
  final UserProfileEntity profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Error state when something goes wrong
class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

/// State while updating profile (username, image, etc.)
class ProfileUpdating extends ProfileState {
  final UserProfileEntity currentProfile;

  const ProfileUpdating(this.currentProfile);

  @override
  List<Object?> get props => [currentProfile];
}

/// State after successful update
class ProfileUpdateSuccess extends ProfileState {
  final UserProfileEntity profile;
  final String message;

  const ProfileUpdateSuccess({
    required this.profile,
    required this.message,
  });

  @override
  List<Object?> get props => [profile, message];
}
