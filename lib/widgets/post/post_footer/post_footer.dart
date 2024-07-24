import 'package:ecogest_front/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/widgets/post/post_footer/post_footer_infos.dart';
import 'package:ecogest_front/widgets/post/post_footer/post_footer_actions.dart';
import 'package:ecogest_front/widgets/post/post_footer/post_footer_participation.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';
import 'package:ecogest_front/state_management/posts/participation_cubit.dart';
import 'package:go_router/go_router.dart';

// PostFooter is a widget that displays the footer of a post
// It contains widgets for
// the numbers of likes & comments, the actions (like & comment) 
// and the participation of the post if it's a challenge

class PostFooter extends StatefulWidget {
  PostFooter({
  super.key,
    required this.isChallenge,
    this.likes,
    required this.isLiked,
    required this.post,
    this.comments,
    required this.canEndChallenge,
  });

  final PostModel post;
  final bool? isChallenge;
  int? likes;
  final List? comments;
  bool isLiked;
  final bool canEndChallenge;

  @override
  _PostFooter createState() => _PostFooter();
}

class _PostFooter extends State<PostFooter> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationCubit>().state.user;
    final PostModel post = widget.post;
    final bool? isChallenge = widget.isChallenge;
    int? likes = widget.likes;
    final List? comments = widget.comments;
    bool isLiked = widget.isLiked;
    int postId = post.id!;
    bool canEndChallenge = widget.canEndChallenge;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostFooterInfos(
          likes: likes,
          comments: comments,
        ),
        const PostSeparator(),
        PostFooterActions(
          post: post,
          isLiked: isLiked,
          comments: comments,
        ),
        if (isChallenge! && GoRouterState.of(context).uri.toString() != "/${HomeView.name}") // Only show participation for challenges
          BlocProvider<ParticipationCubit>(
            create: (_) => ParticipationCubit(),
            child: PostFooterParticipation(
            postId: post.id!,
            isAlreadyParticipant: post.userPostParticipation!.any(
                (participation) => participation.participantId! == user!.id!,
              ),
            canEndChallenge: canEndChallenge, // Replace with actual logic
          ),
          ),
      ],
      ),
    );
  }
}
