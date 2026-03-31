import 'package:social_media_app_using_firebase/features/create_video/domain/entities/video_entity.dart';

abstract class VideoRepo {
  Future<void> createVideo(VideoEntity video);
  Future<List<VideoEntity>> fetchAllVideos();
}