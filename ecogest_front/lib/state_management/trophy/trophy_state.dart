import 'package:ecogest_front/models/trophy_model.dart';

abstract class TrophyState {}

class TrophyStateInitial extends TrophyState {}

class TrophyStateLoading extends TrophyState {}

class TrophyStateSuccess extends TrophyState {
  final List<TrophyModel> Trophy;

  TrophyStateSuccess(this.Trophy);
}


class TrophyStateError extends TrophyState {
  final String message;

  TrophyStateError(this.message);
}