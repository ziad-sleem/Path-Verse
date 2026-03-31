import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media_app_using_firebase/features/create_video/domain/entities/video_entity.dart';
import 'package:social_media_app_using_firebase/features/create_video/domain/repo/video_repo.dart';

@Injectable(as: VideoRepo)
class FirebaseVideoRepo implements VideoRepo {
  final FirebaseFirestore firebaseFirestore;

  FirebaseVideoRepo({required this.firebaseFirestore});

  // Helper for collection reference
  CollectionReference get videoCollection =>
      firebaseFirestore.collection('videos');

  @override
  Future<void> createVideo(VideoEntity video) async {
     try {
      await videoCollection.doc(video.id).set(video.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<VideoEntity>> fetchAllVideos() async {
    try {
      final snapshot = await videoCollection.orderBy('timeStamp', descending: true).get();
      return snapshot.docs.map((doc) => VideoEntity.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
