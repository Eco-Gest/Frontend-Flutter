part of 'like_cubit.dart';

abstract class LikeState {}

class StateLikeError extends LikeState {
  final String message;
  StateLikeError(this.message);
}

class StateLikeInitial extends LikeState {}

class StateLikeSuccess extends LikeState {}

class StateUnlikeSuccess extends LikeState {}
 