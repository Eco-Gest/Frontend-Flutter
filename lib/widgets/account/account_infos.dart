import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/subscription/subscription_cubit.dart';
import 'package:ecogest_front/views/users/subscriptions_list_view.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/widgets/account/user_profile_menu.dart';
import 'package:go_router/go_router.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final authenticationState = context.read<AuthenticationCubit>().state;
    final userAuthenticated = authenticationState.user;

    return MultiBlocProvider(
      providers: [
        BlocProvider<SubscriptionCubit>(
          create: (_) => SubscriptionCubit(),
        ),
      ],
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // ... First Bloc: Profil Picture, Username, Location, Badge ...
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: user.image != null
                          ? NetworkImage(user.image!) as ImageProvider<Object>
                          : const AssetImage('assets/profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username ?? 'Username',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      user.position ?? 'Le Monde',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 6,
                      width: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 12.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            context.read<ThemeSettingsCubit>().state.isDarkMode
                                ? darkColorScheme.secondaryContainer
                                : lightColorScheme.secondaryContainer,
                      ),
                      child: Text(
                        user.badgeTitle ?? 'Badge',
                        style: TextStyle(
                          fontSize: 14,
                          color: lightColorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
                if (userAuthenticated != null &&
                    userAuthenticated.id != user.id)
                  UserProfileMenu(userId: user.id!),
              ],
            ),
            const SizedBox(height: 16),
            // Second Bloc: Followings, Followers, Challenges Completed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'Points',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      user.totalPoints?.toString() ?? '0',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  width: 1.0, // Width of the border
                  height: 60.0, // Height of the border, adjust as needed
                  color: lightColorScheme.outline, // Border color
                ),
                GestureDetector(
                  onTap: () {
                    if (user.followers!.isNotEmpty ||
                        user.following!.isNotEmpty) {
                      GoRouter.of(context)
                          .pushNamed(SubscriptionsListView.name, extra: user);
                    }
                  },
                  child: Column(
                    children: [
                      const Text(
                        'Abonnés',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        user.followers!
                                .where((f) => f?.status == "approved")
                                .toList()
                                .length
                                .toString() ??
                            '0',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1.0, // Width of the border
                  height: 60.0, // Height of the border, adjust as needed
                  color: lightColorScheme.outline, // Border color
                ),
                GestureDetector(
                  onTap: () {
                    if (user.followers!.isNotEmpty ||
                        user.following!.isNotEmpty) {
                      GoRouter.of(context)
                          .pushNamed(SubscriptionsListView.name, extra: user);
                    }
                  },
                  child: Column(
                    children: [
                      const Text(
                        'Abonnements',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        user.following!
                                .where((f) => f?.status == "approved")
                                .toList()
                                .length
                                .toString() ??
                            '0',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // ... Third Bloc: Profil Bio ...
            Text(
              user.biography ?? 'Default Biography',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
