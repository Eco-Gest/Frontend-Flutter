import 'package:ecogest_front/views/account_view.dart';
import 'package:ecogest_front/views/search_view.dart';
import 'package:ecogest_front/views/post_create_view.dart';
import 'package:ecogest_front/views/challenges_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/views/home_view.dart';
import 'package:ecogest_front/views/account_view.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';

class AppBarFooter extends StatelessWidget {
  const AppBarFooter({super.key});

  String _getCurrentRoute(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightColorScheme.surface,
      height: 65.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            color:  ( _getCurrentRoute(context) == "/${HomeView.name}"
                ? lightColorScheme.primary
                : lightColorScheme.onSurfaceVariant),
            tooltip: 'Home',
            onPressed: () {
              GoRouter.of(context).pushNamed(HomeView.name);
            },
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events),
            color: (_getCurrentRoute(context) == "/${ChallengesView.name}"
                ? lightColorScheme.primary
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
              minimumSize: Size.square(60), 
            ),
            child: const Icon(Icons.add),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: (_getCurrentRoute(context) == "/${SearchView.name}"
                ? lightColorScheme.primary
                : lightColorScheme.onSurfaceVariant),
            tooltip: 'Search',
            onPressed: () {
              GoRouter.of(context).pushNamed(SearchView.name);
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            color:  ( _getCurrentRoute(context) == "/${AccountView.name}"
                ? lightColorScheme.primary
                : lightColorScheme.onSurfaceVariant),
            tooltip: 'Your Account',
            onPressed: () {
              GoRouter.of(context).pushNamed(AccountView.name);
            },
          )
        ],
      ),
    );
  }
}
