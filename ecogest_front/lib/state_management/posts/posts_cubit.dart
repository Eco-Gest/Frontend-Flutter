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

      // Utilisez votre service pour effectuer la suppression
      await PostService.deletePost(postId);

      // Une fois la suppression réussie, mettez à jour l'état
      // Vous pouvez choisir de récupérer les posts mis à jour ou d'émettre un nouvel état
      // Ici, j'émet simplement un état success pour indiquer que la suppression a réussi
      emit(DeletePostStateSuccess());
    } catch (error) {
      // En cas d'erreur lors de la suppression, émettez un état d'erreur
      emit(PostsStateError(error.toString()));
    }
  }
}
