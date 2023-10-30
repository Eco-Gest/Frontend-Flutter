part of 'authentication_cubit.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  unknown,
}

class AuthenticationState {
  final AuthenticationStatus status;
  final UserModel? user;

  const AuthenticationState(this.status, this.user);
}