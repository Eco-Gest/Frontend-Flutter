import 'package:ecogest_front/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/widgets/account/user_profile_menu.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({Key? key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final authenticationState = context.read<AuthenticationCubit>().state;
    final userAuthenticated = authenticationState.user;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          // ... First Bloc: Profil Picture, Username, Location, Badge ...
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: user.image != null
                        ? NetworkImage(user.image!) as ImageProvider<Object>
                        : AssetImage('assets/profile.jpg')
                            as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.username ?? 'Username',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user?.position ?? 'Le Monde',
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: context.read<ThemeSettingsCubit>().state.isDarkMode
                          ? darkColorScheme.secondaryContainer
                          : lightColorScheme.secondaryContainer,
                    ),
                    child: Text(
                      user?.badgeTitle ?? 'Badge',
                      style: TextStyle(
                        fontSize: 14,
                        color: lightColorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
          if (userAuthenticated != null && userAuthenticated.id != user.id)
                UserProfileMenu(userId: user.id!),
            ],
          ),
          SizedBox(height: 16),
          // Second Bloc: Followings, Followers, Challenges Completed
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Points',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    user?.totalPoints.toString() ?? '0',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                width: 1.0, // Width of the border
                height: 60.0, // Height of the border, adjust as needed
                color: lightColorScheme.outline, // Border color
              ),
              Column(
                children: [
                  Text(
                    'Défis',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    user?.postParticipationCount ?? '0',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          // ... Third Bloc: Profil Bio ...
          Text(
            user?.biography ?? 'Default Biography',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
