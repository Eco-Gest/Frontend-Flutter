import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/subscription_service.dart';
import 'package:ecogest_front/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial()) {}

  Future<void> getUser(int userId) async {
    try {
      emit(UserLoading());
      final user = await UserService.getUser(userId);
      final userAuthenticated = await UserService.getCurrentUser();

      final isFollowed = SubscriptionService.isFollowed(userAuthenticated, user);
      final isFollowing =  SubscriptionService.isFollowing(userAuthenticated, user);

      emit(UserSuccess(user, isFollowed, isFollowing));
    } catch (error) {
      emit(UserError("Erreur rencontrée. Veuillez réessayer."));
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
      emit(UserAccountSuccess(user));
    } catch (error) {
      emit(UserError("Erreur rencontrée pour la mise à jour de vos données. Veuillez réessayer."));
    }
  }
}
