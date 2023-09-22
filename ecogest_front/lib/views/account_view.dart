import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  static String name = 'account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBarFooter(),
      body: Center(
        child: Text('Hello World from AccountView!'),
      ),
    );
  }
}