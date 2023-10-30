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
    await AuthenticationService.login(email: email, password: password);
  }

  Future<void> register(
      {required String email,
      required String password,
      required String username}) async {
    await AuthenticationService.register(
        email: email, password: password, username: username);
  }

  Future<void> logout() async {
    await AuthenticationService.logout();
    emit(const AuthenticationState(AuthenticationStatus.unauthenticated, null));
  }
}
