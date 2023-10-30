import 'package:ecogest_front/services/trophy_service.dart';
import 'package:ecogest_front/state_management/trophy/trophy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TrophyCubit extends Cubit<TrophyState> {
  TrophyCubit() : super(TrophyStateInitial());

  Future<void> getTrophies(int userId) async {
    try {
      emit(TrophyStateLoading());
      final posts = await TrophyService.getTrophies(userId);
      emit(TrophyStateSuccess(posts));
    } catch (error) {
      emit(TrophyStateError(error.toString()));
    }
  }

}