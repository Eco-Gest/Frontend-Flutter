import 'package:ecogest_front/models/comment_model.dart';

abstract class CommentState {
  const CommentState();
}

class CommentStateInitial extends CommentState {}

class CommentStateCompleted extends CommentState {}

class CommentStateSuccess extends CommentState {
  const CommentStateSuccess(this.comment);

  final CommentModel comment;
}

class CommentStateError extends CommentState {
  final String message;

  const CommentStateError(this.message);
}
