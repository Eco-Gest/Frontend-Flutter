import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/like/like_cubit.dart';
import 'package:ecogest_front/state_management/posts/participation_cubit.dart';
import 'package:ecogest_front/widgets/post/like_widget.dart';
import 'package:ecogest_front/widgets/post/participation_widet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';

class PostContentButtons extends StatelessWidget {
  PostContentButtons({
    super.key,
    required this.isChallenge,
    this.likes,
    required this.isLiked,
    required this.post,
    this.comments,
  });

  final PostModel post;
  final bool? isChallenge;
  int? likes;
  final List? comments;
  bool isLiked;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationCubit>().state.user;
    final int postId = post.id!;

    return Column(
      children: [
        Row(
          children: [
            if (likes == 1) ...[
              TextButton(
                onPressed: () {
                  // TODO : Afficher les likes
                },
                child: Text(
                  '$likes like',
                  style: TextStyle(color: lightColorScheme.onBackground),
                ),
              ),
            ],
            if (likes! > 1) ...[
              TextButton(
                onPressed: () {
                  //
                },
                child: Text(
                  '$likes likes',
                  style: TextStyle(color: lightColorScheme.onBackground),
                ),
              ),
            ],
            if (likes! > 0 && comments!.isNotEmpty) ...[
              const Text(' | '),
            ],
            if (comments!.isNotEmpty) ...[
              TextButton(
                  onPressed: () {
                    GoRouter.of(context)
                        .push('/posts/$postId/comments', extra: comments);
                  },
                  child: Text(
                    '${comments!.length} commentaires',
                    style: TextStyle(color: lightColorScheme.onBackground),
                  )),
            ]
          ],
        ),
        const PostSeparator(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LikeWidget(postId: post.id!, isLiked: isLiked),
            IconButton(
              onPressed: () {
                GoRouter.of(context)
                    .push('/posts/$postId/comments', extra: comments);
              },
              color: lightColorScheme.primary,
              icon: const Icon(Icons.comment),
            ),
            IconButton(
              onPressed: () {
                debugPrint('Click pour partager la publication');
                // TODO : Partager la publication
              },
              color: lightColorScheme.primary,
              icon: const Icon(Icons.share),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (isChallenge!) ...[
          BlocProvider<ParticipationCubit>(
            create: (_) => ParticipationCubit(),
            child: ParticipationWidget(
                postId: post.id!,
                isAlreadyParticipant: post.userPostParticipation!.any(
                    (participation) =>
                        participation.participantId! == user!.id!)),
          ),
        ]
      ],
    );
  }
}
