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

class PostContentInfos extends StatelessWidget {
  const PostContentInfos({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel? post;

  @override
  Widget build(BuildContext context) {
    post?.userPostParticipation?.sort((a, b) {
      if (a.createdAt != null && b.createdAt != null) {
        return a.updatedAt!.compareTo(b.updatedAt!);
      }
      return 0;
    });
    // Return the number of points earned
    // based on the difficulty of the action
    int convertLevelToPoint(String level) {
      int pointsByLevel = 0;
      if (level == 'easy') {
        pointsByLevel = 10;
      } else if (level == 'medium') {
        pointsByLevel = 20;
      } else if (level == 'hard') {
        pointsByLevel = 30;
      }
      return pointsByLevel;
    }

    // Calculate the duration between two dates
    int challengeDuration(String from, String to) {
      DateTime start = DateTime.parse(from);
      DateTime end = DateTime.parse(to);
      return (end.difference(start).inHours / 24).round();
    }

    // Calculate the number of points earned for a challenge
    // based on its difficulty and its duration
    int challengePoint(String startDate, String endDate, String level) {
      int duration = challengeDuration(startDate, endDate);
      int difficulty = convertLevelToPoint(level);
      return (duration * difficulty).round();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post!.image != null) ...[
          Image(
            image: NetworkImage(post!.image.toString()),
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // If the post is an action, we only need the
                // number of points depending on the difficulty
                if (post!.type.toString() == 'action') ...[
                  Row(
                    children: [
                      Text(
                        convertLevelToPoint(post!.level.toString()).toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Text(' points'),
                    ],
                  ),
                ]
                // If the post is a challenge, we display the number
                // of points, obtained depending on the duration of
                // the challenge and its difficulty
                else ...[
                  Row(
                    children: [
                      Text(
                        challengePoint(
                                post!.startDate.toString(),
                                post!.endDate.toString(),
                                post!.level.toString())
                            .toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Text(' points'),
                    ],
                  ),
                ],
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (post!.category!.image != null) ...[
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(post!.category!.image.toString()),
                  )
                ] else ...[
                  CategoryIconWidget(catId: post!.categoryId),
                ],
                const SizedBox(width: 5),
                Text(' ${post!.category!.title.toString()}'),
              ],
            ),
            if (post!.type.toString() == 'action') ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FilledButton.tonal(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero, // Set this
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0), // and this
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      debugPrint('Click on ${post!.type.toString()}');
                      // TODO : Afficher les défis
                    },
                    child: const Text("Geste"),
                  ),
                ],
              ),
            ] else ...[
              Row(
                children: [
                  if (post?.userPostParticipation != null &&
                      post!.userPostParticipation!.length > 1) ...[
                    for (UserPostParticipationModel userPostParticipation
                        in post!.userPostParticipation!.take(4)) ...[
                      if (userPostParticipation.user?.id != post?.authorId) ...[
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(UserView.name, pathParameters: {
                              'id': userPostParticipation.user!.id!.toString(),
                            });
                          },
                          child: userPostParticipation.user?.image != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      userPostParticipation.user!.image
                                          .toString()),
                                )
                              : const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                        ),
                      ],
                    ],
                  ] else ...[
                    FilledButton.tonal(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero, // Set this
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0), // and this
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        debugPrint('Click on ${post!.type.toString()}');
                      },
                      child: const Text("Défi"),
                    ),
                  ]
                ],
              )
            ],
          ],
        ),
        const PostSeparator(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post!.title.toString(),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (post!.description != null) ...[
          const SizedBox(height: 10),
          Text(post!.description.toString()),
        ],
        if (post!.tags != null) ...[
          const SizedBox(height: 10),
          Row(
            children: post!.tags!.map((tag) {
              return TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero, // Set this
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0), // and this
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  debugPrint('Click on ${tag.label}');
                  // TODO : Afficher la liste des publications avec ce #
                },
                child: Text(
                  '#${tag.label}',
                  style: TextStyle(
                      color: context.read<ThemeSettingsCubit>().state.isDarkMode
                          ? darkColorScheme.primary
                          : lightColorScheme.primary),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
