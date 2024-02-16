import 'package:ecogest_front/services/post_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit() : super(StateLikeInitial());

  Future<void> toggleLike(int postId, bool isLiked) async {
    try {
      emit(StateLikeInitial());
      await PostService.toggleLike(postId, isLiked);
      if (!isLiked) {
        emit(StateLikeSuccess());
      } else {
        emit(StateUnlikeSuccess());
      }
    } catch (error) {
      emit(StateLikeError("Erreur rencontrée pour liker cette publication. Veuillez réessayer."));
    }
  }
}
