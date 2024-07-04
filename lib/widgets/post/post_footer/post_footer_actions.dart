import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/widgets/post/post_footer/post_footer_like_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';

// PostFooterActions is a widget that displays the actions
// that can be done on a post : like, comment, share

class PostFooterActions extends StatefulWidget {
  PostFooterActions({
    super.key,
    this.likes,
    required this.isLiked,
    required this.post,
    this.comments,
  });

  final PostModel post;
  int? likes;
  final List? comments;
  bool isLiked;


  @override
  _PostFooterActions createState() => _PostFooterActions();
}

class _PostFooterActions extends State<PostFooterActions> {
  @override
  Widget build(BuildContext context) {
    final PostModel post = widget.post;
    int? likes = widget.likes;
    final List? comments = widget.comments;
    bool isLiked = widget.isLiked;
    int postId = post.id!;

    return Row(
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
        );
  }
}
