import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/account_infos.dart';


class AccountView extends StatefulWidget {
  const AccountView({super.key});

  static String name = 'account';

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends  State<AccountView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Change length to 2
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
        title: Text('Profile'),
        bottom: TabBar(
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 2,   
          controller: _tabController,
          tabs: [
            Tab(text: 'Mon profile'), 
            Tab(text: 'Historique'), 
          ],
        ),
      ),
      bottomNavigationBar: AppBarFooter(),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(40.0), // Adjust the padding as needed
              child: AccountInfo(),
            ),
          ),
          Center(
            child: Text('This is my history'),
          ),
        ],
      ),
    );
  }
}
