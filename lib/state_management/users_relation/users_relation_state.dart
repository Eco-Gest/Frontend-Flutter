abstract class UsersRelationState {
}

class UsersRelationStateInitial extends UsersRelationState {}

class UsersRelationStateLoading extends UsersRelationState {}

class SubscriptionStateSuccess extends UsersRelationState {}

class SubscriptionCancelStateSuccess extends UsersRelationState {}

class UnSubscriptionStateSuccess extends UsersRelationState {}

class SubscriptionApproveOrDeclineStateSuccess extends UsersRelationState {}

class UsersRelationStateError extends UsersRelationState {
  final String message;

  UsersRelationStateError(this.message);
}

class BlockStateSuccess extends UsersRelationState {}

class UnBlockStateSuccess extends UsersRelationState {}

class RemoveFollowerStateSuccess extends UsersRelationState {}