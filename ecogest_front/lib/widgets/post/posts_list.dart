import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/like/like_cubit.dart';
import 'package:ecogest_front/widgets/post/post_content_author.dart';
import 'package:ecogest_front/widgets/post/post_content_buttons_wrapper.dart';
import 'package:ecogest_front/widgets/post/post_content_infos.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatelessWidget {
  PostsList({
    super.key,
    required this.posts,
    required this.onScrolled,
    required this.isLastPage,
  });

  static String name = 'posts-list';
  final List<PostModel> posts;
  final bool isLastPage;

  // Functions which allows to indicate to the
  // parent view that the page has been scrolled
  final Function() onScrolled;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final authenticationState = context.read<AuthenticationCubit>().state;
    if (authenticationState is AuthenticationAuthenticated) {
      final UserModel? user = authenticationState.user;

      return NotificationListener(
        child: ListView.separated(
            padding: const EdgeInsets.all(16),
            controller: _scrollController,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: posts.length + (isLastPage ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (index < posts.length) {
                return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Author info
                          PostContentAuthor(
                              author: posts[index].user,
                              position: posts[index].position,
                              date: posts[index].createdAt),
                          const PostSeparator(),
                          // Post info
                          InkWell(
                            onTap: () {
                              // Redirect to post detail page
                              GoRouter.of(context)
                                  .push('/posts/${posts[index].id!}');
                            },
                            child: PostContentInfos(post: posts[index]),
                          ),
                          const PostSeparator(),
                          // Buttons
                          BlocProvider<LikeCubit>(
                            create: (context) => LikeCubit(),
                            child: PostContentButtonsWrapper(
                              post: posts[index],
                              likes: posts[index].likes!.length,
                              isLiked: posts[index].likes?.any(
                                      (like) => like.userId == user!.id) ??
                                  false, // TODO
                              comments: posts[index].comments,
                              isChallenge:
                                  (posts[index].type.toString() == 'challenge')
                                      ? true
                                      : false,
                            ),
                          ),
                        ],
                      ),
                    ));
              } else if (isLastPage) {
                return const Center(
                  child: Text("Pas de nouvelles publications à afficher"),
                );
              }
              return const SizedBox.shrink();
            }),
        // Listen to scroll events in the goal to load more posts
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
              // Event: user has reached the end of the list ->
              // onScrolled allows to inform the parent view that
              // the user has arrived at the bottom of the page
              onScrolled();
            }
          }
          return false;
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
