part of 'authentication_cubit.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  loading,
  unknown,
  error
}

class AuthenticationState {
  final AuthenticationStatus status;
  final UserModel? user;

  const AuthenticationState(this.status, this.user);
}
