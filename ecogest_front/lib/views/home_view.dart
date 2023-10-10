import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:ecogest_front/views/post_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static String name = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Accueil'),
      bottomNavigationBar: AppBarFooter(),
      body: const Text("Ici la home page"),
      
    );
  }
}
