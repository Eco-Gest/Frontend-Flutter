import 'package:flutter/material.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:url_launcher/url_launcher.dart';


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
              onSelected: (value) async {
                if (value == 'edit') {
                  // Handle edit logic
                } else if (value == 'delete') {
                  context.read<PostsCubit>().deletePost(postId);
                  Navigator.pop(context);
                                } else if (value == 'report') {
                  final result = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Pourquoi signalez-vous cette publication ?'),
                        content: Column(
                          children: [
                            ListTile(
                              title: Text('Contenu inapproprié et harcèlement'),
                              onTap: () => Navigator.pop(context, 'Contenu inapproprié'),
                            ),
                            ListTile(
                              title: Text('Discours de haine'),
                              onTap: () => Navigator.pop(context, 'Discours de haine'),
                            ),
                            ListTile(
                              title: Text('Atteinte à la vie privé'),
                              onTap: () => Navigator.pop(context, 'Discours de haine'),
                            ),
                            ListTile(
                              title: Text('Suicide ou conduites autodestructrices'),
                              onTap: () => Navigator.pop(context, 'Discours de haine'),
                            ),
                            ListTile(
                              title: Text('Nudité ou actes sexuels'),
                              onTap: () => Navigator.pop(context, 'Discours de haine'),
                            ),
                            ListTile(
                              title: Text('Spam'),
                              onTap: () => Navigator.pop(context, 'Spam'),
                            ),
                            ListTile(
                              title: Text('Autre'),
                              onTap: () => Navigator.pop(context, 'Autre'),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  // Check if a reporting option was selected
                  if (result != null) {
                    // Launch email application
                    final String subject = 'Signalement de post - ID: $postId, Titre: ${author?.username ?? ''}';
                    final String body = 'Raison du signalement: $result';
                    final String email = 'report@ecogest.io';
                    
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: email,
                      queryParameters: {
                        // temporary fix for + replacing spaces
                        'subject': subject.replaceAll(' ', '_'),
                        'body': body.replaceAll(' ', '_'),
                      },
                    );

                   launchUrl(emailLaunchUri);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Signalement de type "$result" enregistré. Merci !'),
                      ),
                    );
                  }
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
