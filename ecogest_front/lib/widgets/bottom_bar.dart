import 'package:ecogest_front/views/account_view.dart';
import 'package:ecogest_front/views/search_view.dart';
import 'package:ecogest_front/views/post_create_view.dart';
import 'package:ecogest_front/views/challenges_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/views/home_view.dart';
import 'package:ecogest_front/views/account_view.dart';

class AppBarFooter extends StatelessWidget {
  const AppBarFooter({super.key});

  String _getCurrentRoute(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.blueGrey.shade100,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            color:  ( _getCurrentRoute(context) == "/${HomeView.name}"
                ? EcogestTheme.primary
                : Colors.blueGrey.shade400),
            tooltip: 'Home',
            onPressed: () {
              GoRouter.of(context).pushNamed(HomeView.name);
            },
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events),
            color: (_getCurrentRoute(context) == "/${ChallengesView.name}"
                ? EcogestTheme.primary
                : Colors.blueGrey.shade400),
            tooltip: 'Challenge & action',
            onPressed: () {
              GoRouter.of(context).pushNamed(ChallengesView.name);
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle),
            color:  ( _getCurrentRoute(context) == "/${PostCreateView.name}"
                ? EcogestTheme.primary
                : Colors.blueGrey.shade400),
            tooltip: 'Add challenge or action',
            onPressed: () {
              GoRouter.of(context).pushNamed(PostCreateView.name);
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: (_getCurrentRoute(context) == "/${SearchView.name}"
                ? EcogestTheme.primary
                : Colors.blueGrey.shade400),
            tooltip: 'Home',
            onPressed: () {
              GoRouter.of(context).pushNamed(SearchView.name);
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            color:  ( _getCurrentRoute(context) == "/${AccountView.name}"
                ? EcogestTheme.primary
                : Colors.blueGrey.shade400),
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
