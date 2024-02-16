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
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey,
            width: 0.5,
          )),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Wrap(
                    children: [
                      // Author infos
                      Row(
                        children: [
                          // Comment author profil picture
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (profilePic != null) ...[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(profilePic.toString()),
                                )
                              ] else ...[
                                const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // Comment author username
                          Column(
                            children: [
                              Text(
                                author.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                        width: 15,
                      ),
                      // Content of the comment
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            content!,
                          ),
                        ]
                      )
                    ],
                  )        
                ),
              CommentContentMenu(authorId: authorId,commentId: commentId, content: content),
              ],
            )
            
          )
    );
  }
}