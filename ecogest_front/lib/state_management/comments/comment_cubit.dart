import 'package:ecogest_front/services/comment_service.dart';
import 'package:ecogest_front/state_management/comments/comment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentStateInitial());

  Future<void> createComment({
    required int postId,
    required String content,
  }) async {
    try {
      final result = await CommentService.createComment(content, postId);
      emit(CommentStateSuccess(result));
    } catch (error) {
      emit(CommentStateError(error.toString()));
    }
  }

  Future<void> deleteComment(int commentId) async {
    try {
        emit(CommentStateLoading());
     await CommentService.deleteComment(commentId);
         emit(DeleteCommentStateSuccess());
         debugPrint("Commentaire supprimé");
    } catch (error) {
        emit(DeleteCommentStateError("Erreur rencontrée pour supprimer votre commentaire. Veuillez réessayer."));
    }
  }

  Future<void> submitReport(int commentId, int authorId, String content, String result) async {
    try {
      emit(CommentStateLoading());
      await CommentService.submitReport(commentId, authorId, content, result);

      emit(ReportCommentStateSuccess());
    } catch (error) {
      emit(ReportCommentStateError("Erreur rencontrée lors du signalement. Veuillez réessayer."));
    }
  }
}
