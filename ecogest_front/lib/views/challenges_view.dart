import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/views/settings_view.dart';
import 'package:ecogest_front/widgets/challenge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:go_router/go_router.dart';

class ChallengesView extends StatelessWidget {
  const ChallengesView({super.key});

  static String name = 'challenge';

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationCubit>().state.user;
    final String backendRouteChallengeCompleted =
        '/users/${user!.id!}/challenges/completed';
    final String backendRouteChallengeNext =
        '/users/${user.id!}/challenges/next';
    final String backendRouteChallengeInProgress =
        '/users/${user.id!}/challenges/in-progress';
    final String backendRouteActions = '/users/${user.id!}/actions';
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('Mes défis & gestes'),
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text('Défis en cours'),
                    ),
                    Tab(
                      child: Text('Prochains défis'),
                    ),
                    Tab(
                      child: Text('Défis réalisés'),
                    ),
                    Tab(
                      child: Text('Gestes'),
                    ),
                  ])),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                GoRouter.of(context).pushNamed(SettingsView.name);
              },
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            ChallengesWidget(backendRoute: backendRouteChallengeInProgress),
            ChallengesWidget(backendRoute: backendRouteChallengeNext),
            ChallengesWidget(backendRoute: backendRouteChallengeCompleted),
            ChallengesWidget(backendRoute: backendRouteActions),
          ],
        ),
        bottomNavigationBar: const AppBarFooter(),
      ),
    );
  }
}
