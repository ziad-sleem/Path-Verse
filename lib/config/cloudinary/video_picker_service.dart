import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VideoPickerService {
  final ImagePicker _picker = ImagePicker();

  /// Pick a video from gallery
  Future<File?> pickVideoFromGallery({Duration maxDuration = const Duration(minutes: 10)}) async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: maxDuration,
      );

      return video != null ? File(video.path) : null;
    } catch (e) {
      print('Failed to pick video from gallery: $e');
      return null;
    }
  }

  /// Pick a video from camera
  Future<File?> pickVideoFromCamera({Duration maxDuration = const Duration(minutes: 10)}) async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: maxDuration,
      );

      return video != null ? File(video.path) : null;
    } catch (e) {
      print('Failed to pick video from camera: $e');
      return null;
    }
  }
}
