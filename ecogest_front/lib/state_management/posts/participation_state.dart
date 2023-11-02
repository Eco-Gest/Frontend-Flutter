import 'package:ecogest_front/models/user_post_participation_model.dart';

abstract class ParticipationState {}

class ParticipationStateInitial extends ParticipationState {}

class ParticipationStateLoading extends ParticipationState {}

class ParticipationStateSuccess extends ParticipationState {}

class ParticipationStateError extends ParticipationState {
  final String message;
  ParticipationStateError(this.message);
}
