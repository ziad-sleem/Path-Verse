
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media_app_using_firebase/features/auth/domain/repos/auth_repo.dart';
import 'package:social_media_app_using_firebase/features/create_post/domain/repo/post_repo.dart';
import 'package:social_media_app_using_firebase/features/profile/domain/models/profile_user.dart';
import 'package:social_media_app_using_firebase/features/profile/domain/repos/profile_repo.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepo authRepo;
  final PostRepo postRepo;
  final ProfileRepo profileRepo;

  ProfileCubit({
    required this.authRepo,
    required this.postRepo,
    required this.profileRepo,
  }) : super(ProfileInitial());

  // fetch user profile using repo , to loading single profile pages
  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());

      final user = await profileRepo.fetchUserData(uid: uid);

      // check if current user is following this user
      final followers = await profileRepo.fetchFollowers(uid: uid);
      final currentUser = await authRepo.getCurrentUser();
      final isFollowing =
          followers?.followers.contains(currentUser?.uid) ?? false;

      emit(ProfileLoaded(profileUser: user, isFollowing: isFollowing));
    } catch (e) {
      emit(ProfileError(errorMessage: e.toString()));
    }
  }

  // return user profile given uid , to load many profiles for posts
  Future<ProfileUser?> getUserProfile(String id) async {
    final user = await profileRepo.fetchUserData(uid: id);
    return user;
  }

  Future<void> updateUser({
    required String uid,
    String? username,
    String? bio,
    String? profileImage,
    String? phoneNumber,
  }) async {
    try {
      emit(ProfileLoading());

      // send ONLY changed fields to Firestore
      await profileRepo.updateUser(
        uid: uid,
        bio: bio,
        profileImage: profileImage,
        username: username,
        phoneNumber: phoneNumber,
      );

      // re-fetch updated user from Firestore
      final updatedUser = await profileRepo.fetchUserData(uid: uid);


      // Keep follow status or re-check
      final followers = await profileRepo.fetchFollowers(uid: uid);
      final currentUser = await authRepo.getCurrentUser();
      final isFollowing =
          followers?.followers.contains(currentUser?.uid) ?? false;

      emit(ProfileLoaded(profileUser: updatedUser, isFollowing: isFollowing));

    } catch (e) {
      emit(ProfileError(errorMessage: (e.toString())));
    }
  }

  // toggle follow/unfollow
  Future<void> toggleFollow(
    String currentUserId,
    String targetUserId,
    bool isCurrentlyFollowing,
  ) async {
    // Optimistic update
    if (state is ProfileLoaded) {
      final currentLoadedState = state as ProfileLoaded;
      final updatedUser = currentLoadedState.profileUser.copyWith(
        followersCount: isCurrentlyFollowing
            ? (currentLoadedState.profileUser.followersCount ?? 0) - 1
            : (currentLoadedState.profileUser.followersCount ?? 0) + 1,
      );
      emit(
        ProfileLoaded(
          profileUser: updatedUser,
          isFollowing: !isCurrentlyFollowing,
        ),
      );
    }

    try {
      if (isCurrentlyFollowing) {
        // Currently following, so unfollow
        await profileRepo.removeFollow(
          uid: targetUserId,
          followHow: currentUserId,
        );
      } else {
        // Not following, so follow
        await profileRepo.follow(uid: targetUserId, followHow: currentUserId);
      }
      // Refresh the target user's profile after toggle without showing loading
      await _fetchUserProfileData(targetUserId);
    } catch (e) {
      // If error occurs, refresh to ensure UI is in sync
      await fetchUserProfile(targetUserId);
      emit(ProfileError(errorMessage: (e.toString())));
    }
  }

  // Helper method to fetch and emit updated user data without ProfileLoading
  Future<void> _fetchUserProfileData(String uid) async {
    try {
      final user = await profileRepo.fetchUserData(uid: uid);
      final followers = await profileRepo.fetchFollowers(uid: uid);
      final currentUser = await authRepo.getCurrentUser();
      final isFollowing =
          followers?.followers.contains(currentUser?.uid) ?? false;

      emit(ProfileLoaded(profileUser: user, isFollowing: isFollowing));
    } catch (e) {
      // Don't emit error here to avoid breaking optimistic UI if re-fetch fails
      // but toggle succeeded. Logging could be added.
    }
  }

  // fetch followers for a specific user
  Future<List<String>> getFollowers(String uid) async {
    final followers = await profileRepo.fetchFollowers(uid: uid);
    final list = followers?.followers ?? [];
    return list;
  }

  // fetch following for a specific user
  Future<List<String>> getFollowing(String uid) async {
    final following = await profileRepo.fetchFollowings(uid: uid);
    final list = following?.following ?? [];
    return list;
  }
}
