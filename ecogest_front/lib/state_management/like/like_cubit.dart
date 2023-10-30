import 'package:ecogest_front/services/posts_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './like_state.dart';

class LikeCubit extends Cubit<LikeState> {
    LikeCubit() : super(StateLikeInitial());

  Future<void> toggleLike(int postId, bool isLiked) async {
    try {
      await PostsService.toggleLike(postId, isLiked);
        emit(StateLikeSuccess());
    } catch (error) {
      emit(PostsStateError(error.toString()));
    }
  }
}