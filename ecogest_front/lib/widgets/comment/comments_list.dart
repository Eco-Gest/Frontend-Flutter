import 'package:ecogest_front/models/post_model.dart';
import 'package:ecogest_front/widgets/comment/comment_element.dart';
import 'package:flutter/material.dart';

const String commentOneAuthor = "Max Hymôme";
const String commentOneContent = "Bravo la miss ! La planète te remercie ;)";
const String commentOneIlmage = "https://images.pexels.com/photos/4307869/pexels-photo-4307869.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
const String commentTwoAuthor = "Sarah Fréchi";
const String commentTwoContent = "Continue comme ça !";
const String? commentTwoIlmage = null;
const String commentThreeAuthor = "Jean Rigole";
const String commentThreeContent = "Vous savez, moi, je ne crois pas qu\'il y ait de bonne ou de mauvaise situation. Moi, si je devais résumer ma vie aujourd\'hui avec vous, je dirais que c\'est d\'abord des rencontres. Des gens qui m\'ont tendu la main, peut-être à un moment où je ne pouvais pas, où j\'étais seul chez-moi. Et c\'est assez curieux de se dire que les hasards, les rencontres forgent une destinée… Parce que quand on a le goût de la chose, quand on a le goût de la chose bien faite, le beau geste, parfois, on ne trouve pas l\'interlocuteur en face, je dirais, le miroir qui vous aide à avancer. Alors ça n\'est pas mon cas, comme je disais là, puisque moi au contraire, j\'ai pu : et je dis merci à la vie, je lui dis merci, je chante la vie, je danse la vie… Je ne suis qu\'amour ! Et finalement, quand beaucoup de gens, aujourd\'hui, me disent « Mais comment fais-tu pour avoir cette humanité ? » , et bien je leur réponds très simplement, je leur dis que c\'est ce goût de l\'amour ce goût donc qui m\'a poussé aujourd\'hui à entreprendre une construction mécanique, mais demain qui sait ? Peut-être simplement à me mettre au service de la communauté, à faire le don, le don de soi…";
const String? commentThreeIlmage = null;

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
  });

  static String name = 'comments-list';

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CommentElement(content: commentOneContent, author: commentOneAuthor, image: commentOneIlmage),
        CommentElement(content: commentTwoContent, author: commentTwoAuthor, image: commentTwoIlmage),
        CommentElement(content: commentThreeContent, author: commentThreeAuthor, image: commentThreeIlmage),
      ],
    );
    
    // ListView.separated(
    //   padding: const EdgeInsets.all(16),
    //   separatorBuilder: (context, index) => const SizedBox(height: 16),
    //   itemCount: 3,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Container(
    //       decoration: BoxDecoration(
    //           border: Border.all(
    //         color: Colors.grey,
    //         width: 0.5,
    //       )),
    //       child: const Padding(
    //         padding: EdgeInsets.all(16.0),
    //         child: Column(
    //           children: [
    //             Text('Ceci est un commentaire à afficher'),
    //           ],
    //         ),
    //       )
    //     );
    //   }
    // );
  }
}


/*

final List commentsListForTest = [
  {
    "id": 1,
    "post_id": 2,
    "author_id": 5,
    "content": "Bravo la miss ! La planète te remercie ;)",
    "author": {
      "id": 5,
      "username": "Max Hymôme",
      "email": "maxhymome@gmail.com",
      "image": null,
      "birthdate": null,
      "biography": null,
      "position": null,
      "is_private": false,
      "badge_id": 4,
      "created_at": "2023-10-09T15:29:38.000000Z",
      "updated_at": "2023-10-13T10:43:41.000000Z"
    },
    "created_at": "2023-10-13T12:55:36.000000Z",
    "updated_at": "2023-10-13T12:55:36.000000Z"
  },
  {
    "id": 1,
    "post_id": 2,
    "author_id": 6,
    "content": "Continue comme ça !",
    "author": {
      "id": 6,
      "username": "Sarah Fréchi",
      "email": "sarahf@gmail.com",
      "image": null,
      "birthdate": null,
      "biography": null,
      "position": null,
      "is_private": false,
      "badge_id": 4,
      "created_at": "2023-10-09T15:29:38.000000Z",
      "updated_at": "2023-10-13T10:43:41.000000Z"
    },
    "created_at": "2023-10-13T12:55:36.000000Z",
    "updated_at": "2023-10-13T12:55:36.000000Z"
  },
  {
    "id": 1,
    "post_id": 2,
    "author_id": 7,
    "content": "On est tous avec toi ! Bisous, Andrée",
    "author": {
      "id": 7,
      "username": "Jean Rigole",
      "email": "jeanetandree@gmail.com",
      "image": null,
      "birthdate": null,
      "biography": null,
      "position": null,
      "is_private": false,
      "badge_id": 4,
      "created_at": "2023-10-09T15:29:38.000000Z",
      "updated_at": "2023-10-13T10:43:41.000000Z"
    },
    "created_at": "2023-10-13T12:55:36.000000Z",
    "updated_at": "2023-10-13T12:55:36.000000Z"
  },
  {
    "id": 1,
    "post_id": 2,
    "author_id": 8,
    "content": "Vous savez, moi, je ne crois pas qu\'il y ait de bonne ou de mauvaise situation. Moi, si je devais résumer ma vie aujourd\'hui avec vous, je dirais que c\'est d\'abord des rencontres. Des gens qui m\'ont tendu la main, peut-être à un moment où je ne pouvais pas, où j\'étais seul chez-moi. Et c\'est assez curieux de se dire que les hasards, les rencontres forgent une destinée… Parce que quand on a le goût de la chose, quand on a le goût de la chose bien faite, le beau geste, parfois, on ne trouve pas l\'interlocuteur en face, je dirais, le miroir qui vous aide à avancer. Alors ça n\'est pas mon cas, comme je disais là, puisque moi au contraire, j\'ai pu : et je dis merci à la vie, je lui dis merci, je chante la vie, je danse la vie… Je ne suis qu\'amour ! Et finalement, quand beaucoup de gens, aujourd\'hui, me disent « Mais comment fais-tu pour avoir cette humanité ? » , et bien je leur réponds très simplement, je leur dis que c\'est ce goût de l\'amour ce goût donc qui m\'a poussé aujourd\'hui à entreprendre une construction mécanique, mais demain qui sait ? Peut-être simplement à me mettre au service de la communauté, à faire le don, le don de soi…",
    "author": {
      "id": 8,
      "username": "Arétha Connerie",
      "email": "otis@gmail.com",
      "image": null,
      "birthdate": null,
      "biography": null,
      "position": null,
      "is_private": false,
      "badge_id": 4,
      "created_at": "2023-10-09T15:29:38.000000Z",
      "updated_at": "2023-10-13T10:43:41.000000Z"
    },
    "created_at": "2023-10-13T12:55:36.000000Z",
    "updated_at": "2023-10-13T12:55:36.000000Z"
  }
];

*/