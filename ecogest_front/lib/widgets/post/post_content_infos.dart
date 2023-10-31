import 'package:ecogest_front/models/post_model.dart';
import 'package:flutter/material.dart';

class PostContentInfos extends StatelessWidget {
  const PostContentInfos({
    super.key,
    required this.post,
  });

  final PostModel? post;

  @override
  Widget build(BuildContext context) {
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

    return Column(children: [
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
      const SizedBox(
        height: 10,
      ),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // If the post is an action, we only need the
                      // number of points depending on the difficulty
                      if (post!.type.toString() == 'action') ...[
                        Text(
                          convertLevelToPoint(post!.level.toString()).toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      // If the post is a challenge, we display the number
                      // of points, obtained depending on the duration of
                      // the challenge and its difficulty
                      ] else ...[
                        Text(
                          challengePoint(post!.startDate.toString(), post!.endDate.toString(), post!.level.toString()).toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      ],
                      const Text(' points'),
                    ],
                  ),
                  Row(
                    children: [
                      if (post!.category!.image != null) ...[
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(post!.category!.image.toString()),
                        )
                      ] else ...[
                        const Icon(
                          Icons.category_outlined,
                          size: 15,
                        )
                      ],
                      Text(' ${post!.category!.title.toString()}'),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: () {
                      debugPrint('Click on ${post!.type.toString()}');
                      // TODO : Afficher les défis
                    },
                    child: Text(
                      (() {
                        if (post!.type.toString() == 'action') {
                          return 'Geste';
                        } else {
                          return 'Défi';
                        }
                      }()),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  if (post!.tags != null) ...[
                    Row(
                        children: post!.tags!.map((tag) {
                      return TextButton(
                          onPressed: () {
                            debugPrint('Click on ${tag.label}');
                            // TODO : Afficher la liste des publication avec ce #
                          },
                          child: Text(
                            '#${tag.label}',
                            style: const TextStyle(color: Colors.black),
                          ));
                    }).toList())
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Column(
        children: [
          if (post!.image != null) ...[
            Image(
              image: NetworkImage(post!.image.toString()),
              fit: BoxFit.cover,
            )
          ]
        ],
      ),
      if (post!.image != null && post!.description != null) ...[
        const SizedBox(
          height: 10,
        ),
      ],
      Text(() {
        if (post!.description != null) {
          return post!.description.toString();
        } else {
          return '';
        }
      }())
    ]);
  }
}
