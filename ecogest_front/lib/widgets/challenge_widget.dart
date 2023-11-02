import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:ecogest_front/widgets/post/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengesWidget extends StatelessWidget {
  const ChallengesWidget({super.key, required this.backendRoute});
  final String backendRoute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<PostsCubit>(
      create: (context) {
        final cubit = PostsCubit();
        cubit.getUserPostsFiltered(backendRoute);
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
            if (state.posts.isEmpty) {
              return  Center(
                child: const Text('Oops aucun défi ici'),
              );
            }
            return PostsList(
              posts: state.posts,
              onScrolled: () {},
              isLastPage: false,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    ));
  }
}
