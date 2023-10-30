abstract class SubscriptionState {
}

class SubscriptionStateInitial extends SubscriptionState {}

class SubscriptionStateLoading extends SubscriptionState {}

class SubscriptionStateSuccess extends SubscriptionState {}

class SubscriptionStateError extends SubscriptionState {
  final String message;

  SubscriptionStateError(this.message);
}
