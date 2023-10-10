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

    String tags = post!.tags.toString();
    tags = tags.replaceAll('{', '').replaceAll('}', '');
    List<String> tagsArray = tags.split(',');
    debugPrint(tagsArray.toString());

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
                      if (post!.level.toString() == 'easy') ...[
                        if (post!.type.toString() == 'action') ...[
                          const Text(
                            '10',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ] else ...[
                          // TODO: nombre de point si un challenge
                        ]
                      ] else if (post!.level.toString() == 'medium') ...[
                        if (post!.type.toString() == 'action') ...[
                          const Text(
                            '20',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ] else ...[
                          // TODO: nombre de point si un challenge
                        ]
                      ] else if (post!.level.toString() == 'hard') ...[
                        if (post!.type.toString() == 'action') ...[
                          const Text(
                            '30',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ] else ...[
                          // TODO: nombre de point si un challenge
                        ]
                      ],
                      const Text(' points'),
                    ],
                  ),
                  Row(
                    children: [
                      if (post!.category.image != null) ...[
                        CircleAvatar(
                          backgroundImage: NetworkImage(post!.category.image.toString()),
                        )
                      ] else ...[
                        const Icon(
                          Icons.category_outlined,
                          size: 15,
                        )
                      ],
                      Text(' ${post!.category.title.toString()}'),
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
                    child: Text((() {
                        if (post!.type.toString() == 'action') {
                          return 'Geste';
                        } else {
                          return 'Défi';
                        }
                      } ()),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    children: tagsArray.map((tag) {
                      return TextButton(
                        onPressed: () {
                          debugPrint('Click on $tag');
                          // TODO : Afficher la liste des publication avec ce #
                        },
                        child: Text(
                          '#$tag',
                          style: const TextStyle(color: Colors.black),
                        )
                      );
                    }).toList()
                  )
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
              image: NetworkImage(
                  post!.image.toString()),
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
      } ())
    ]);
  }
}
