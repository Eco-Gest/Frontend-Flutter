import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/comments/comment_cubit.dart';

class CreateComment extends StatelessWidget {
  CreateComment({super.key, required this.postId});

  int postId;
  final _newCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: EcogestTheme.primary,
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _newCommentController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            onPressed: () {
              context.read<CommentCubit>().createComment(
                    postId: postId,
                    content: _newCommentController.text,
                  );
            },
            icon: const Icon(Icons.send),
          ),
          hintText: 'Rédiger un commentaire...',
        ),
      ),
    );
  }
}
