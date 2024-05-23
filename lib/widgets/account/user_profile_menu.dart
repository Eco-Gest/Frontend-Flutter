import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/users_relation/users_relation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/state_management/user/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileMenu extends StatelessWidget {
  const UserProfileMenu({
    Key? key,
    required this.userId,
    required this.username,
    required this.isBlocked,
  }) : super(key: key);

  final int? userId;
  final String username;
  final bool isBlocked;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'report') {
          final result = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Pourquoi signalez-vous ce profil ?'),
                content: Column(
                  children: [
                    ListTile(
                      title: const Text('Contenu inapproprié et harcèlement'),
                      onTap: () =>
                          Navigator.pop(context, 'Contenu inapproprié'),
                    ),
                    ListTile(
                      title: const Text('Discours de haine'),
                      onTap: () => Navigator.pop(context, 'Discours de haine'),
                    ),
                    ListTile(
                      title: const Text('Atteinte à la vie privé'),
                      onTap: () =>
                          Navigator.pop(context, 'Atteinte à la vie privé'),
                    ),
                    ListTile(
                      title: const Text('Suicide ou conduites autodestructrices'),
                      onTap: () => Navigator.pop(
                          context, 'Suicide ou conduites autodestructrices'),
                    ),
                    ListTile(
                      title: const Text('Nudité ou actes sexuels'),
                      onTap: () =>
                          Navigator.pop(context, 'Nudité ou actes sexuels'),
                    ),
                    ListTile(
                      title: const Text('Spam'),
                      onTap: () => Navigator.pop(context, 'Spam'),
                    ),
                    ListTile(
                      title: const Text('Autre'),
                      onTap: () => Navigator.pop(context, 'Autre'),
                    ),
                  ],
                ),
              );
            },
          );

          if (result != null) {
            await context.read<UserCubit>().submitReport(userId!, result);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Signalement enregistré. Merci !'),
              ),
            );
          }
        }
      },
      itemBuilder: (BuildContext context) {
        final items = List<PopupMenuItem<String>>.empty(growable: true);
        if (context.read<AuthenticationCubit>().state.user?.followers?.any(
                (s) => s!.followerId == userId && s.status == "approved") ==
            true) {
          final removeFollower = PopupMenuItem<String>(
            child: const Text('Retirer de mes abonnements'),
            onTap: () => {
              context.read<UsersRelationCubit>().removeFollower(userId!),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$username a été retiré de vos abonnements'),
                ),
              ),
            },
          );
          items.add(removeFollower);
        }
        if (context.read<AuthenticationCubit>().state.user?.following?.any(
                (s) => s!.followingId == userId && s.status == "blocked") ==
            false && isBlocked == false) {
          final blockUser = PopupMenuItem<String>(
            child: const Text('Bloquer'),
            onTap: () => {
              context.read<UsersRelationCubit>().blockUser(userId!),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Vous avez bloqué $username'),
                ),
              ),
            },
          );
          items.add(blockUser);
        }
        const report = PopupMenuItem<String>(
          value: 'report',
          child: Text('Signaler'),
        );

        items.addAll([report]);
        return items;
      },
    );
  }
}
