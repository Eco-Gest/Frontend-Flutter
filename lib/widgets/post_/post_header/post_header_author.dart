import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/views/users/user_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ecogest_front/widgets/post/post_content_menu.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// PostHeaderAuthor is a widget inside PostHeader that
/// groups the information about the post's author
/// it contains the author's image, username, and badge

class PostHeaderAuthor extends StatelessWidget {
  const PostHeaderAuthor({
    Key? key,
    required this.author,
  }) : super(key: key);

  final UserModel? author;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (author?.image != null) ...[
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(author!.image.toString()),
            ),
          ),
        ] else ...[
          const Padding(
            padding: EdgeInsets.only(right: 6.0),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ],
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                if (author?.username != null) {
                  GoRouter.of(context).pushNamed(UserView.name, pathParameters: {
                    'id': author!.id.toString(),
                  });
                }
              },
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.only(bottom: 2.0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                author?.username.toString() ?? 'Utilisateur inconnu',
              ),
            ),
            FilledButton.tonal(
              onPressed: () {
                // TODO : Afficher les différents badges
              },
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                    vertical: 4.0, horizontal: 8.0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                author?.badgeTitle ?? 'Badge',
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
