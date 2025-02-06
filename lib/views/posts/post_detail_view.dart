import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/post/single_post.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailView extends StatefulWidget {
  const PostDetailView({required this.postId, super.key});

  static String name = 'post';
  final int postId;

  @override
  _PostDetailView createState() => _PostDetailView();
}

class _PostDetailView extends State<PostDetailView> {
  List<String> items = List.generate(20, (index) => 'Item ${index + 1}');
  @override
  Widget build(BuildContext context) {
    final int postId = widget.postId;
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Détail de la publication'),
      bottomNavigationBar: const AppBarFooter(),
      body: BlocProvider<PostsCubit>(
        create: (context) {
          final cubit = PostsCubit();
          cubit.getOnePost(postId);
          return cubit;
        },
        child: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            if (state is PostsStateInitial || state is PostsStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostsStateError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is OnePostStateSuccess) {
              return SingleChildScrollView(
                child: SinglePostWidget(post: state.post!),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
