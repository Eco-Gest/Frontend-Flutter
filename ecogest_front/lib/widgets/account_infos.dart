import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationState = context.read<AuthenticationCubit>().state;
    if (authenticationState is AuthenticationAuthenticated) {
      final user = authenticationState.user;

      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... First Bloc: Profil Picture, Username, Location, Badge ...
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // image: DecorationImage(
                      //   image: user?.image != null
                      //             ? NetworkImage(user!.image!)
                      //             : const AssetImage('assets/profile.jpg'),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.username ?? 'Username',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user?.position ?? 'Le Monde',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 12.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: EcogestTheme.primary,
                        ),
                        child: Text(
                          user?.badgeTitle ?? 'Badge',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // ... Second Bloc: Profil Bio ...
              Text(
                user?.biography ?? 'Default Biography',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    } else {
      // Handle the case where the state is not AuthenticationAuthenticated
      return const Scaffold(
        body: Center(
          child: Text('User not authenticated'),
        ),
      );
    }
  }
}
