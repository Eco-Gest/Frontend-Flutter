import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/widgets/post/single_post.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatefulWidget {
  PostsList(
      {super.key,
      required this.posts,
      required this.onScrolled,
      required this.isLastPage,
      this.currentPage,
      this.postId});

  static String name = 'posts-list';
  final List<PostModel> posts;
  final bool isLastPage;
  final int? postId;
  final int? currentPage;
  final Function() onScrolled;

  @override
  _PostsList createState() => _PostsList();
}

class _PostsList extends State<PostsList> {
  // Functions which allows to indicate to the
  // parent view that the page has been scrolled
  final ScrollController _scrollController = ScrollController();

  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    setState(() {
      context.read<PostsCubit>().getPosts(widget.currentPage!);
    });
  }


  @override
  Widget build(BuildContext context) {
    final List<PostModel> posts = widget.posts;
    final bool isLastPage = widget.isLastPage;
    final Function() onScrolled = widget.onScrolled;

    return NotificationListener(
      child: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: refreshData,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          controller: _scrollController,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: posts.length + (isLastPage ? 1 : 0),
          itemBuilder: (BuildContext context, int index) {
            if (index < posts.length) {
              return InkWell(
                      onTap: () {
                        // Redirect to post detail page
                        GoRouter.of(context).push('/posts/${posts[index].id!}');
                      },
                      child: SinglePostWidget(post: posts[index]),
                    );
                          } else if (isLastPage) {
              return const Center(
                child: Text("Pas de nouvelles publications à afficher"),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
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
  }
}
