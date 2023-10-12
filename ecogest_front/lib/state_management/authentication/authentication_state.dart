part of 'authentication_cubit.dart';

abstract class AuthenticationState {}

/// The initial state of the authentication cubit.
class AuthenticationInitial extends AuthenticationState {}

/// The state of the authentication cubit when the user is unauthenticated.
class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

/// The state of the authentication cubit when the user is authenticated.
class AuthenticationAuthenticated extends AuthenticationState {
  final UserModel? user;

  AuthenticationAuthenticated(this.user);
}

/// The state of the authentication cubit when an error occurred.
class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError(this.message);
}