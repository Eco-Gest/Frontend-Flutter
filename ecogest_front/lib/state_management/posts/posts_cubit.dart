import 'package:ecogest_front/models/post_model.dart';
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
      emit(OnePostStateSuccess(post));
    } catch (error) {
      emit(PostsStateError(error.toString()));
    }
  }

  // Future<void> addLike(int postId) async {
  //   try {
  //     final isLiked = await PostService.addLike(postId);
  //     emit(PostStateliked(isLiked));
  //   } catch (error) {
  //     emit(PostsStateError(error.toString()));
  //   }
  // }
// Future<void> getLikeStatus(PostModel post,) async {
//     try {
//       bool isLiked = (PostService.likeCount(post) > 0);
Future<void> getLikeStatus(PostModel post, bool isLiked) async {
    try {
      if (isLiked) {
        emit(PostStateLiked(isLiked));
      } else {
        emit(PostStateUnliked(isLiked));
      }
    } catch (error) {
      emit(PostsStateError(error.toString()));
    }
  }

  Future<void> updateLike(int postId, bool isLiked) async {
    try {
      if (isLiked) {
        await PostService.removeLike(postId);
        emit(PostStateUnliked(isLiked));
      } else {
        await PostService.addLike(postId);
        emit(PostStateLiked(isLiked));
      }
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
