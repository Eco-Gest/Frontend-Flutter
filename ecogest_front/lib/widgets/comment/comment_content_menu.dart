import 'package:flutter/material.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/comments/comment_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/views/home_view.dart';

class CommentContentMenu extends StatelessWidget {
  const CommentContentMenu({
    Key? key,
    required this.authorId,
    required this.commentId,
    required this.content,
    }) : super(key: key);

    final int? authorId;
    final int? commentId;
    final String? content;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationCubit>().state.user;
    return PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'delete') {
          if (commentId != null && user != null && user.id == authorId) {
           context.read<CommentCubit>().deleteComment(commentId!);
            GoRouter.of(context).goNamed(
               HomeView.name,
            );
            ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Suppression du commentaire réussie.')),
                      );
        }
        } else if (value == 'report') {
          final result = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              // Build and return a dialog similar to the one in PostContentMenu
              return AlertDialog(
                title: Text('Pourquoi signalez-vous ce commentaire ?'),
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

          if (result != null) {
              await context.read<CommentCubit>().submitReport(commentId!, authorId!, content!, result);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Signalement enregistré. Merci !'),
                      ),
              );
          }
        }
      },
      itemBuilder: (BuildContext context) {
        // Build the menu items similar to PostContentMenu
        return [
          const PopupMenuItem<String>(
            value: 'delete',
            child: Text('Supprimer'),
          ),
          const PopupMenuItem<String>(
            value: 'report',
            child: Text('Signaler'),
          ),
        ];
      },
    );
  }
}
