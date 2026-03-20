part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeLoaded extends HomeState {
  final List<Post> posts;

  const HomeLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

final class HomeError extends HomeState {
  final String errorMessage;

 const HomeError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
