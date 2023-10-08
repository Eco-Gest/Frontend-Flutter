import 'package:flutter/material.dart';

class PostContentAuthor extends StatelessWidget {
  const PostContentAuthor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('17 août 2023'),
            Text(' | '),
            Text('Rennes, France'),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                const SizedBox(
                  height: 10,
                  width: 10,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        const Text('Maude Erateur'),
                        const SizedBox(
                          height: 10,
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            // TODO : Afficher les différents badges
                          },
                          child: const Text(
                            'Jeune pousse',
                            style: TextStyle(
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
          ] 
        )
      ],
    );
  }
}