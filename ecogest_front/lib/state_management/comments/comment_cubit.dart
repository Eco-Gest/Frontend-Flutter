import 'package:ecogest_front/services/comment_service.dart';
import 'package:ecogest_front/state_management/comments/comment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentStateInitial());

  Future<void> createComment(
      {required int postId, required String content}) async {
    try {
      final result = await CommentService.createComment(content, postId);
      emit(CommentStateSuccess(result));
    } catch (error) {
      emit(CommentStateError(error.toString()));
    }
  }
}
