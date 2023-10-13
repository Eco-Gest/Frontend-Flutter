import 'package:ecogest_front/services/post_service.dart';
import 'package:ecogest_front/services/user_service.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsStateLoading());

  Future<void> getPosts(int pageNbr) async {
    try {
      emit(PostsStateLoading());
      final posts = await PostService.getPosts(pageNbr);
      emit(PostsStateSuccess(posts));
    } catch (error) {
      emit(PostsStateError(error.toString()));
    }
  }

  Future<void> getOnePost(int postId) async {
    try {
      emit(PostsStateLoading());
      final post = await PostService.getOnePost(postId);
      final likeCount = await PostService.likeCount(post);
      final user = await UserService.getCurrentUser();
      final isLiked = await PostService.userLikedPost(post, user.id);
      emit(OnePostStateSuccess(post, isLiked, likeCount));
    } catch (error) {
      emit(PostsStateError(error.toString()));
    }
  }

  Future<void> addLike(int postId) async {
    try {
      final isLiked = await PostService.addLike(postId);
      emit(PostStateliked(isLiked));
    } catch (error) {
      emit(PostsStateError(error.toString()));
    }
  }

  Future<void> removeLike(int postId) async {
    try {
      final isLiked = await PostService.removeLike(postId);
      emit(PostStateliked(isLiked));
    } catch (error) {
      emit(PostsStateError(error.toString()));
    }
  }

  Future<void> getUserPostsFiltered(String backendRoute) async {
    try {
      emit(PostsStateLoading());
      final posts = await PostService.getUserPostsFiltered(backendRoute);
      emit(PostsStateSuccess(posts));
    } catch (error) {
      emit(PostsStateError(error.toString()));
    }
  }
}
