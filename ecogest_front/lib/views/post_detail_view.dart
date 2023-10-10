import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/post_content_author.dart';
import 'package:ecogest_front/widgets/post_content_buttons.dart';
import 'package:ecogest_front/widgets/post_content_infos.dart';
import 'package:ecogest_front/widgets/post_separator.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({
    required this.postId,
    super.key
  });

  static String name = 'post';
  final int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Un post'),
      bottomNavigationBar: AppBarFooter(),
      body: BlocProvider<PostsCubit>(
        create: (context) {
          final cubit = PostsCubit();
          cubit.getOnePost(postId);
          return cubit;
        },
        child: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            if (state is PostsStateInitial || state is PostsStateLoading) {
              debugPrint('Chargment');
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostsStateError) {
              debugPrint('Error');
              // debugPrint(state);
              return Center(
                child: Text(state.message),
              );
            } else if (state is OnePostStateSuccess) {
              debugPrint('Success');
              debugPrint(state.post!.type.toString());
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Author info
                      PostContentAuthor(
                        author: state.post!.user, 
                        position: state.post!.position, 
                        date: state.post!.createdAt
                      ),
                      const PostSeparator(),
                      // Post info
                      PostContentInfos(post: state.post,),
                      const PostSeparator(),
                      // Buttons
                      PostContentButtons(
                        likes: state.post!.likes,
                        comments: state.post!.comments,
                        isChallenge: (state.post!.type.toString() == 'challenge') ? true : false,
                      ),
                    ],
                  ),
                )
              );
            }
            return const SizedBox.shrink();
          },
        ),
      )
    );
  }
}