import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/views/user_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PostContentAuthor extends StatelessWidget {
  const PostContentAuthor({
    super.key,
    required this.author,
    this.position,
    this.date,
  });

  final UserModel? author;
  final String? position;
  final String? date;

  @override
  Widget build(BuildContext context) {
    // Transform date from DB to french date format
    DateTime dateInFormat = DateTime.parse(date.toString());
    String publicationDate =
        DateFormat('dd/MM/yyyy', 'fr_FR').format(dateInFormat);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(publicationDate),
            if (date != null &&
                (position != null || author!.position != null)) ...[
              const Text(' | '),
            ],
            Text(() {
              if (position != null) {
                return position.toString();
              } else if (author!.position != null) {
                return author!.position.toString();
              } else {
                return '';
              }
            }()
                // 'Rennes, France'
                ),
          ],
        ),
        Column(children: [
          Row(
            children: [
              if (author!.image != null) ...[
                CircleAvatar(
                  backgroundImage: NetworkImage(author!.image.toString()),
                )
              ] else ...[
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ],
              const SizedBox(
                height: 10,
                width: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        child: Text(author?.username.toString() ?? 'Username'),
                        onPressed: () {
                          GoRouter.of(context)
                              .pushNamed(UserView.name, pathParameters: {
                            'id': author!.id.toString(),
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FilledButton.tonal(
                        onPressed: () {
                          // TODO : Afficher les différents badges
                        },
                        child: Text(
                          author?.badgeTitle ?? 'Badge',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ])
      ],
    );
  }
}
