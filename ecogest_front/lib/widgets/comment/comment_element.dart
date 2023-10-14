import 'package:ecogest_front/models/comment_model.dart';
import 'package:ecogest_front/widgets/post/post_content_buttons.dart';
import 'package:flutter/material.dart';

class CommentElement extends StatelessWidget {
  const CommentElement({
    super.key,
    required this.content,
    required this.author,
    this.image,
  });

  final String? content;
  final String? author;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey,
            width: 0.5,
          )),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (image != null) ...[
                      CircleAvatar(
                        backgroundImage: NetworkImage(image.toString()),
                      )
                    ] else ...[
                      const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ],
                  ],
                ),
                const SizedBox(
                  height: 15,
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Author of the comment
                    Text(
                      author.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    // Content of the comment
                    Text(
                      content!,
                    ),
                  ]
                )
              ],
            )        
          )
    );
  }
}