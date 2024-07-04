import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/post_/post_header/post_header_author.dart';
import 'package:ecogest_front/widgets/post_/post_header/post_header_infos.dart';

/// PostHeader groups the information about the post's author, the date,
/// the location, and a menu of actions related to the post
///  into a publication card.

class PostHeader extends StatelessWidget {
  const PostHeader({
    Key? key,
    required this.author,
    this.position,
    this.date,
    required this.post,
  }) : super(key: key);

  final UserModel? author;
  final String? position;
  final String? date;
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PostHeaderAuthor(author: author),
          PostHeaderInfos(author: author, position: position, date: date, post: post),
        ],
      );
  }
}
