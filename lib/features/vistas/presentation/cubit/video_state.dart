import 'package:equatable/equatable.dart';
import 'package:social_media_app_using_firebase/features/create_video/domain/entities/video_entity.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {
  const VideoInitial();
}

class VideoLoading extends VideoState {
  const VideoLoading();
}

class VideoPicking extends VideoState {
  const VideoPicking();
}

class VideoUploading extends VideoState {
  final double progress;
  const VideoUploading(this.progress);

  @override
  List<Object?> get props => [progress];
}

class VideoReady extends VideoState {
  final String streamUrl;
  const VideoReady(this.streamUrl);

  @override
  List<Object?> get props => [streamUrl];
}

class VideosLoaded extends VideoState {
  final List<VideoEntity> videos;
  const VideosLoaded(this.videos);

  @override
  List<Object?> get props => [videos];
}

class VideoError extends VideoState {
  final String message;
  const VideoError(this.message);

  @override
  List<Object?> get props => [message];
}

class VideoActionLoading extends VideoState {
  final String videoId;
  const VideoActionLoading(this.videoId);

  @override
  List<Object?> get props => [videoId];
}