import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial()) {
  }

  Future<void> getUser(int userId) async {
    try {
      emit(UserLoading());
      final user = await UserService.getUser(userId);
      emit(UserSuccess(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
}