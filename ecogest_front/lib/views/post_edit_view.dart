import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/posts/post_edit_cubit.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';

class PostEditView extends StatelessWidget {
  const PostEditView({required this.postId, Key? key}) : super(key: key);

  static String name = 'post_edit';
  final int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Editer la publication'),
      bottomNavigationBar: AppBarFooter(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocProvider<PostEditCubit>(
              create: (context) {
                final cubit = PostEditCubit();
                cubit.getPostDetails(postId);
                return cubit;
              },
              child: BlocBuilder<PostEditCubit, PostEditState>(
                builder: (context, state) {
                  if (state is PostEditStateInitial ||
                      state is PostsStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PostEditStateError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is PostEditStateLoaded) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text('coucou'),
                            // Utilisez les détails du post pour pré-remplir le formulaire d'édition
                            // ... le reste de votre implémentation ...
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
