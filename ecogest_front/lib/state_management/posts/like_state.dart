class LikeState {
  final int likes;
  final bool isLiked;

  LikeState({
    required this.likes,
    required this.isLiked,
  });

  LikeState toggleLikeState() {
    return LikeState(
      likes: isLiked ? likes - 1 : likes + 1,
      isLiked: !isLiked,
    );
  }
}