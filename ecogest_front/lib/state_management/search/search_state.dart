import 'package:ecogest_front/models/trophy_model.dart';

abstract class SearchState {}

class SearchStateInitial extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateSuccess extends SearchState {
  final List<List<String?>> results;

  SearchStateSuccess(this.results);
}


class SearchStateError extends SearchState {
  final String message;

  SearchStateError(this.message);
}