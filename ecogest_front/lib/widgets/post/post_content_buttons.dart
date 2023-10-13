import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/state_management/posts/posts_cubit.dart';
import 'package:ecogest_front/state_management/posts/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostContentButtons extends StatelessWidget {
  PostContentButtons({
    super.key,
    required this.isChallenge,
    this.likes,
    required this.isLiked,
    required this.post,
    this.comments,
  });

  final PostModel post;
  final bool? isChallenge;
  final int? likes;
  final List? comments;
  bool isLiked;
  final cubit = PostsCubit();
  

  handleLikePost() {
    if ( isLiked ) {
      cubit.removeLike(post.id!);
    } else {
      cubit.addLike(post.id!);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (likes == 1) ...[
              TextButton(
                onPressed: () {
                  // TODO : Afficher les likes
                },
                child: Text(
                  '$likes like',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
            if (likes! > 1) ...[
              TextButton(
                onPressed: () {
                  // TODO : Afficher les likes
                },
                child: Text(
                  '$likes likes',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
            if (likes! > 0 && comments!.isNotEmpty) ...[
              const Text(' | '),
            ],
            if (comments!.isNotEmpty) ...[
              TextButton(
                  onPressed: () {
                    // TODO: Afficher les commentaires
                  },
                  child: Text(
                    '${comments!.length} commentaires',
                    style: const TextStyle(color: Colors.black),
                  )),
            ]
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocProvider<PostsCubit>(
              create: (context) {
                final cubit = PostsCubit();
                cubit.getLikeStatus(post, isLiked);
                debugPrint(isLiked.toString());
                return cubit;
              },
              child: BlocBuilder<PostsCubit, PostsState>(
                builder: (context, state) {
                  if (state is PostStateLiked) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () {
                        isLiked = !isLiked;
                        debugPrint('Click pour supprimer le like');
                        context.read<PostsCubit>().updateLike(post.id!, isLiked);
                        debugPrint('suppr like : $isLiked');
                      },
                      child: const Icon(
                        Icons.thumb_up_rounded                          
                      ),
                    );
                  } else if (state is PostStateUnliked) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () {
                        debugPrint('Click pour liker');
                        context.read<PostsCubit>().updateLike(post.id!, isLiked);
                      },
                      child: const Icon(
                        Icons.thumb_up_alt_outlined,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                debugPrint('Click pour commenter la publication');
                // TODO : Commenter la publication
              },
              child: const Icon(Icons.comment),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                debugPrint('Click pour partager la publication');
                // TODO : Partager la publication
              },
              child: const Icon(Icons.share),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (isChallenge!) ...[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(30),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () {
              debugPrint('Click pour rejoindre le défi');
              // TODO : Rejoindre le défi
            },
            child: const Text('Participer au défi'),
          ),
        ]
      ],
    );
  }
}
