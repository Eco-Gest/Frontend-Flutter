import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/widgets/post/post_content_author.dart';
import 'package:ecogest_front/widgets/post/post_content_buttons.dart';
import 'package:ecogest_front/widgets/post/post_content_infos.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';
import 'package:flutter/material.dart';

class PostsList extends StatelessWidget {
  PostsList({
    super.key,
    required this.posts,
    required this.onScrolled,
  });

  static String name = 'posts-list';
  final List<PostModel> posts;

  // Functions which allows to indicate to the
  // parent view that the page has been scrolled
  final Function() onScrolled;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        controller: _scrollController,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          debugPrint('Index : $index');
          debugPrint('Length : ${posts.length}');
          return Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.grey,
                width: 0.5,
              )),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Author info
                    PostContentAuthor(
                        author: posts[index].user,
                        position: posts[index].position,
                        date: posts[index].createdAt),
                    const PostSeparator(),
                    // Post info
                    PostContentInfos(post: posts[index]),
                    const PostSeparator(),
                    // Buttons
                    PostContentButtons(
                      likes: posts[index].likes,
                      comments: posts[index].comments,
                      isChallenge: (posts[index].type.toString() == 'challenge')
                          ? true
                          : false,
                    ),
                  ],
                ),
              ));
        },
      ),
      // Listen to scroll events in the goal to load more posts
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            // Event: user has reached the end of the list
            onScrolled();
          }
        }
        return false;
      },
    );
  }
}
