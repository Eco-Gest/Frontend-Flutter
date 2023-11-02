import 'package:ecogest_front/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostContentMenu extends StatelessWidget {
  const PostContentMenu({
    super.key,
    required this.author,
    this.postId,
  });

  final UserModel? author;
  final int? postId;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationCubit>().state.user;

    return PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        if (user != null && user.id == author?.id) {
                          GoRouter.of(context).push('/posts/${postId}/edit');
                        } 
                      } else if (value == 'delete') {
                        // Action pour la suppression du post
                        // Ajoutez votre logique de suppression ici
                      } else if (value == 'report') {
                        // Action pour signaler le post
                        // Ajoutez votre logique de signalement ici
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