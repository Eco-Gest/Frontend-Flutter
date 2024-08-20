import 'package:flutter/material.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/models/post_model.dart';

// PostFooterInfos is a widget that displays the number of likes and comments

class PostFooterInfos extends StatelessWidget {
  PostFooterInfos({
    Key? key,
    required this.likes,
    required this.comments,
    required this.postId,
  }) : super(key: key);

  final int? likes;
  final List? comments;
  final int? postId;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeSettingsCubit>().state.isDarkMode;

    return Row(
      children: [
        if (likes != null && likes! > 0) ...[
          TextButton(
            onPressed: () {
              // TODO: Implement action for displaying likes
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              '$likes ${likes == 1 ? 'like' : 'likes'}',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          if (comments != null && comments!.isNotEmpty) const Text(' | '),
        ],
        if (comments != null && comments!.isNotEmpty) ...[
          TextButton(
            onPressed: () {
              GoRouter.of(context).push('/posts/$postId/comments', extra: comments);
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              '${comments!.length} ${comments!.length == 1 ? 'commentaire' : 'commentaires'}',
              style: TextStyle(
                color: isDarkMode ? darkColorScheme.onBackground : lightColorScheme.onBackground,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
