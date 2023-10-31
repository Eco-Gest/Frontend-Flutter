import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:ecogest_front/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit()
      : super(
          const AuthenticationState(AuthenticationStatus.unknown, null),
        );

  void getStatus() {
    UserService.getStatus.asBroadcastStream().listen((user) {
      if (user == null) {
        emit(const AuthenticationState(
            AuthenticationStatus.unauthenticated, null));
      } else {
        emit(AuthenticationState(AuthenticationStatus.authenticated, user));
      }
    });
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await AuthenticationService.login(email: email, password: password);
      emit(const AuthenticationState(AuthenticationStatus.loading, null));
      final user = await UserService.getCurrentUser();
      emit(AuthenticationState(AuthenticationStatus.authenticated, user));
    } catch (e) {
      // Failed to login, failed to parse the token or
      // error while getting the user
      emit(const AuthenticationState(AuthenticationStatus.error, null));
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String username}) async {
    try {
      await AuthenticationService.register(
          email: email, password: password, username: username);
      emit(const AuthenticationState(AuthenticationStatus.loading, null));
      final user = await UserService.getCurrentUser();
      emit(AuthenticationState(AuthenticationStatus.authenticated, user));
    } catch (e) {
      // Failed to login, failed to parse the token or
      // error while getting the user
      emit(const AuthenticationState(AuthenticationStatus.error, null));
    }
  }

  Future<void> logout() async {
    await AuthenticationService.logout();
    emit(const AuthenticationState(AuthenticationStatus.unauthenticated, null));
  }
}
