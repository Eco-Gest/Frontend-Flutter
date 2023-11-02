import 'package:ecogest_front/core/router.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/comments/comment_cubit.dart';
import 'package:ecogest_front/views/home_view.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/comment/comments_list.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsView extends StatelessWidget {
  CommentsView({super.key, required this.commentsList, required this.postId});

  static String name = 'comments';
  List<dynamic> commentsList = [];
  final int postId;
  final _newCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ThemeAppBar(title: 'Commentaires de la publication'),
        bottomNavigationBar: const AppBarFooter(),
        /*
        body: BlocProvider(
          create: (context) => CommentCubit(),
          child: Builder(builder: (context) {
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
                    GoRouter.of(context).goNamed(
                      HomeView.name,
                    );
                  }
                },*/
        body: Column(
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
            Container(
              color: EcogestTheme.primary,
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _newCommentController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    onPressed: () {
                      // TODO : Ajouter le commentaire au post
                      debugPrint(_newCommentController.text.toString());

                      //context.read<CommentCubit>().createComment(
                      //postId: postId,
                      //content: _newCommentController.text,
                      //);
                      //context.read<CommentCubit>().createComment(
                      //    postId: postId, content: _newCommentController.text);
                    },
                    icon: const Icon(Icons.send),
                  ),
                  hintText: 'Rédiger un commentaire...',
                ),
              ),
            )
          ],
        ));
  } //),
  //));
}
//}
