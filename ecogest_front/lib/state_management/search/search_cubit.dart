import 'package:ecogest_front/services/search_service.dart';
import 'package:ecogest_front/state_management/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchStateInitial());

  Future<void> getSearchResults(String query) async {
    if (query.isEmpty) {
      emit(SearchStateLoading());
    }
    try {
      emit(SearchStateLoading());
      final results = await SearchService.search(query);
      emit(SearchStateSuccess(results));
    } catch (error) {
      emit(SearchStateError(error.toString()));
    }
  }
}
