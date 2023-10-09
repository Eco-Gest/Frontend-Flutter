abstract class BaseState {
  const BaseState();
}

/// The initial state of the CRUD cubit.
abstract class InitialState extends BaseState {
  const InitialState();
}

/// The state of the CRUD cubit when the data is loading.
abstract class LoadingState extends BaseState {
  const LoadingState();
}

/// The state of the CRUD cubit when the data is loaded.
abstract class LoadedState<T> extends BaseState {
  const LoadedState(this.data);

  final T data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadedState<T> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

/// The state of the CRUD cubit when an error occurs.
abstract class ErrorState extends BaseState {
  const ErrorState();
}
