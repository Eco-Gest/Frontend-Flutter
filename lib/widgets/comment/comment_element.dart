import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/comment/comment_content_menu.dart';

class CommentElement extends StatelessWidget {
  const CommentElement({
    super.key,
    required this.commentId,
    required this.content,
    required this.author,
    required this.authorId,
    this.profilePic,
  });

  final int? commentId;
  final String? content;
  final String? author;
  final String? profilePic;
  final int? authorId;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Column: Avatar
            Column(
              children: [
                CircleAvatar(
                  backgroundImage: profilePic != null 
                    ? NetworkImage(profilePic!)
                    : null,
                  child: profilePic == null 
                    ? const Icon(Icons.person)
                    : null,
                ),
              ],
            ),
            const SizedBox(width: 10), 
            // Second Column: Author and Content
            Expanded(
              flex: 3, // Takes more space than the other columns
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    author ?? 'Unknown',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(content ?? ''),
                ],
              ),
            ),
            
            // Third Column: Comment Content Menu
            Column(
              children: [
                CommentContentMenu(
                  authorId: authorId,
                  commentId: commentId,
                  content: content,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
