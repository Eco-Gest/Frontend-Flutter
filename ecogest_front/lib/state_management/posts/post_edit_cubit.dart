// post_edit_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/services/post_service.dart';
import 'package:flutter/material.dart';

part 'post_edit_state.dart';

class PostEditCubit extends Cubit<PostEditState> {
  PostEditCubit() : super(PostEditStateInitial());

  Future<void> getPostDetails(int postId) async {
    try {
      emit(PostsEditStateLoading());
      final PostService postService = PostService();
      final post = await postService.getOnePost(postId);
      emit(PostEditStateLoaded(post));
    } catch (e) {
      emit(PostEditStateError("Erreur rencontrée pour récupérer la publication. Veuillez réessayer."));
    }
  }

  Future<void> updatePost(PostModel post) async {
    try {
      final updatedPost = await PostService.updatePost(post);
      emit(PostEditStateSuccess(updatedPost));
    } catch (e) {
      emit(PostEditStateError("Erreur rencontrée pour mettre à jours votre publication. Veuillez réessayer."));
    }
  }
}
