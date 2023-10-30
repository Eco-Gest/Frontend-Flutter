part of 'like_cubit.dart';

abstract class LikeState {}

class PostsStateError extends LikeState {
  final String message;
  PostsStateError(this.message);
}

class StateLikeInitial extends LikeState {}

class StateLikeSuccess extends LikeState {}


