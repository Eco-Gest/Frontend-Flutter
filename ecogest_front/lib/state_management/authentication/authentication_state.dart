part of 'authentication_cubit.dart';

class AuthenticationState {
  final UserModel? user;

  AuthenticationState(this.user);
}

/// The initial state of the authentication cubit.
class AuthenticationInitial extends AuthenticationState {
  AuthenticationInitial() : super(null);
}

/// The state of the authentication cubit when the user is unauthenticated.
class AuthenticationUnauthenticated extends AuthenticationState {
  AuthenticationUnauthenticated() : super(null);
}

/// The state of the authentication cubit when the user is authenticated.
class AuthenticationAuthenticated extends AuthenticationState {
  AuthenticationAuthenticated(user) : super(user);
}

/// The state of the authentication cubit when an error occurred.
class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError(this.message) : super(null);

}
