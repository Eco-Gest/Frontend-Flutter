import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/services/search_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchStateInitial());

  Future<void> getSearchResults(String query) async {
    try {
      final users = await SearchService.searchUsers(query);
      final posts = await SearchService.searchPosts(query);
      emit(SearchStateSuccess(users, posts));
    } catch (error) {
      emit(SearchStateError(error.toString()));
    }
  }
}
