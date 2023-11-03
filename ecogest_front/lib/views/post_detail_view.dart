import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/like/like_cubit.dart';
import 'package:ecogest_front/state_management/posts/participation_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/post/participation_widet.dart';
import 'package:ecogest_front/widgets/post/post_content_author.dart';
import 'package:ecogest_front/widgets/post/post_content_buttons_wrapper.dart';
import 'package:ecogest_front/widgets/post/post_content_infos.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView({required this.postId, super.key});

  static String name = 'post';
  final int postId;

  @override
  Widget build(BuildContext context) {
    final UserModel? user = context.watch<AuthenticationCubit>().state.user;
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Détail de la publication'),
      bottomNavigationBar: AppBarFooter(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocProvider<PostsCubit>(
              create: (context) {
                final cubit = PostsCubit();
                cubit.getOnePost(postId);
                return cubit;
              },
              child: BlocBuilder<PostsCubit, PostsState>(
                builder: (context, state) {
                  if (state is PostsStateInitial ||
                      state is PostsStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PostsStateError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is OnePostStateSuccess) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Author info
                          PostContentAuthor(
                              postId: postId,
                              author: state.post!.user,
                              position: state.post!.position,
                              date: state.post!.createdAt),
                          const PostSeparator(),
                          // Post info
                          PostContentInfos(
                            post: state.post,
                          ),
                          const PostSeparator(),
                          // Buttons
                          BlocProvider<LikeCubit>(
                              create: (context) => LikeCubit(),
                              child: PostContentButtonsWrapper(
                                post: state.post!,
                                likes: state.post!.likes!.length,
                                isLiked: state.post!.likes!
                                    .any((like) => like.userId == user!.id!),
                                comments: state.post!.comments,
                                isChallenge:
                                    (state.post!.type.toString() == 'challenge')
                                        ? true
                                        : false,
                              ),
                          ),
                        ],
                      ),
                    ));
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
