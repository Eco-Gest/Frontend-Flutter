import 'package:ecogest_front/models/user_post_participation_model.dart';
import 'package:ecogest_front/views/users/user_view.dart';
import 'package:ecogest_front/widgets/post/category_icon_widget.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:go_router/go_router.dart';

// PostBodyDetails is a widget inside PostBody that
// displays the details of the post : title, description and tags

class PostBodyDetails extends StatelessWidget {
  final PostModel post;

  const PostBodyDetails({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title ?? '',
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (post.description != null) ...[
          const SizedBox(height: 10),
          Text(post.description!),
        ],
        if (post.tags != null) ...[
          const SizedBox(height: 10),
          Row(
            children: post.tags!.map((tag) {
              return TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  debugPrint('Click on ${tag.label}');
                  // TODO: Show the list of posts with this tag
                },
                child: Text(
                  '#${tag.label}',
                  style: TextStyle(
                    color: context.read<ThemeSettingsCubit>().state.isDarkMode
                        ? darkColorScheme.primary
                        : lightColorScheme.primary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
