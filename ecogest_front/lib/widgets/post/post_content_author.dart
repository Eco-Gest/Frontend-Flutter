import 'package:flutter/material.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:ecogest_front/widgets/post/post_content_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostContentAuthor extends StatelessWidget {
  const PostContentAuthor({
    Key? key,
    required this.author,
    this.position,
    this.date,
    this.postId,
  }) : super(key: key);

  final UserModel? author;
  final String? position;
  final String? date;
  final int? postId;
  final int? postId;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationCubit>().state.user;

    DateTime dateInFormat = DateTime.parse(date.toString());
    String publicationDate = DateFormat('dd/MM/yyyy', 'fr_FR').format(dateInFormat);

    final int postId = this.postId ?? 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
                Text(
                    publicationDate
                  ),
                  if (date != null && (position != null || author!.position != null)) ...[
                    const Text(' | '),
                  ],
                PostContentMenu(author:author, postId:postId),
                          
            Text(() {
              if (position != null) {
                return position.toString();
              } else if (author!.position != null) {
                return author!.position.toString();
              } else {
                return '';
              }
            } ()
              // 'Rennes, France'
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                if (author!.image != null) ...[
                  CircleAvatar(
                    backgroundImage: NetworkImage(author!.image.toString()),
                  )
                ] else ...[
                  const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ],
                const SizedBox(
                  height: 10,
                  width: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(author?.username.toString() ?? 'Username'),
                        const SizedBox(
                          height: 10,
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            // TODO : Afficher les différents badges
                          },
                          child: Text(
                            author?.badgeTitle ?? 'Badge',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
