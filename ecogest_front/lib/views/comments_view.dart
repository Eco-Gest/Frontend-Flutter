import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/comment/comments_list.dart';
import 'package:flutter/material.dart';



class CommentsView extends StatelessWidget {
  CommentsView({
    super.key,
    // required this.comment,
    required this.postId
  });

  static String name = 'comments';
  // final PostModel? comment;
  final int postId;
  final _newCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Commentaires de la publication'),
      bottomNavigationBar: AppBarFooter(),
      body: Column(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CommentsList(),
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _newCommentController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    // TODO : Ajouter le commentaire au post
                    debugPrint(_newCommentController.text.toString());
                  },
                  icon: const Icon(Icons.send)
                ),
                hintText: 'Rédiger un commentaire...',
                // ),
              ),
            ),
          )
        ],
      )
    );
  }
}