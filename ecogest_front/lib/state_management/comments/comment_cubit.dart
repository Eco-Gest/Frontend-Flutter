/*import 'package:ecogest_front/models/comment_model.dart';
import 'package:ecogest_front/services/comment_service.dart';
import 'package:ecogest_front/state_management/comments/comment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentStateInitial());

  Future<void> createComment({required int postId, required String content}) async {
    debugPrint('Ici');

    try {
      final result = await CommentService.createComment(content, postId);
      emit(CommentStateSuccess(result));
    } catch (error) {
      emit(CommentStateError(error.toString()));
    }




    // final comment = CommentModel(
    //   postId: postId, 
    //   // authorId: authorId,
    //   content: content
    // );

    // try {
    //   final result = await CommentService.createComment('Ceci est un tout nouveau commentaire en dur depuis le cubit', postId);
    //   emit(CommentStateSuccess(result));
    // } catch (e) {
    //   debugPrint(e.toString());
    //   emit(CommentStateError(e.toString()));
    // }
  }
}*/