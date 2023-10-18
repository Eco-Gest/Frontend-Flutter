import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/authentication_service.dart';
import 'package:ecogest_front/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial()) {
  }

  Future<void> getUser(int userId) async {
    try {
      emit(UserLoading());
      final posts = await UserService.getUser(userId);
      emit(UserSuccess(posts));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
}