import 'package:ecogest_front/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({Key? key, this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
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
                    image: user?.image != null
                        ? NetworkImage(user!.image!) as ImageProvider<Object>
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
                      color: EcogestTheme.primary,
                    ),
                    child: Text(
                      user?.badgeTitle ?? 'Badge',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          // ... Second Bloc: Profil Bio ...
          Text(
            user?.biography ?? 'Default Biography',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
