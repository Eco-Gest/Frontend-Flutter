import 'package:ecogest_front/state_management/like/like_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/color_schemes.g.dart';

class LikeWidget extends StatefulWidget {
  LikeWidget({
    super.key,
    required this.isLiked,
    required this.postId,
  });
  int postId;
  bool isLiked;

  @override
  _LikeWidget createState() => _LikeWidget();
}

class _LikeWidget extends State<LikeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<LikeCubit, LikeState>(builder: (context, state) {
        if (state is StateLikeSuccess) {
          return IconButton(
            onPressed: () {
              context
                  .read<LikeCubit>()
                  .toggleLike(widget.postId, widget.isLiked);
            },
            color: lightColorScheme.primary,
            icon: Icon(widget.isLiked
                ? Icons.thumb_up_alt_rounded
                : Icons.thumb_up_alt_outlined),
          );
        }
        if (state is StateUnlikeSuccess) {
          return IconButton(
            onPressed: () {
              context
                  .read<LikeCubit>()
                  .toggleLike(widget.postId, widget.isLiked);
            },
            color: lightColorScheme.primary,
            icon: Icon(widget.isLiked
                ? Icons.thumb_up_alt_rounded
                : Icons.thumb_up_alt_outlined),
          );
        }
        return IconButton(
          onPressed: () {
            context.read<LikeCubit>().toggleLike(widget.postId, widget.isLiked);
          },
          color: lightColorScheme.primary,
          icon: Icon(widget.isLiked
              ? Icons.thumb_up_alt_rounded
              : Icons.thumb_up_alt_outlined),
        );
      }),
    ]);
  }
}
