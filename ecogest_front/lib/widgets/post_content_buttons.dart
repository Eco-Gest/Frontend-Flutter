import 'package:flutter/material.dart';

class PostContentButtons extends StatelessWidget {
  const PostContentButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                // TODO : Afficher les likes
              }, 
              child: const Text(
                '7 likes',
                style: TextStyle(
                  color: Colors.black
                ),
              )
            ),
            const Text(' | '),
            TextButton(
              onPressed: () {
                // TODO: Afficher les commentaires
              }, 
              child: const Text(
                '4 commentaires',
                style: TextStyle(
                  color: Colors.black
                ),
              )
            ),
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
                foregroundColor: Colors.white, // Color of button text
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
              onPressed: () {
                // TODO : Liker la publication
              }, 
              child: const Icon(Icons.thumb_up),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white, // Color of button text
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
              onPressed: () {
                // TODO : Commenter la publication
              }, 
              child: const Icon(Icons.comment),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white, // Color of button text
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
              onPressed: () {
                // TODO : Partager la publication
              }, 
              child: const Icon(Icons.share),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(30),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(20),
            foregroundColor: Colors.white, // Color of button text
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        onPressed: () {
          // TODO : Rejoindre le défi
        },
        child: const Text('Participer au défi'),
      ),
      ],
    );

  }
}