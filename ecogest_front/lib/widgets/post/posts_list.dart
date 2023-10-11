import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/widgets/post/post_content_author.dart';
import 'package:ecogest_front/widgets/post/post_content_buttons.dart';
import 'package:ecogest_front/widgets/post/post_content_infos.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';
import 'package:flutter/material.dart';

class PostsList extends StatelessWidget {
  PostsList({
    required this.posts,
    super.key,
    required this.page,
  });

  static String name = 'posts-list';
  final List<PostModel> posts;
  int? page;

  @override
  Widget build(BuildContext context) {
    // return const Text('Ici la liste des posts');
    debugPrint('Posts list : ${page.toString()}');
    debugPrint(posts.toString());
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Author info
                PostContentAuthor(
                  author: posts[index].user, 
                  position: posts[index].position, 
                  date: posts[index].createdAt
                ),
                const PostSeparator(),
                // Post info
                PostContentInfos(post: posts[index]),
                const PostSeparator(),
                // Buttons
                PostContentButtons(
                  likes: posts[index].likes,
                  comments: posts[index].comments,
                  isChallenge: (posts[index].type.toString() == 'challenge') ? true : false,
                ),
              ],
            ),
          )
        );
      },
    );
  }
}