import 'package:ecogest_front/services/posts_service.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsStateInitial());

  Future<void> getPosts(int pageNbr) async {
    try {
      emit(PostsStateLoading());
      final posts = await PostsService.getPosts(pageNbr);
      emit(PostsStateSuccess(posts));
    } catch (error) {
      emit(PostsStateError(error.toString()));
    }
  }
  Future<void> getOnePost(int postId) async {
    try {
      emit(PostsStateLoading());
      final post = await PostsService.getOnePost(postId);
      emit(OnePostStateSuccess(post));
    } catch (error) {
      emit(PostsStateError(error.toString()));
    }
  }
}