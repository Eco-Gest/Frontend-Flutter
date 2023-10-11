import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/account/account_infos.dart';
import 'package:ecogest_front/widgets/account/account_trophies.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        bottom: TabBar(
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 2,
          controller: _tabController,
          tabs: [
            Tab(text: 'Mon profil'),
            Tab(text: 'Historique'),
          ],
        ),
      ),
      bottomNavigationBar: AppBarFooter(),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: [
              // Account Info Widget
              AccountInfo(),
              SizedBox(height: 20),
              // New Widget: Account Trophies
              AccountTrophies(),
            ],
          ),
          Center(
            child: Text('This is my history'),
          ),
        ],
      ),
    );
  }
}
