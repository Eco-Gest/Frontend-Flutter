import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:ecogest_front/widgets/post/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static String name = 'home';

  @override
  Widget build(BuildContext context) {
    int currentPage = 1;
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Accueil'),
      bottomNavigationBar: AppBarFooter(),
      body: BlocProvider<PostsCubit>(
        create: (context) {
          final cubit = PostsCubit();
          cubit.getPosts(currentPage);
          return cubit;
        },
        child: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            if (state is PostsStateInitial || state is PostsStateLoading) {
              debugPrint('Chargement');
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostsStateError) {
              debugPrint('Erreur');
              return Center(
                child: Text(state.message)
              );
            } else if (state is PostsStateSuccess) {
              debugPrint('Success');
              debugPrint('Home : ${currentPage.toString()}');
              return PostsList(posts: state.posts, page: currentPage);
            }
            return const SizedBox.shrink();
          },
        ),
      )
      
    );
  }
}