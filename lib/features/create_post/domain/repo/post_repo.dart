import 'package:social_media_app_using_firebase/features/create_post/domain/entities/post.dart';

abstract class PostRepo {
  Future<void> createPost(Post post);
}
