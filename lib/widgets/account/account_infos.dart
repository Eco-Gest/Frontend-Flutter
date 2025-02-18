import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/user/user_cubit.dart';
import 'package:ecogest_front/state_management/users_relation/users_relation_cubit.dart';
import 'package:ecogest_front/views/users/subscriptions_list_view.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/widgets/account/user_profile_menu.dart';
import 'package:go_router/go_router.dart';

class AccountInfo extends StatefulWidget {
  AccountInfo({super.key, required this.user, required this.isBlocked});

  final UserModel user;
  final bool isBlocked;

  static String name = 'account';

  @override
  _AccountInfo createState() => _AccountInfo();
}

class _AccountInfo extends State<AccountInfo>
    with SingleTickerProviderStateMixin {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    setState(() {
      context.read<UserCubit>().getUser(widget.user.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = widget.user;
    final bool isBlocked = widget.isBlocked;

    final authenticationState = context.read<AuthenticationCubit>().state;
    final userAuthenticated = authenticationState.user;

    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: refreshData,
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
                  width: 86,
                  height: 86,
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
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username ?? 'Username',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.position ?? 'Le Monde',
                    ),
                    const SizedBox(
                      height: 2,
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
                          fontSize: 12,
                          color: context.read<ThemeSettingsCubit>().state.isDarkMode
                                ? darkColorScheme.onSecondaryContainer
                                : lightColorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
                if (userAuthenticated != null &&
                    userAuthenticated.id != user.id)
                  UserProfileMenu(
                    username: user.username ?? "Utilisateur",
                    isBlocked: isBlocked,
                    user: user
                  ),
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
              user.biography ?? '',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
