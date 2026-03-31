
part of 'create_video_cubit.dart';

sealed class CreateVideoState extends Equatable {
  const CreateVideoState();

  @override
  List<Object> get props => [];
}

final class CreateVideoInitial extends CreateVideoState {}

final class CreateVideoLoading extends CreateVideoState {}

final class CreateVideoUpLoading extends CreateVideoState {}

final class CreateVideoLoaded extends CreateVideoState {
  final List<VideoEntity> videos;

  const CreateVideoLoaded({required this.videos});
  @override
  List<Object> get props => [videos];
}

final class CreateVideoError extends CreateVideoState {
  final String errorMessage;

  const CreateVideoError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
sealed class CreateVistasState extends Equatable {
  const CreateVistasState();

  @override
  List<Object> get props => [];
}

final class CreateVistasInitial extends CreateVistasState {}

final class CreateVistasLoading extends CreateVistasState {}

final class CreateVistasUpLoading extends CreateVistasState {}

final class CreateVistasLoaded extends CreateVistasState {
  final List<VideoEntity> videos;

  const CreateVistasLoaded({required this.videos});
  @override
  List<Object> get props => [videos];
}

final class CreateVistasError extends CreateVistasState {
  final String errorMessage;

  const CreateVistasError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
