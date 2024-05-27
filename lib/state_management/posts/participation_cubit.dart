import 'package:ecogest_front/services/participation_service.dart';
import 'package:ecogest_front/state_management/posts/participation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParticipationCubit extends Cubit<ParticipationState> {
  ParticipationCubit() : super(ParticipationStateInitial());

  Future<void> createParticipation(int postId) async {
    try {
      emit(ParticipationStateLoading());
    await ParticipationService.createParticipation(postId);
      emit(ParticipationStateSuccess());
    } catch (error) {
      emit(ParticipationStateError(
          "Erreur lors de votre inscription à cette publication"));
    }
  }
  Future<void> endChallenge(int postId) async {
    try {
      emit(ParticipationStateLoading());
    await ParticipationService.endChallenge(postId);
      emit(ParticipationStateSuccess());
    } catch (error) {
      emit(ParticipationStateError(
          "Erreur rencontrée pour terminer ce défi"));
    }
  }
  
}
