import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/views/settings_view.dart';
import 'package:ecogest_front/widgets/account/update_account_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/account/account_infos.dart';
import 'package:ecogest_front/widgets/account/account_trophies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  static String name = 'account';

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    setState(() {
      context.read<AuthenticationCubit>().getCurrentUser();
    });
  }

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
    UserModel? user = context.read<AuthenticationCubit>().state.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        bottom: TabBar(
          indicatorColor: lightColorScheme.primary,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 2,
          controller: _tabController,
          tabs: [
            Tab(text: 'Mon profil'),
            Tab(text: 'Editer mon profil'),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
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
              child: RefreshIndicator(
                key: refreshIndicatorKey,
                onRefresh: refreshData,
                child: ListView(
                  children: [
                    // Account Info Widget
                    AccountInfo(user: user!),
                    SizedBox(height: 20),
                    // New Widget: Account Trophies
                    AccountTrophies(
                      userId: user.id!,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: UpdateAccountWidget(
                user: user!,
                isPrivateController: user!.isPrivate!,
              ),
            )
          ],
        ),
      ]),
    );
  }
}
