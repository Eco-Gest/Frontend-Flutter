import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:ecogest_front/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial()) {
    // Get the current user when the cubit is initialized.
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    emit(AuthenticationLoading());
    final token = await AuthenticationService.getToken();
    if (token != null) {
      final user = await UserService.getCurrentUser();
      emit(AuthenticationAuthenticated(user));
    } else {
      emit(AuthenticationInitial());
    }
  }

  Future<void> reloadCurrentUser() async {
    final user = await UserService.getCurrentUser();
    emit(AuthenticationAuthenticated(user));
  }

  Future<void> login({required String email, required String password}) async {
    try {
      emit(AuthenticationLoading());
      await AuthenticationService.login(email: email, password: password);
      final user = await UserService.getCurrentUser();
      emit(AuthenticationAuthenticated(user));
    } catch (e) {
      // Failed to login, failed to parse the token or
      // error while getting the user
      emit(AuthenticationUnauthenticated(
          "Erreur lors de votre connexion. Veuillez réessayer."));
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String username}) async {
    try {
      await AuthenticationService.register(
          email: email, password: password, username: username);
      final user = await UserService.getCurrentUser();
      emit(AuthenticationAuthenticated(user));
    } catch (e) {
      // Failed to login, failed to parse the token or
      // error while getting the user
      if (e.toString().contains('Username')) {
        emit(AuthenticationUnauthenticated(
            'Nom d\'utilisateur déjà utilisé. Veuillez en choisir un autre.'));
      } else if (e.toString().contains('Email')) {
        emit(AuthenticationUnauthenticated(
            'Adresse mail déjà utilisée. Veuillez vous connecter.'));
      } else {
        emit(AuthenticationUnauthenticated(
            "Erreur lors de votre inscription. Veuillez réessayer."));
      }
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await AuthenticationService.resetPassword(email: email);
      emit(AuthenticationResetPasswordStateSuccess("Email envoyé"));
    } catch (e) {
      // Failed to send the email or the user email doesn't exist
      emit(AuthenticationResetPasswordStateError(
          "Erreur lors de l'envoi de l'email. Veuillez réessayer."));
    }
  }

  Future<void> logout() async {
    await AuthenticationService.logout();
    emit(AuthenticationUnauthenticated("Déconnecté."));
  }

  Future<void> deleteMyAccount() async {
    try {
      await AuthenticationService.deleteMyAccount();

        emit(AuthenticationAccountDeleted("Compte supprimé avec succès."));

        await Future.delayed(const Duration(seconds: 3));

        emit(AuthenticationUnauthenticated("Vous êtes maintenant déconnecté."));
    } catch (error) {
      emit(AuthenticationDeleteAccountError(
          "Erreur rencontrée lors de la suppression de votre compte. Veuillez réessayer."));
    }
  }
}
