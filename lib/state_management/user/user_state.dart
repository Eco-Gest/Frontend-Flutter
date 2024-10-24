part of 'user_cubit.dart';

abstract class UserState {
  UserModel? user;

  UserState(this.user);

}

class UserInitial extends UserState {

   UserInitial() : super(null);
}

class UserLoading extends UserState {
   UserLoading() : super(null);
   
   }

class UserSuccess extends UserState {
  final UserModel? user;
  final bool? isFollowed;
  final bool? isFollowing;
  final bool? isBlocked;

  UserSuccess(this.user, this.isFollowed, this.isFollowing, this.isBlocked): super(user);
}

class UserAccountSuccess extends UserState {
  UserAccountSuccess(user) : super(user);
}

/// The state of the authentication cubit when an error occurred.
class UserError extends UserState {
  final String message;

  UserError(this.message) : super(null);
}
