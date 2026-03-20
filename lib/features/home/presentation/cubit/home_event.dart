import 'package:equatable/equatable.dart';
import 'package:social_media_app_using_firebase/features/create_post/domain/entities/comment.dart';

sealed class HomeEvent extends Equatable {}

class FetchAllPostEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class RefreshPostEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class FetchAllPostByUserIdEvent extends HomeEvent {
  final String userId;

  FetchAllPostByUserIdEvent({required this.userId});
  @override
  List<Object?> get props => [];
}

class DeletePostEvent extends HomeEvent {
  final String postId;

  DeletePostEvent({required this.postId});
  @override
  List<Object?> get props => [];
}

class ToggleLikePostEvent extends HomeEvent {
  final String postId;
  final String userId;

  ToggleLikePostEvent({required this.postId, required this.userId});
  @override
  List<Object?> get props => [];
}

class AddCommentEvent extends HomeEvent {
  final String postId;
  final Comment comment;

  AddCommentEvent({required this.postId, required this.comment});
  @override
  List<Object?> get props => [];
}

class DeleteCommentEvent extends HomeEvent {
  final String postId;
  final Comment comment;

  DeleteCommentEvent({required this.postId, required this.comment});
  @override
  List<Object?> get props => [];
}
