import 'package:ecogest_front/state_management/posts/form_post_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/post/post_form_widget.dart';

class PostEditView extends StatelessWidget {
  const PostEditView({required this.postId, Key? key}) : super(key: key);

  static String name = 'post_edit';
  final int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Editer la publication'),
      bottomNavigationBar: const AppBarFooter(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            MultiBlocProvider(
              providers: [
                BlocProvider<PostFormCubit>(
                  create: (context) => PostFormCubit(),
                ),
                BlocProvider<PostsCubit>(
                  create: (context) => PostsCubit()..getOnePost(postId),
                ),
              ],
              child: BlocBuilder<PostsCubit, PostsState>(
                builder: (context, state) {
                  if (state is PostsStateInitial) {
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
                            PostFormWidget(prefilledPost: state.post),
                          ],
                        ),
                      ),
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
