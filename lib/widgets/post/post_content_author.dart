import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/views/users/user_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ecogest_front/widgets/post/post_content_menu.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostContentAuthor extends StatelessWidget {
  const PostContentAuthor({
    Key? key,
    required this.author,
    this.position,
    this.date,
    required this.post,
  }) : super(key: key);

  final UserModel? author;
  final String? position;
  final String? date;
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    DateTime dateInFormat = DateTime.parse(date.toString());
    String publicationDate =
        DateFormat('dd/MM/yyyy', 'fr_FR').format(dateInFormat);

    final int postId = post.id!;

    return Container(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (author?.image != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(author!.image.toString()),
                  ),
                ),
              ] else ...[
                const Padding(
                  padding: EdgeInsets.only(right: 6.0),
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
              ],
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      if (author?.username != null) {
                        GoRouter.of(context)
                            .pushNamed(UserView.name, pathParameters: {
                          'id': author!.id.toString(),
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.only(bottom: 2.0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      author?.username.toString() ?? 'Utilisateur inconnu',
                    ),
                  ),
                  FilledButton.tonal(
                    onPressed: () {
                      // TODO : Afficher les différents badges
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      author?.badgeTitle ?? 'Badge',
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(publicationDate),
                  Text(() {
                    if (position != null) {
                      return position.toString();
                    } else if (author?.position != null) {
                      return author?.position.toString() ?? '';
                    } else {
                      return '';
                    }
                  }()),
                ],
              ),
              PostContentMenu(author: author, post: post),
            ],
          ),
        ],
      ),
    );
  }
}
