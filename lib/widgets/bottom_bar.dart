import 'package:ecogest_front/views/users/account_view.dart';
import 'package:ecogest_front/views/search_view.dart';
import 'package:ecogest_front/views/posts/post_create_view.dart';
import 'package:ecogest_front/views/posts/challenges_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/views/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';

class AppBarFooter extends StatelessWidget {
  const AppBarFooter({Key? key});

  String _getCurrentRoute(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
      builder: (context, state) {
        final bool isDarkMode = state.isDarkMode;
        return Container(
          color: isDarkMode ? darkColorScheme.surface : lightColorScheme.surface,
          height: 65.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                color: (_getCurrentRoute(context) == "/${HomeView.name}"
                    ? isDarkMode
                        ? darkColorScheme.primary
                        : lightColorScheme.primary
                    : isDarkMode
                        ? darkColorScheme.onSurfaceVariant
                        : lightColorScheme.onSurfaceVariant),
                tooltip: 'Home',
                onPressed: () {
                  GoRouter.of(context).pushNamed(HomeView.name);
                },
              ),
              IconButton(
                icon: const Icon(Icons.emoji_events),
                color: (_getCurrentRoute(context) == "/${ChallengesView.name}"
                    ? isDarkMode
                        ? darkColorScheme.primary
                        : lightColorScheme.primary
                    : isDarkMode
                        ? darkColorScheme.onSurfaceVariant
                        : lightColorScheme.onSurfaceVariant),
                tooltip: 'Challenge & action',
                onPressed: () {
                  GoRouter.of(context).pushNamed(ChallengesView.name);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(PostCreateView.name);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  minimumSize: const Size.square(60),
                ),
                child: const Icon(Icons.add),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                color: (_getCurrentRoute(context) == "/${SearchView.name}"
                    ? isDarkMode
                        ? darkColorScheme.primary
                        : lightColorScheme.primary
                    : isDarkMode
                        ? darkColorScheme.onSurfaceVariant
                        : lightColorScheme.onSurfaceVariant),
                tooltip: 'Search',
                onPressed: () {
                  GoRouter.of(context).pushNamed(SearchView.name);
                },
              ),
              IconButton(
                icon: const Icon(Icons.person),
                color: (_getCurrentRoute(context) == "/${AccountView.name}"
                    ? isDarkMode
                        ? darkColorScheme.primary
                        : lightColorScheme.primary
                    : isDarkMode
                        ? darkColorScheme.onSurfaceVariant
                        : lightColorScheme.onSurfaceVariant),
                tooltip: 'Your Account',
                onPressed: () {
                  GoRouter.of(context).pushNamed(AccountView.name);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
