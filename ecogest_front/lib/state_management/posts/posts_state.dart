import 'package:ecogest_front/models/post_model.dart';

abstract class PostsState {}

class PostsStateInitial extends PostsState {
  final bool isLiked;
  final int likes;
  PostsStateInitial(this.isLiked, this.likes);
}

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

class PostStateUnliked extends PostsState {
  bool isLiked;
  PostStateUnliked(this.isLiked);
}

class PostStateLiked extends PostsState {
  bool isLiked;
  PostStateLiked(this.isLiked);
}
