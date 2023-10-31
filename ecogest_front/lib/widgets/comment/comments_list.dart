import 'package:ecogest_front/models/comment_model.dart';
import 'package:ecogest_front/widgets/comment/comment_element.dart';
import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
    required this.comments,
  });

  static String name = 'comments-list';
  final List<dynamic> comments;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (comments.isNotEmpty) ...[
          // As the comments view is "inside" the home
          // (with a `push` rather than a `go` to reach
          // the view), we cannot use the ListView widget
          // which is already used in the parent.
          // We must loop over the different comments with a `for`.
          for (CommentModel comment in comments) ...[
            CommentElement(
              content: comment.content,
              author: comment.author?.username,
              profilePic: comment.author?.image
            ),
            const SizedBox(
              height: 15,
              width: 15,
            ),
          ],
        ] else ...[
          const Text("Il n'y a pas encore de commentaire pour cette publication")
        ]
      ],
    );
  }
}