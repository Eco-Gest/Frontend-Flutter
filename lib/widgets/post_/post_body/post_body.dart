import 'package:ecogest_front/models/user_post_participation_model.dart';
import 'package:ecogest_front/views/users/user_view.dart';
import 'package:ecogest_front/widgets/post_/post_body/post_body_details.dart';
import 'package:ecogest_front/widgets/post_/post_body/post_body_image.dart';
import 'package:ecogest_front/widgets/post_/post_body/post_body_stats.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:go_router/go_router.dart';

// PostBody is a widget that displays the body of a post
// It contains wdgets for
// the image, the stats and the details of the post

class PostBody extends StatelessWidget {
  const PostBody({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PostSeparator(),
        if (post.image != null) ...[
          PostBodyImage(imageUrl: post.image),
          const SizedBox(height: 8),
        ],
        PostBodyStats(post: post),
        const PostSeparator(),
        PostBodyDetails(post: post),
      ],
    );
  }
}
