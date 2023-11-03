import 'package:ecogest_front/services/post_service.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsStateInitial());

  Future<void> getPosts(int pageNbr) async {
    try {
      emit(PostsStateLoading());
      final posts = await PostService.getPosts(pageNbr);
      emit(PostsStateSuccess(posts));
    } catch (error) {
      emit(PostsStateError(
          "Erreur rencontrée pour récupérer les publications. Veuillez réessayer."));
    }
  }

  Future<void> getOnePost(int postId) async {
    try {
      emit(PostsStateLoading());
      final post = await PostService.getOnePost(postId);
      emit(OnePostStateSuccess(post));
    } catch (error) {
      emit(PostsStateError(
          "Erreur rencontrée pour récupérer la publication. Veuillez réessayer."));
    }
  }

  Future<void> getUserPostsFiltered(String backendRoute) async {
    try {
      emit(PostsStateLoading());
      final posts = await PostService.getUserPostsFiltered(backendRoute);
      emit(PostsStateSuccess(posts));
    } catch (error) {
      emit(PostsStateError(
          "Erreur rencontrée pour récupérer vos publications. Veuillez réessayer."));
    }
  }

    Future<void> deletePost(int postId) async {
    try {
        emit(PostsStateLoading());
     await PostService.deletePost(postId);
         emit(DeletePostStateSuccess());
    } catch (error) {
        emit(PostsStateError("Erreur rencontrée pour supprimer votre publications. Veuillez réessayer."));
    }
  }
}
