import 'package:ecogest_front/widgets/post_content_author.dart';
import 'package:ecogest_front/widgets/post_content_buttons.dart';
import 'package:ecogest_front/widgets/post_content_infos.dart';
import 'package:ecogest_front/widgets/post_separator.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({
    // required this.postId,
    super.key
  });

  static String name = 'post';
  // final int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBarFooter(),
      body: const Center(
        child: Column(
          children: [
            // Author info
            PostContentAuthor(),
            PostSeparator(),
            // Post info
            PostContentInfos(),
            PostSeparator(),
            // Buttons
            PostContentButtons(),
          ]
        ),
      ),
    );
  }
}