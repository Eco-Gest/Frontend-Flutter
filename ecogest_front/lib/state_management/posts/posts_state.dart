import 'package:ecogest_front/models/post_model.dart';

abstract class PostsState {}

class PostsStateInitial extends PostsState {}

class PostsStateLoading extends PostsState {}

class PostsStateSuccess extends PostsState {
  final List<PostModel> posts;
  PostsStateSuccess(this.posts);
}

class OnePostStateSuccess extends PostsState {
  final PostModel? post;

  OnePostStateSuccess(this.post);
}

class PostsStateError extends PostsState {
  final String message;
  PostsStateError(this.message);
}
