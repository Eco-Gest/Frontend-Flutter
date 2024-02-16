import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/like/like_cubit.dart';
import 'package:ecogest_front/state_management/posts/participation_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/post/participation_widet.dart';
import 'package:ecogest_front/widgets/post/post_content_author.dart';
import 'package:ecogest_front/widgets/post/post_content_buttons.dart';
import 'package:ecogest_front/widgets/post/post_content_infos.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnePostWidget extends StatefulWidget {
  const OnePostWidget({required this.post, super.key});

  static String name = 'post';
  final PostModel post;

  @override
  _OnePostWidget createState() => _OnePostWidget();
}

class _OnePostWidget extends State<OnePostWidget> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    setState(() {
      context.read<PostsCubit>().getOnePost(widget.post.id!, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user = context.watch<AuthenticationCubit>().state.user;
    final post = widget.post;
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: refreshData,
      child: ListView(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Author info
                    PostContentAuthor(
                        postId: widget.post.id!,
                        author: post.user,
                        position: post!.position,
                        date: post!.createdAt),
                    const PostSeparator(),
                    // Post info
                    PostContentInfos(
                      post: post,
                    ),
                    // Buttons
                    BlocProvider<LikeCubit>(
                      create: (context) => LikeCubit(),
                      child: PostContentButtons(
                        post: post,
                        likes: post.likes!.length,
                        isLiked:
                            post.likes!.any((like) => like.userId == user!.id!),
                        comments: post.comments,
                        isChallenge: (post.type.toString() == 'challenge')
                            ? true
                            : false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
