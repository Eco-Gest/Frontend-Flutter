part of 'authentication_cubit.dart';

class AuthenticationState {
  UserModel? user;

  AuthenticationState(this.user);
}

/// The initial state of the authentication cubit.
class AuthenticationInitial extends AuthenticationState {
  AuthenticationInitial() : super(null);
}

class AuthenticationLoading extends AuthenticationState {
  AuthenticationLoading() : super(null);
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

/// The state of the authentication cubit when the reset password failed.
class AuthenticationResetPasswordStateError extends AuthenticationState {
  final String message;
  AuthenticationResetPasswordStateError(this.message) : super(null);
}

/// The state of the authentication cubit when the reset password was successful (but the user remains unauthenticated).
class AuthenticationResetPasswordStateSuccess extends AuthenticationState {
  final String message;
  AuthenticationResetPasswordStateSuccess(this.message) : super(null);
}

/// The state of the authentication cubit when the user account deletion was successful.
class AuthenticationAccountDeleted extends AuthenticationState {
  final String message;
  AuthenticationAccountDeleted(this.message) : super(null);
}

/// The state of the authentication cubit when the account deletion failed.
class AuthenticationDeleteAccountError extends AuthenticationState {
  final String message;
  AuthenticationDeleteAccountError(this.message) : super(null);
}


