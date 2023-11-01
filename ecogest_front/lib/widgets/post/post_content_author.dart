import 'package:flutter/material.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/posts/posts_cubit.dart';

class PostContentAuthor extends StatelessWidget {
  const PostContentAuthor({
    Key? key,
    required this.author,
    this.position,
    this.date,
    this.postId,
  }) : super(key: key);

  final UserModel? author;
  final String? position;
  final String? date;
  final int? postId;

  @override
  Widget build(BuildContext context) {
    final authenticationState = context.read<AuthenticationCubit>().state;

    // Transform date from DB to french date format
    DateTime dateInFormat = DateTime.parse(date.toString());
    String publicationDate = DateFormat('dd/MM/yyyy', 'fr_FR').format(dateInFormat);

    final int postId = this.postId ?? 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(publicationDate),
            if (date != null && (position != null || author!.position != null)) ...[
              const Text(' | '),
            ],
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  if (authenticationState is AuthenticationAuthenticated &&
                      authenticationState.user?.id == author?.id) {
                    // Action pour l'édition du post
                  } else {
                    // L'utilisateur actuel n'est pas l'auteur
                    // Ajoutez ici la logique pour informer l'utilisateur qu'il ne peut pas éditer ce post.
                  }
                } else if (value == 'delete') {
                  context.read<PostsCubit>().deletePost(postId);
                  Navigator.pop(context);
                } else if (value == 'report') {
                  // Action pour signaler le post
                  // Ajoutez votre logique de signalement ici
                }
              },
              itemBuilder: (BuildContext context) {
                List<PopupMenuEntry<String>> items = [];

                if (authenticationState is AuthenticationAuthenticated &&
                    authenticationState.user?.id == author?.id) {
                  items.add(const PopupMenuItem<String>(
                    value: 'edit',
                    child: Text('Éditer'),
                  ));
                  items.add(const PopupMenuItem<String>(
                    value: 'delete',
                    child: Text('Supprimer'),
                  ));
                }

                items.add(const PopupMenuItem<String>(
                  value: 'report',
                  child: Text('Signaler'),
                ));

                return items;
              },
            ),
            Text(
              () {
                if (position != null) {
                  return position.toString();
                } else if (author!.position != null) {
                  return author!.position.toString();
                } else {
                  return '';
                }
              }(),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                if (author!.image != null) ...[
                  CircleAvatar(
                    backgroundImage: NetworkImage(author!.image.toString()),
                  )
                ] else ...[
                  const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ],
                const SizedBox(
                  height: 10,
                  width: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(author?.username.toString() ?? 'Username'),
                        const SizedBox(
                          height: 10,
                        ),
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
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
