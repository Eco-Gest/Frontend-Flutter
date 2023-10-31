part of 'post_edit_cubit.dart';

abstract class PostEditState {
  const PostEditState();
}

class PostEditStateInitial extends PostEditState {}

class PostsStateLoading extends PostEditState {}

class PostEditStateLoaded extends PostEditState {
  final PostModel post;

  PostEditStateLoaded(this.post);
}

class PostEditStateSuccess extends PostEditState {
  final PostModel updatedPost;

  PostEditStateSuccess(this.updatedPost);
}

class PostEditStateError extends PostEditState {
  final String message;

  PostEditStateError(this.message);
}
