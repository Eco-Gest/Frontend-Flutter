import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/views/settings_view.dart';
import 'package:ecogest_front/widgets/challenge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';

class ChallengesView extends StatelessWidget {
  const ChallengesView({super.key});

  static String name = 'challenge';

  @override
  Widget build(BuildContext context) {
    const String keywordRouteChallengeCompleted = "completed";
    const String keywordRouteChallengeNext = "next";
    const String keywordRouteChallengeInProgress = "inProgress";
    const String keywordRouteActions = 'actions';
    final int userId = context.watch<AuthenticationCubit>().state.user!.id!;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text('Mes défis & gestes'),
          bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor:lightColorScheme.primary,
                  indicatorWeight: 4,
                  tabs: [
                    Tab(
                      child: Text('En cours'),
                    ),
                    Tab(
                      child: Text('À venir'),
                    ),
                    Tab(
                      child: Text('Réalisés'),
                    ),
                    Tab(
                      child: Text('Gestes'),
                    ),
                  ]),
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
            ChallengesWidget(
                keywordRoute: keywordRouteChallengeInProgress, userId: userId),
            ChallengesWidget(
                keywordRoute: keywordRouteChallengeNext, userId: userId),
            ChallengesWidget(
                keywordRoute: keywordRouteChallengeCompleted, userId: userId),
            ChallengesWidget(keywordRoute: keywordRouteActions, userId: userId),
          ],
        ),
        bottomNavigationBar: const AppBarFooter(),
      ),
    );
  }
}
