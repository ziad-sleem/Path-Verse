import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media_app_using_firebase/config/cloudinary/cloudinary_service.dart';
import 'package:social_media_app_using_firebase/features/create_video/domain/entities/video_entity.dart';
import 'package:social_media_app_using_firebase/features/create_video/domain/repo/video_repo.dart';

part 'create_video_state.dart';

@injectable
class CreateVideoCubit extends Cubit<CreateVideoState> {
  final VideoRepo videoRepo;
  final CloudinaryService cloudinaryService;

  bool loaded = false;

  CreateVideoCubit({required this.videoRepo, required this.cloudinaryService})
    : super(CreateVideoInitial());

  Future<void> createVideo(
    VideoEntity video, {
    File? videoFile,
    File? coverFile,
  }) async {
    try {
      emit(CreateVideoLoading());
      emit(CreateVideoUpLoading());

      String videoUrl = video.videoUrl;
      String coverUrl = video.videoCover;

      // Upload video to Cloudinary if provided
      if (videoFile != null) {
        final uploadedVideoUrl = await cloudinaryService.uploadVideo(videoFile);
        if (uploadedVideoUrl != null) {
          videoUrl = uploadedVideoUrl;
        } else {
          throw Exception("Failed to upload video to Cloudinary");
        }
      }

      // Upload cover to Cloudinary if provided
      if (coverFile != null) {
        final uploadedCoverUrl = await cloudinaryService.uploadImage(coverFile);
        if (uploadedCoverUrl != null) {
          coverUrl = uploadedCoverUrl;
        }
      }

      // Create updated video with urls
      final newVideo = VideoEntity(
        id: video.id,
        userId: video.userId,
        caption: video.caption,
        videoUrl: videoUrl,
        description: video.description,
        userImage: video.userImage,
        userName: video.userName,
        thumbnailUrl: video.thumbnailUrl,
        videoCover: coverUrl,
        timeStamp: video.timeStamp,
        likes: video.likes,
        disLikes: video.disLikes,
        comments: video.comments,
      );

      // Save video to repository
      await videoRepo.createVideo(newVideo);

      // re-fetch all videos
      fetchAllVideos();
    } catch (e) {
      emit(
        CreateVideoError(
          errorMessage: 'Failed to create video: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> fetchAllVideos() async {
    try {
      if (loaded) return;
      emit(CreateVideoLoading());
      final videos = await videoRepo.fetchAllVideos();
      emit(CreateVideoLoaded(videos: videos));
    } catch (e) {
      emit(
        CreateVideoError(
          errorMessage: 'Failed to fetch videos: ${e.toString()}',
        ),
      );
    }
  }
}
