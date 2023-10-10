import 'package:flutter/material.dart';

class PostContentButtons extends StatelessWidget {
  const PostContentButtons({
    super.key,
    required this.isChallenge,
    this.likes,
    this.comments,
  });

  final bool? isChallenge;
  final List? likes;
  final List? comments;

  @override
  Widget build(BuildContext context) {
    debugPrint(likes!.length.toString());
    debugPrint(comments.toString());
    return Column(
      children: [
        Row(
          children: [
            if (likes!.isNotEmpty) ...[
              TextButton(
                onPressed: () {
                  // TODO : Afficher les likes
                }, 
                child: Text(
                  '${likes!.length} likes',
                  style: const TextStyle(
                    color: Colors.black
                  ),
                ),
              ),
            ],
            if (likes!.isNotEmpty && comments!.isNotEmpty) ...[
              const Text(' | '),
            ],
            if (comments!.isNotEmpty) ...[
              TextButton(
                onPressed: () {
                  // TODO: Afficher les commentaires
                }, 
                child: Text(
                  '${comments!.length} commentaires',
                  style: const TextStyle(
                    color: Colors.black
                  ),
                )
              ),
            ]
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
              onPressed: () {
                debugPrint('Click pour liker la publication');
                // TODO : Liker la publication
              }, 
              child: const Icon(Icons.thumb_up),
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