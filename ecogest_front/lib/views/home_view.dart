import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:ecogest_front/widgets/post/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  static String name = 'home';
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    PostsCubit loadMorePost() {
      debugPrint('Hello de la view Home : Fin du scroll');
      debugPrint('Previous page = ${currentPage.toString()}');
      currentPage = currentPage + 1;
      debugPrint('Actual page = ${currentPage.toString()}');

      final cubit = PostsCubit();
      cubit.getPosts(currentPage);
      debugPrint(cubit.toString());
      return cubit;
    }

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
            buildWhen: (previous, current) =>
                (previous is PostsStateLoading && current is PostsStateSuccess),
            builder: (context, state) {
              if (state is PostsStateInitial || state is PostsStateLoading) {
                debugPrint('Chargement');
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PostsStateError) {
                debugPrint('Erreur');
                return Center(child: Text(state.message));
              } else if (state is PostsStateSuccess) {
                debugPrint('Hello from state');
                debugPrint('Success $currentPage');
                return PostsList(
                  posts: state.posts,
                  onScrolled: () {
                    debugPrint('Hello de la view Home : Fin du scroll');
                    debugPrint('Previous page = ${currentPage.toString()}');
                    currentPage = currentPage + 1;
                    debugPrint('Actual page = ${currentPage.toString()}');

                    final cubit = PostsCubit();
                    cubit.getPosts(currentPage);
                    debugPrint(cubit.toString());
                    return cubit;
                  },
                );
              } else if (state is PostsStateReloadSuccess) {
                debugPrint('Success $currentPage');
                return PostsList(
                  posts: state.posts,
                  onScrolled: () {
                    debugPrint('Hello de la view Home : Fin du scroll');
                    debugPrint('Previous page = ${currentPage.toString()}');
                    currentPage = currentPage + 1;
                    debugPrint('Actual page = ${currentPage.toString()}');

                    final cubit = PostsCubit();
                    cubit.getPosts(currentPage);
                    debugPrint(cubit.toString());
                    return cubit;
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}
