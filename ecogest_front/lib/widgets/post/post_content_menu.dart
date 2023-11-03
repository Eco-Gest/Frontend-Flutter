import 'package:ecogest_front/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/views/home_view.dart';


class PostContentMenu extends StatelessWidget {
  const PostContentMenu({
    Key? key,
    required this.author,
    required this.postId,
  }) : super(key: key);

  final UserModel? author;
  final int postId;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationCubit>().state.user;

    return PopupMenuButton<String>(
                    onSelected: (value) async{
                      if (value == 'edit') {
                        if (user != null && user.id == author?.id) {
                          GoRouter.of(context).push('/posts/${postId}/edit');
                        } 
                      } else if (value == 'delete') {
                        context.read<PostsCubit>().deletePost(postId);
                        GoRouter.of(context).goNamed(
                          HomeView.name,
                        );
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
                          try {
                            await launchUrl(emailLaunchUri);
                          } catch(e) {
                              throw Exception("Signalement non éffectué");
                          }


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

                      if (user != null && user.id == author?.id) {
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
                  );          
  }
}