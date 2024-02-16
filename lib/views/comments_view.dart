import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/comment/comments_list.dart';
import 'package:ecogest_front/widgets/comment/create_comment.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/state_management/comments/comment_cubit.dart';
import 'package:ecogest_front/state_management/comments/comment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/models/comment_model.dart';

class CommentsView extends StatelessWidget {
  CommentsView({super.key, required this.commentsList, required this.postId});

  static String name = 'comments';
  List<dynamic> commentsList = [];
  final int postId;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationCubit>().state.user;
    return Scaffold(
        appBar: const ThemeAppBar(title: 'Commentaires de la publication'),
        bottomNavigationBar: const AppBarFooter(),
        body: BlocProvider(
          create: (context) => CommentCubit(),
          child: Builder(
            builder: (context) {
              return BlocListener<CommentCubit, CommentState>(
                listener: (context, state) {
                  if (state is CommentStateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Erreur lors de la création du commentaire.')),
                    );
                  }
                  if (state is CommentStateSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Création du commentaire réussie.')),
                    );
                  }
                },
                child: BlocBuilder<CommentCubit, CommentState>(
                    builder: (context, state) {
                  if (state is CommentStateSuccess) {
                    final newComment = CommentModel(
                        postId: postId,
                        content: state.comment.content,
                        author: user!);
                    commentsList.add(newComment);
                    return Column(
                      children: [
                        if (commentsList.isNotEmpty) ...[
                          Expanded(
                              child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CommentsList(comments: commentsList),
                            ),
                          )),
                        ] else ...[
                          const Expanded(
                              child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                  "Il n'y a pas encore de commentaire pour cette publication"),
                            ),
                          ))
                        ],
                        CreateComment(postId: postId),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      if (commentsList.isNotEmpty) ...[
                        Expanded(
                            child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CommentsList(comments: commentsList),
                          ),
                        )),
                      ] else ...[
                        const Expanded(
                            child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                                "Il n'y a pas encore de commentaire pour cette publication"),
                          ),
                        ))
                      ],
                      CreateComment(postId: postId),
                    ],
                  );
                }),
              );
            },
          ),
        ));
  }
}
