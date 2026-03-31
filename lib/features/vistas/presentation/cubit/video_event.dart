abstract class VideoEvent {}

class VideoPickedEvent extends VideoEvent { 
  final bool fromGallery; 
  VideoPickedEvent(this.fromGallery); 
}

class FetchAllVideosEvent extends VideoEvent {}

class FetchAllVideosByUserIdEvent extends VideoEvent {
  final String userId;
  FetchAllVideosByUserIdEvent(this.userId);
}

class LikeVideoEvent extends VideoEvent {
  final String videoId;
  final String userId;
  LikeVideoEvent(this.videoId, this.userId);
}

class DislikeVideoEvent extends VideoEvent {
  final String videoId;
  final String userId;
  DislikeVideoEvent(this.videoId, this.userId);
}