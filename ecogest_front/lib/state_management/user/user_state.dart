part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final UserModel? user;

  UserSuccess(this.user);
}

/// The state of the authentication cubit when an error occurred.
class UserError extends UserState {
  final String message;

  UserError(this.message);
}