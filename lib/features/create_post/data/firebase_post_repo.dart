import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media_app_using_firebase/features/auth/domain/repos/auth_repo.dart';
import 'package:social_media_app_using_firebase/features/create_post/domain/entities/post.dart';
import 'package:social_media_app_using_firebase/features/create_post/domain/repo/post_repo.dart';
import 'package:social_media_app_using_firebase/features/profile/domain/repos/profile_repo.dart';

@LazySingleton(as: PostRepo)
class FirebasePostRepo implements PostRepo {
  final FirebaseFirestore firebaseFirestore;

  // Use interfaces instead of concrete classes for better decoupling
  final ProfileRepo profileRepo;
  final AuthRepo authRepo;

  FirebasePostRepo({
    required this.firebaseFirestore,
    required this.profileRepo,
    required this.authRepo,
  });

  // Helper for collection reference
  CollectionReference get postCollection =>
      firebaseFirestore.collection('posts');


  @override
  Future<void> createPost(Post post) async {
    try {
      await postCollection.doc(post.id).set(post.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  
}
