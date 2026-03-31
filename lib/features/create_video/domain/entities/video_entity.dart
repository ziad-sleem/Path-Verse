import 'package:social_media_app_using_firebase/features/create_post/domain/entities/comment.dart';

class VideoEntity {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final String caption;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final String videoCover;
  final DateTime timeStamp;
  final List<String> likes; // store uids
  final List<String> disLikes; // store uids
  final List<Comment> comments;

  VideoEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.caption,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.videoCover,
    required this.timeStamp,
    required this.likes,
    required this.disLikes,
    required this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'caption': caption,
      'description': description,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'videoCover': videoCover,
      'timeStamp': timeStamp.millisecondsSinceEpoch,
      'likes': likes,
      'disLikes': disLikes,
      'comments': comments.map((x) => x.toJson()).toList(),
    };
  }

  factory VideoEntity.fromMap(Map<String, dynamic> json) {
    return VideoEntity(
      id: json['id'],
      userName: json['userName'],
      userImage: json['userImage'],
      userId: json['userId'],
      caption: json['caption'],
      description: json['description'],
      videoUrl: json['videoUrl'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      videoCover: json['videoCover'] ?? '',
      timeStamp: json['timeStamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['timeStamp'])
          : DateTime.now(),
      likes: List<String>.from(json['likes'] ?? []),
      disLikes: List<String>.from(json['disLikes'] ?? []),
      comments: List<Comment>.from(
        (json['comments'] as List?)?.map((x) => Comment.fromJson(x)) ?? [],
      ),
    );
  }
}
