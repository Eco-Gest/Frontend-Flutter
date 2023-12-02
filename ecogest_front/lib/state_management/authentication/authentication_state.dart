part of 'authentication_cubit.dart';

class AuthenticationState {
  UserModel? user;

  AuthenticationState(this.user);
}

/// The initial state of the authentication cubit.
class AuthenticationInitial extends AuthenticationState {
  AuthenticationInitial() : super(null);
}

/// The state of the authentication cubit when the user is unauthenticated.
class AuthenticationUnauthenticated extends AuthenticationState {
  final String message;
  AuthenticationUnauthenticated(this.message) : super(null);
}

/// The state of the authentication cubit when the user is authenticated.
class AuthenticationAuthenticated extends AuthenticationState {
  AuthenticationAuthenticated(user) : super(user);
}
