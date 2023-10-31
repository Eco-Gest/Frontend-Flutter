import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/state_management/like/like_cubit.dart';
import 'package:ecogest_front/widgets/post/like_widget.dart';
import 'package:flutter/material.dart';

class PostContentButtons extends StatelessWidget {
  PostContentButtons({
    super.key,
    required this.isChallenge,
    this.likes,
    required this.isLiked,
    required this.post,
    this.comments,
  });

  final PostModel post;
  final bool? isChallenge;
  int? likes;
  final List? comments;
  bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (likes == 1) ...[
              TextButton(
                onPressed: () {
                  // TODO : Afficher les likes
                },
                child: Text(
                  '$likes like',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
            if (likes! > 1) ...[
              TextButton(
                onPressed: () {
                  // TODO : Aff],) icher les likes
                },
                child: Text(
                  '$likes likes',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
            if (likes! > 0 && comments!.isNotEmpty) ...[
              const Text(' | '),
            ],
            if (comments!.isNotEmpty) ...[
              TextButton(
                  onPressed: () {
                    // TODO: Afficher les commentaires
                  },
                  child: Text(
                    '${comments!.length} commentaires',
                    style: const TextStyle(color: Colors.black),
                  )),
            ]
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LikeWidget(postId: post.id!, isLiked: isLiked),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                debugPrint('Click pour commenter la publication');
                // TODO : Commenter la publication
              },
              child: const Icon(Icons.comment),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                debugPrint('Click pour partager la publication');
                // TODO : Partager la publication
              },
              child: const Icon(Icons.share),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (isChallenge!) ...[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(30),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () {
              debugPrint('Click pour rejoindre le défi');
              // TODO : Rejoindre le défi
            },
            child: const Text('Participer au défi'),
          ),
        ]
      ],
    );
  }
}
