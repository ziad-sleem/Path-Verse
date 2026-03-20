part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileLoaded extends ProfileState {
  final ProfileUser profileUser;
  final bool isFollowing;

  ProfileLoaded({required this.profileUser, required this.isFollowing});
  @override
  List<Object?> get props => [profileUser, isFollowing];
}

final class ProfileError extends ProfileState {
  final String errorMessage;

  ProfileError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
