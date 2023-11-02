import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/state_management/like/like_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/widgets/post/post_content_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostContentButtonsWrapper extends StatelessWidget {
  PostContentButtonsWrapper({
    super.key,
    required this.isChallenge,
    this.likes,
    required this.isLiked,
    required this.post,
    this.comments,
  });

  final PostModel post;
  final bool? isChallenge;
  int? likes;
  final List? comments;
  bool isLiked;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LikeCubit>(
          create: (context) => LikeCubit(),
        ),
        //Commentaire :
        //    BlocProvider<Commentaire>(
        //   create: (context) => ThemeSettingsCubit(),
        // ),
      ],
      child: Builder(builder: (context) {
        return BlocBuilder<LikeCubit, LikeState>(builder: (context, state) {
          if (state is StateUnlikeSuccess) {
            likes = likes! - 1;
            isLiked = !isLiked;
            return PostContentButtons(
              post: post,
              likes: likes,
              isLiked: isLiked,
              comments: comments,
              isChallenge: isChallenge,
            );
          } else if (state is StateLikeSuccess) {
            likes = likes! + 1;
            isLiked = !isLiked;
            return PostContentButtons(
              post: post,
              likes: likes,
              isLiked: isLiked,
              comments: comments,
              isChallenge: isChallenge,
            );
          } else if (state is StateLikeInitial) {
            return PostContentButtons(
              post: post,
              likes: likes,
              isLiked: isLiked,
              comments: comments,
              isChallenge: isChallenge,
            );
          }
          return PostContentButtons(
            post: post,
            likes: likes,
            isLiked: isLiked,
            comments: comments,
            isChallenge: isChallenge,
          );
        });
      }),
    );
  }
}
