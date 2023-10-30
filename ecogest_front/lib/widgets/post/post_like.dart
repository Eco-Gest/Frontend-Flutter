import 'package:ecogest_front/state_management/posts/like_state.dart';
import 'package:flutter/material.dart';

class PostLike extends StatelessWidget {
  final LikeState likeState;
  final void Function(LikeState) onLikeStateChanged;

  const PostLike({
    Key? key,
    required this.likeState,
    required this.onLikeStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (likeState.likes == 1) ...[
          TextButton(
            onPressed: () {
              // TODO : Afficher les likes
            },
            child: Text(
              '${likeState.likes} like',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ] 
        else if (likeState.likes > 1) ...[
          TextButton(
            onPressed: () {
              // TODO : Afficher les likes
            },
            child: Text(
              '${likeState.likes} likes',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
        
        ElevatedButton(
          onPressed: () {
            final updatedLikeState = likeState.toggleLikeState();
            onLikeStateChanged(updatedLikeState);
          },
          child: Icon(
            likeState.isLiked ? Icons.thumb_up_rounded : Icons.thumb_up_alt_outlined,
          ),
        ),
      ],
    );
  }
}