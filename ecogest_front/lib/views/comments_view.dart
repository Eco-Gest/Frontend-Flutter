import 'dart:convert';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/comment/comments_list.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:flutter/material.dart';



class CommentsView extends StatelessWidget {
  CommentsView({
    super.key,
    required this.comments,
    required this.postId
  });

  static String name = 'comments';
  // final List<dynamic> comments = jsonDecode(comments);
  List<dynamic> comments = [];
  // final String comments;
  final int postId;
  final _newCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint('Commentaires depuis comments_view');
    debugPrint(comments.toString());
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Commentaires de la publication'),
      bottomNavigationBar: const AppBarFooter(),
      body: Column(
        children: [
          if (comments.isNotEmpty) ...[
            const Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CommentsList(),
                ),
              )
            ),
          ] else ...[
            const Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: const Text("Il n'y a pas encore de commentaire pour cette publication"),
                ),
              )
            )
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
                  },
                  icon: const Icon(Icons.send),
                ),
                hintText: 'Rédiger un commentaire...',
              ),
            ),
          )
        ],
      )
    );
  }
}