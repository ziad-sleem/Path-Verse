import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_using_firebase/core/widgets/app_text.dart';
import 'package:social_media_app_using_firebase/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app_using_firebase/features/auth/peresnetation/cubits/auth_cubit/auth_cubit.dart';
import 'package:social_media_app_using_firebase/features/home/presentation/cubit/home_cubit.dart';
import 'package:social_media_app_using_firebase/features/home/presentation/cubit/home_event.dart';
import 'package:social_media_app_using_firebase/features/home/presentation/widgets/post_widgets/post_actions.dart';
import 'package:social_media_app_using_firebase/features/home/presentation/widgets/post_widgets/post_caption.dart';
import 'package:social_media_app_using_firebase/features/home/presentation/widgets/post_widgets/post_comment_count.dart';
import 'package:social_media_app_using_firebase/features/home/presentation/widgets/post_widgets/post_image.dart';
import 'package:social_media_app_using_firebase/features/home/presentation/widgets/post_widgets/post_time_stamp.dart';
import 'package:social_media_app_using_firebase/features/home/presentation/widgets/post_widgets/post_user_info.dart';
import 'package:social_media_app_using_firebase/features/create_post/domain/entities/post.dart';
import 'package:social_media_app_using_firebase/features/create_post/presentation/cubit/post_cubit.dart';
import 'package:social_media_app_using_firebase/features/home/presentation/widgets/comment_widgets/comment_sheet.dart';
import 'package:social_media_app_using_firebase/features/profile/presentation/cubits/cubit/profile_cubit.dart';
import 'package:social_media_app_using_firebase/features/profile/domain/models/profile_user.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  ProfileUser? postUser;

  @override
  void initState() {
    super.initState();
    _fetchPostUser();
  }

  void _fetchPostUser() async {
    final profileCubit = context.read<ProfileCubit>();
    final user = await profileCubit.getUserProfile(widget.post.userId);
    if (mounted) {
      setState(() {
        postUser = user;
      });
    }
  }

  @override
  void didUpdateWidget(PostWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.post.id != widget.post.id) {
      _fetchPostUser();
    }
  }

  // like
  Future<void> toggleLikePost(String postId) async {
    final user = context.read<AuthCubit>().currentUser;
    if (user == null) return;

    // current like status
    final isLiked = widget.post.likes.contains(user.uid);

    // optimistically like and update UI
    setState(() {
      if (isLiked) {
        widget.post.likes.remove(user.uid);
      } else {
        widget.post.likes.add(user.uid);
      }
    });

    // update like
    await context
        .read<HomeCubit>().doEvent(ToggleLikePostEvent(postId: postId, userId: user.uid)).catchError((error) {
          setState(() {
            if (isLiked) {
              widget.post.likes.add(user.uid);
            } else {
              widget.post.likes.remove(user.uid);
            }
          });
        });
  }

  // comment process
  void showCommentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: context.read<HomeCubit>(),
        child: CommentSheet(post: widget.post),
      ),
    );
  }

  final TextEditingController commentController = TextEditingController();

  // delete post options
  void showDeleteActions(String postId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: AppText(text: "Delete Post"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: AppText(text: 'Cancle'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<HomeCubit>().doEvent(DeletePostEvent(postId: postId));
              },
              child: AppText(text: 'Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get current user
    final currentUser = context.watch<AuthCubit>().currentUser;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // container above the image
          PostUserInfo(
            post: widget.post,
            postUser: postUser,
            showDeleteActions: () => showDeleteActions(widget.post.id),
          ),

          // post image
          PostImage(post: widget.post),

          // Like , comment , shares
          PostActions(
            post: widget.post,
            onLikeTap: () => toggleLikePost(widget.post.id),
            onCommentTap: showCommentSheet,
            userId: currentUser?.uid ?? '',
          ),

          // Caption: Username + Text
          PostCaption(post: widget.post, postUser: postUser),

          // Comment count
          if (widget.post.comments.isNotEmpty)
            PostCommentCount(
              post: widget.post,
              showCommentSheet: showCommentSheet,
            ),

          // Timestamp
          PostTimeStamp(post: widget.post),
        ],
      ),
    );
  }
}
