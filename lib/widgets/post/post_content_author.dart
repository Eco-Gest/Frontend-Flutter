import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/views/users/user_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ecogest_front/widgets/post/post_content_menu.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostContentAuthor extends StatelessWidget {
  const PostContentAuthor({
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

    final int postId = post.id!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (author?.image != null) ...[
              CircleAvatar(
                backgroundImage: NetworkImage(author!.image.toString()),
              )
            ] else ...[
              const CircleAvatar(
                child: Icon(Icons.person),
              ),
            ],
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  child: Text(
                    author?.username.toString() ?? 'Utilisateur inconnu',
                  ),
                  onPressed: () {
                    if (author?.username != null) {
                      GoRouter.of(context)
                          .pushNamed(UserView.name, pathParameters: {
                        'id': author!.id.toString(),
                      });
                    }
                  },
                ),
                const SizedBox(height: 5),
                FilledButton.tonal(
                  onPressed: () {
                    // TODO : Afficher les différents badges
                  },
                  child: Text(
                    author?.badgeTitle ?? 'Badge',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text(publicationDate),
            if (date != null &&
                (position != null || author?.position != null)) ...[
              const Text(' | '),
            ],
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
