import 'package:ecogest_front/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';

class PostContentInfos extends StatelessWidget {
  const PostContentInfos({
    Key? key,
    required this.post,
  }) : super(key: key);

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post!.image != null) ...[
          Image(
            image: NetworkImage(post!.image.toString()),
            fit: BoxFit.cover,
          )
        ],
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Si le post est une action, nous avons seulement besoin du
                // nombre de points en fonction de la difficulté
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
                // Si le post est un défi, nous affichons le nombre de points,
                // obtenu en fonction de la durée du défi et de sa difficulté
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
                  const Icon(
                    Icons.category,
                    size: 20,
                  )
                ],
                const SizedBox(width: 5),
                Text(' ${post!.category!.title.toString()}'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FilledButton.tonal(
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
                  ),
                ),
              ],
            ),
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
        const SizedBox(height: 10),
        Text(() {
          if (post!.description != null) {
            return post!.description.toString();
          } else {
            return '';
          }
        }()),
        const SizedBox(height: 10),
        if (post!.tags != null) ...[
          Row(
            children: post!.tags!.map((tag) {
              return TextButton(
                onPressed: () {
                  debugPrint('Click on ${tag.label}');
                  // TODO : Afficher la liste des publications avec ce #
                },
                child: Text(
                  '#${tag.label}',
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
