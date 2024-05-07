import 'package:flutter/material.dart';
import 'package:ecogest_front/state_management/user/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserProfileMenu extends StatelessWidget {
  const UserProfileMenu({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final int? userId;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'report') {
          final result = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pourquoi signalez-vous ce profil ?'),
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
                        onTap: () => Navigator.pop(context, 'Atteinte à la vie privé'),
                    ),
                    ListTile(
                        title: Text('Suicide ou conduites autodestructrices'),
                        onTap: () => Navigator.pop(context, 'Suicide ou conduites autodestructrices'),
                    ),
                    ListTile(
                        title: Text('Nudité ou actes sexuels'),
                        onTap: () => Navigator.pop(context, 'Nudité ou actes sexuels'),
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
        return [
          const PopupMenuItem<String>(
            value: 'report',
            child: Text('Signaler'),
          ),
        ];
      },
    );
  }
}
