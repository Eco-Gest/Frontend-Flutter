import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial()) {}

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
      emit(UserSuccess(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
}
