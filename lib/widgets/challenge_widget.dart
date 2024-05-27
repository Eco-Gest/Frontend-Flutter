import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:ecogest_front/widgets/post/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengesWidget extends StatefulWidget {
  const ChallengesWidget(
      {super.key, required this.keywordRoute, required this.userId});
  final String keywordRoute;
  final int userId;
  _ChallengesWidget createState() => _ChallengesWidget();
}

class _ChallengesWidget extends State<ChallengesWidget> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    setState(() {
      context
          .read<PostsCubit>()
          .getUserPostsFiltered(widget.keywordRoute, widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String keywordRoute = widget.keywordRoute;
    final int userId = widget.userId;
    return SingleChildScrollView(
      scrollDirection: axisDirectionToAxis(AxisDirection.down),
      child: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: refreshData,
        child: Stack(
          children: [
            BlocProvider<PostsCubit>(
              create: (context) {
                final cubit = PostsCubit();
                cubit.getUserPostsFiltered(keywordRoute, userId);
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
                    return Center(child: Text(state.message));
                  } else if (state is PostsStateSuccess) {
                    if (state.posts.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: const Center(
                          child: Text('Oops aucun défi ici'),
                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}
