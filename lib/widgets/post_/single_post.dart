import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/like/like_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/widgets/post_/post_header/post_header.dart';
import 'package:ecogest_front/widgets/post_/post_body/post_body.dart';
import 'package:ecogest_front/widgets/post_/post_footer/post_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// SinglePostWidget is a widget that displays a single post
// It contains the header, body and footer of the post

class SinglePostWidget extends StatelessWidget {
  const SinglePostWidget({
    required this.post,
    Key? key,
  }) : super(key: key);

  final PostModel post;

  bool canEndChallenge(PostModel post, BuildContext context) {
    if (post.type == 'challenge' && post.userPostParticipation != null) {
      final user = context.read<AuthenticationCubit>().state.user;
      if (post.userPostParticipation!
          .where((upp) =>
              upp.isCompleted == false &&
              upp.participantId == user!.id)
          .isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user = context.watch<AuthenticationCubit>().state.user;

    return RefreshIndicator(
        onRefresh: () async {
          context.read<PostsCubit>().getOnePost(post.id!, true);
        },
        child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Post header
                  PostHeader(
                    author: post.user,
                    position: post.position,
                    date: post.createdAt,
                    post: post,
                  ),
                  const SizedBox(height: 16),
                  // Post body
                  PostBody(
                    post: post,
                  ),
                  const SizedBox(height: 16),
                  // Post footer
                  BlocProvider<LikeCubit>(
                    create: (context) => LikeCubit(),
                    child: PostFooter(
                      post: post,
                      likes: post.likes!.length,
                      isLiked: post.likes!.any((like) => like.userId == user!.id!),
                      comments: post.comments,
                      isChallenge: (post.type.toString() == 'challenge'),
                      canEndChallenge: canEndChallenge(post, context),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
