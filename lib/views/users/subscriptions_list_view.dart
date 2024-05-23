import 'package:ecogest_front/models/users_relation_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/views/settings_view.dart';
import 'package:ecogest_front/widgets/account/subscriptions_list_widget.dart';
import 'package:ecogest_front/widgets/account/update_account_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/account/account_infos.dart';
import 'package:ecogest_front/widgets/account/account_trophies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';

class SubscriptionsListView extends StatefulWidget {
  const SubscriptionsListView({super.key, required this.user});

  static String name = 'subscriptions_list_widget';
  final UserModel user;

  @override
  _SubscriptionsListViewState createState() => _SubscriptionsListViewState();
}

class _SubscriptionsListViewState extends State<SubscriptionsListView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = widget.user;
    final bool isFollowing =
        user.following?.where((f) => f?.followerId == user.id).firstOrNull?.status ==
            "approved";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amis'),
        bottom: TabBar(
          indicatorColor: context.read<ThemeSettingsCubit>().state.isDarkMode
              ? darkColorScheme.primary
              : lightColorScheme.primary,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 2,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Abonnés'),
            Tab(text: 'Abonnements'),
          ],
        ),
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
      bottomNavigationBar: const AppBarFooter(),
      body: Stack(children: [
        TabBarView(
          controller: _tabController,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: SubscriptionsListWidget(
                  userId: user.id!,
                  subscriptions: user.followers!
                      .where((f) => f?.status == "approved")
                      .toList(),
                  isFollowerList: true,
                  isFollowing: isFollowing),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: SubscriptionsListWidget(
                  userId: user.id!,
                  subscriptions: user.following!
                      .where((f) => f?.status == "approved")
                      .toList(),
                  isFollowerList: false,
                  isFollowing: isFollowing),
            )
          ],
        ),
      ]),
    );
  }
}
