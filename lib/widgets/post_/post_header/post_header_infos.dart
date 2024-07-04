import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/views/users/user_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ecogest_front/widgets/post/post_content_menu.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// PostHeaderInfos is a widget inside PostHeader that 
// groups some information about the post:
// publication date and the author's position or the position picked for the post
// it also contains a menu of actions related to the post (edit, delete and report)

class PostHeaderInfos extends StatelessWidget {
  const PostHeaderInfos({
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
    DateTime dateInFormat = DateTime.parse(date.toString());
    String publicationDate =
        DateFormat('dd/MM/yyyy', 'fr_FR').format(dateInFormat);

    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(publicationDate),
            Text(() {
              if (position != null) {
                return position.toString();
              } else if (author?.position != null) {
                return author?.position.toString() ?? '';
              } else {
                return '';
              }
            }()),
          ],
        ),
        PostContentMenu(author: author, post: post),
      ],
    );
  }
}
