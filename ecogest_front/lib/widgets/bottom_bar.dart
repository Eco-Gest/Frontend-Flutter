
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/views/home_view.dart';



class AppBarFooter extends StatelessWidget {
  AppBarFooter({super.key});

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
            color:  ( _getCurrentRoute(context) == "/" + HomeView.name
                ? EcogestTheme.primary
                : Colors.blueGrey.shade400),
            tooltip: 'Home',
            onPressed: () {
              GoRouter.of(context).goNamed(HomeView.name);
            },
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events),
            color: Colors.blueGrey.shade400,
            tooltip: 'Challenge',
            onPressed: () {
              debugPrint('défi');
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle),
            color: Colors.blueGrey.shade400,
            tooltip: 'Add challenge or action',
            onPressed: () {
              debugPrint('add');
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.blueGrey.shade400,
            tooltip: 'Search',
            onPressed: () {
              debugPrint('search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            color: Colors.blueGrey.shade400,
            tooltip: 'Your profile',
            onPressed: () {
              debugPrint('profile');
            },
          )
        ],
      ),
    );
  }
}
