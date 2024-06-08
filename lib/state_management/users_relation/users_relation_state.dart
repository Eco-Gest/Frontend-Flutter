abstract class UsersRelationState {}

class UsersRelationStateInitial extends UsersRelationState {}

class UsersRelationStateLoading extends UsersRelationState {}

class SubscriptionStateSuccess extends UsersRelationState {}

class SubscriptionCancelStateSuccess extends UsersRelationState {}

class UnSubscriptionStateSuccess extends UsersRelationState {
  final int followingId;

  UnSubscriptionStateSuccess(this.followingId);
}

class SubscriptionApproveOrDeclineStateSuccess extends UsersRelationState {}

class UsersRelationStateError extends UsersRelationState {
  final String message;

  UsersRelationStateError(this.message);
}

class BlockStateSuccess extends UsersRelationState {}

class UnBlockStateSuccess extends UsersRelationState {}

class RemoveFollowerStateSuccess extends UsersRelationState {
  final int followerId;

  RemoveFollowerStateSuccess(this.followerId);
}
