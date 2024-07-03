import 'package:ecogest_front/models/post_model.dart';
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
    required this.post,
  }) : super(key: key);

  final UserModel? author;
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationCubit>().state.user;

    return PopupMenuButton<String>(
      style: TextButton.styleFrom(
                      minimumSize: Size.zero, // Set this
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 2.0), // and this
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
      onSelected: (value) async {
        if (value == 'edit') {
          if (user != null && user.id == author?.id) {
            GoRouter.of(context).push('/posts/${post.id}/edit');
          }
        } else if (value == 'delete') {
          context.read<PostsCubit>().deletePost(post.id!);
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
                      onTap: () =>
                          Navigator.pop(context, 'Contenu inapproprié'),
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
                      onTap: () => Navigator.pop(
                          context, 'Suicide ou conduites autodestructrices'),
                    ),
                    ListTile(
                      title: Text('Nudité ou actes sexuels'),
                      onTap: () =>
                          Navigator.pop(context, 'Nudité ou actes sexuels'),
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
            await context.read<PostsCubit>().submitReport(post.id!, result);
            await context.read<PostsCubit>().getPosts(1, false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Signalement enregistré. Merci !'),
              ),
            );
          }
        }
      },
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<String>> items = [];

        if (user != null && user.id == author?.id) {
          if (post.userPostParticipation!.length <= 1) {
            items.add(const PopupMenuItem<String>(
              value: 'edit',
              child: Text('Éditer'),
            ));
          }
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
