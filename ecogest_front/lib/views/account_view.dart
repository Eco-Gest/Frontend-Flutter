import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
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
        title: const Text('Profil'),
        bottom: TabBar(
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 2,   
          controller: _tabController,
          tabs: [
            const Tab(text: 'Mon profil'), 
            const Tab(text: 'Historique'), 
          ],
        ),
      ),
      bottomNavigationBar: const AppBarFooter(),
      body: TabBarView(
        controller: _tabController,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(40.0), // Adjust the padding as needed
              child: AccountInfo(),
            ),
          ),
          const Center(
            child: Text('This is my history'),
          ),
        ],
      ),
    );
  }
}
