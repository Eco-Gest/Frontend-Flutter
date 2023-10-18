import 'package:ecogest_front/widgets/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/account/account_infos.dart';
import 'package:ecogest_front/widgets/account/account_trophies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key});

  static String name = 'account';

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView>
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
      final authenticationState = context.read<AuthenticationCubit>().state;
    if (authenticationState is AuthenticationAuthenticated) {
      final user = authenticationState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        bottom: TabBar(
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 2,
          controller: _tabController,
          tabs: [
            Tab(text: 'Mon profil'),
            Tab(text: 'Paramètres'),
          ],
        ),
      ),
      bottomNavigationBar: const AppBarFooter(),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: ListView(
              children: [ 
                // Account Info Widget
                AccountInfo(user: user ),
                SizedBox(height: 20),
                // New Widget: Account Trophies
                AccountTrophies(),
              ],
            ),
          ),
          SettingsWidget(),
        ],
      ),
    );
        } else {
      // Handle the case where the state is not AuthenticationAuthenticated
      return Center(
        child: Text('User not authenticated'),
      );
    }
  }
}
