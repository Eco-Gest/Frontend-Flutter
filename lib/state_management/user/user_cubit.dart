import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/users_relation_service.dart';
import 'package:ecogest_front/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';


part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  //UserCubit() : super(UserInitial());
  final AuthenticationCubit authenticationCubit;
  UserCubit({required this.authenticationCubit}) : super(UserInitial());

  Future<void> getUser(int userId) async {
    try {
      emit(UserLoading());
      final user = await UserService.getUser(userId);
      final userAuthenticated = await UserService.getCurrentUser();

      final isFollowed =
          UsersRelationService.isFollowed(userAuthenticated, user);
      final isFollowing =
          UsersRelationService.isFollowing(userAuthenticated, user);
      final isBlocked =
          UsersRelationService.isBlocked(userAuthenticated, user);
      emit(UserSuccess(user, isFollowed, isFollowing, isBlocked));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> updateUserAccount({
    required String username,
    required bool isPrivate,
    String? biography,
    DateTime? birthdate,
    String? position,
    String? image,
  }) async {
    final user = UserModel(
      username: username,
      position: position,
      biography: biography,
      birthdate: birthdate?.toIso8601String(),
      image: image,
      isPrivate: isPrivate,
    );

    try {
      emit(UserLoading());
      await UserService.updateUserAccount(user);

  final updatedUser = await UserService.getCurrentUser();

    final isFollowed = UsersRelationService.isFollowed(updatedUser, updatedUser);
    final isFollowing = UsersRelationService.isFollowing(updatedUser, updatedUser);
    final isBlocked = UsersRelationService.isBlocked(updatedUser, updatedUser);

    emit(UserSuccess(updatedUser, isFollowed, isFollowing, isBlocked));
    authenticationCubit.emit(AuthenticationAuthenticated(updatedUser));
    } catch (error) {
      emit(UserError(
          "Erreur rencontrée pour la mise à jour de vos données. Veuillez réessayer."));
    }
  }

  Future<void> submitReport(int userId, String result) async {
    try {
      emit(UserLoading());
      await UserService.submitReport(userId, result);
      final user = await UserService.getUser(userId);

      emit(UserSuccess(user, null, null, null));
    } catch (error) {
      emit(UserError(
          "Erreur rencontrée lors du signalement. Veuillez réessayer."));
    }
  }

  Future<void> changePassword(
      {required String oldPassword,
      required String password,
      required String passwordRepeated}) async {
    try {
      emit(UserLoading());
      await UserService.changePassword(
          oldPassword: oldPassword,
          password: password,
          passwordRepeated: passwordRepeated);
      final user = await UserService.getCurrentUser();
      emit(UserSuccess(user, null, null, null));
    } catch (error) {
      emit(UserError(
          "Erreur rencontrée lors du changement de mot de passe. Veuillez réessayer."));
    }
  }
}
