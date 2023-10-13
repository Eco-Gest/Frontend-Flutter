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
  final bool isLiked;
  final int likeCount;
  OnePostStateSuccess(this.post, this.isLiked, this.likeCount);
}

class PostsStateError extends PostsState {
  final String message;
  PostsStateError(this.message);
}

class PostStateUnLiked extends PostsState {
  final bool isLiked;
  PostStateUnLiked(this.isLiked);
}

class PostStateliked extends PostsState {
  final bool isLiked;
  PostStateliked(this.isLiked);
}
