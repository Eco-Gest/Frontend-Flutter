import 'package:ecogest_front/services/post_service.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsStateInitial());

  static final PostService postService = PostService();

  Future<void> getPosts(int pageNbr, bool forceReload) async {
    try {
      emit(PostsStateLoading());
      final posts = await postService.getPosts(pageNbr, forceReload);
      emit(PostsStateSuccess(posts));
    } catch (error) {
      emit(PostsStateError(
          "Erreur rencontrée pour récupérer les publications. Veuillez réessayer."));
    }
  }

  Future<void> getOnePost(int postId, bool forceReload) async {
    try {
      final PostService postService = PostService();
      emit(PostsStateLoading());
      final post = await postService.getOnePost(postId, forceReload);
      emit(OnePostStateSuccess(post));
    } catch (error) {
      emit(PostsStateError(
          "Erreur rencontrée pour récupérer la publication. Veuillez réessayer."));
    }
  }

  Future<void> getUserPostsFiltered(String keywordRoute, int userId) async {
    try {
      emit(PostsStateLoading());
      final posts =
          await postService.getUserPostsFiltered(keywordRoute, userId);
      emit(PostsStateSuccess(posts!));
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
      emit(PostsStateError(
          "Erreur rencontrée pour supprimer votre publications. Veuillez réessayer."));
    }
  }

  Future<void> submitReport(int postId, String result) async {
    try {
      emit(PostsStateLoading());

      final postService = PostService();
      await postService.submitReport(postId, result);

      emit(ReportPostStateSuccess());
    } catch (error) {
      emit(PostsStateError(
          "Erreur rencontrée lors du signalement. Veuillez réessayer."));
    }
  }
}
