import 'package:ecogest_front/models/user_post_participation_model.dart';
import 'package:ecogest_front/views/users/user_view.dart';
import 'package:ecogest_front/widgets/post_/post_body/post_body_stats_category_icon.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:go_router/go_router.dart';

// PostBodyStats is a widget inside PostBody that
// displays the stats of the post : points, category and type

class PostBodyStats extends StatelessWidget {
  final PostModel post;

  const PostBodyStats({Key? key, required this.post}) : super(key: key);

  int convertLevelToPoint(String level) {
    if (level == 'easy') return 10;
    if (level == 'medium') return 20;
    if (level == 'hard') return 30;
    return 0;
  }

  int challengeDuration(String from, String to) {
    DateTime start = DateTime.parse(from);
    DateTime end = DateTime.parse(to);
    return (end.difference(start).inHours / 24).round();
  }

  int challengePoint(String startDate, String endDate, String level) {
    int duration = challengeDuration(startDate, endDate);
    int difficulty = convertLevelToPoint(level);
    return (duration * difficulty).round();
  }

  @override
  Widget build(BuildContext context) {
    int points = post.type == 'action'
        ? convertLevelToPoint(post.level.toString())
        : challengePoint(
            post.startDate.toString(), post.endDate.toString(), post.level.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  points.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Text(' points'),
              ],
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (post.category?.image != null)
              CircleAvatar(backgroundImage: NetworkImage(post.category!.image!))
            else
              PostBodyStatsCategoryIcon(catId: post.categoryId),
            const SizedBox(width: 5),
            Text(post.category?.title ?? ''),
          ],
        ),
        if (post.type == 'action')
          FilledButton.tonal(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              debugPrint('Click on ${post.type}');
            },
            child: const Text("Geste"),
          )
        else
          Row(
            children: [
              if (post.userPostParticipation != null &&
                  post.userPostParticipation!.length > 1)
                for (var participation in post.userPostParticipation!.take(4))
                  if (participation.user?.id != post.authorId)
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushNamed(UserView.name, pathParameters: {
                          'id': participation.user!.id.toString(),
                        });
                      },
                      child: participation.user?.image != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(participation.user!.image!),
                            )
                          : const CircleAvatar(child: Icon(Icons.person)),
                    )
              else
                FilledButton.tonal(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    debugPrint('Click on ${post.type}');
                  },
                  child: const Text("Défi"),
                ),
            ],
          ),
      ],
    );
  }
}
