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

  List<PostModel> allPosts = List.empty();
  bool noMorePosts = false;

  @override
  Widget build(BuildContext context) {
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PostsStateError) {
                return Center(child: Text(state.message));
              } else if (state is PostsStateSuccess) {
                allPosts += state.posts;
                (state.posts.isEmpty) ? noMorePosts = true : '';
                return PostsList(
                  posts: allPosts,
                  isLastPage: noMorePosts,
                  onScrolled: () {
                    if (!noMorePosts) {
                      currentPage = currentPage + 1;
                      context.read<PostsCubit>().getPosts(currentPage);
                    }
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}
