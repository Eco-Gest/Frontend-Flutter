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
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';

class PostContentButtons extends StatefulWidget {
  PostContentButtons({
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
  _PostContentButtons createState() => _PostContentButtons();
}

class _PostContentButtons extends State<PostContentButtons> {
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

    return Column(
      children: [
        Row(
          children: [
            if (likes != null && likes! > 0) ...[
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  // TODO : Afficher les likes
                },
                child: Text(
                  likes == 1 ? '$likes like' : '$likes likes',
                  style: TextStyle(
                    color: context.read<ThemeSettingsCubit>().state.isDarkMode
                        ? darkColorScheme.onBackground
                        : lightColorScheme.onBackground,
                  ),
                ),
              ),
              if (comments != null && comments!.isNotEmpty) const Text(' | '),
            ],
            if (comments != null && comments!.isNotEmpty) ...[
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  GoRouter.of(context).push('/posts/$postId/comments', extra: comments);
                },
                child: Text(
                  '${comments!.length} commentaires',
                  style: TextStyle(
                    color: context.read<ThemeSettingsCubit>().state.isDarkMode
                        ? darkColorScheme.onBackground
                        : lightColorScheme.onBackground,
                  ),
                ),
              ),
            ],
          ],
        ),
        const PostSeparator(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LikeWidget(
              postId: post.id!,
              isLiked: isLiked,
              changeIsLikedValue: () {
                setState(() {
                  isLiked = !isLiked;
                  likes = isLiked ? (likes ?? 0) + 1 : (likes ?? 1) - 1;
                });
              },
            ),
            IconButton(
              onPressed: () {
                GoRouter.of(context).push('/posts/$postId/comments', extra: comments);
              },
              color: context.read<ThemeSettingsCubit>().state.isDarkMode
                  ? darkColorScheme.primary
                  : lightColorScheme.primary,
              icon: const Icon(Icons.comment),
            ),
            IconButton(
              onPressed: () {
                debugPrint('Click pour partager la publication');
                // TODO : Partager la publication
              },
              color: context.read<ThemeSettingsCubit>().state.isDarkMode
                  ? darkColorScheme.primary
                  : lightColorScheme.primary,
              icon: const Icon(Icons.share),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (isChallenge!)
          BlocProvider<ParticipationCubit>(
            create: (_) => ParticipationCubit(),
            child: ParticipationWidget(
              postId: post.id!,
              isAlreadyParticipant: post.userPostParticipation!.any(
                (participation) => participation.participantId! == user!.id!,
              ),
              canEndChallenge: canEndChallenge,
            ),
          ),
      ],
    );
  }
}
