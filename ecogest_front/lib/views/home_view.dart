import 'package:ecogest_front/views/post_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static String name = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeAppBar(title: 'Accueil'),
      bottomNavigationBar: AppBarFooter(),
      body: const PostDetailView(),
    );
  }
}
