import 'package:ecogest_front/models/comment_model.dart';

abstract class CommentState {
  const CommentState();
}
class CommentStateInitial extends CommentState {}

class CommentStateLoading extends CommentState {}

class CommentStateCompleted extends CommentState {}

class CommentStateSuccess extends CommentState {
  const CommentStateSuccess(this.comment);

  final CommentModel comment;
}

class DeleteCommentStateSuccess extends CommentState {}
class ReportCommentStateSuccess extends CommentState {}

class CommentStateError extends CommentState {
  final String message;

  const CommentStateError(this.message);
}

class DeleteCommentStateError extends CommentState {
  final String message;

  const DeleteCommentStateError(this.message);
}

class ReportCommentStateError extends CommentState {
  final String message;

  const ReportCommentStateError(this.message);
}