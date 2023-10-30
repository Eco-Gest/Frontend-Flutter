import 'package:ecogest_front/widgets/comment/comment_element.dart';
import 'package:flutter/material.dart';

const String commentOneContent = "Bravo la miss ! La planète te remercie ;)";
const String commentTwoContent = "Continue comme ça !";
const String commentThreeContent = "Vous savez, moi, je ne crois pas qu\'il y ait de bonne ou de mauvaise situation. Moi, si je devais résumer ma vie aujourd\'hui avec vous, je dirais que c\'est d\'abord des rencontres. Des gens qui m\'ont tendu la main, peut-être à un moment où je ne pouvais pas, où j\'étais seul chez-moi. Et c\'est assez curieux de se dire que les hasards, les rencontres forgent une destinée… Parce que quand on a le goût de la chose, quand on a le goût de la chose bien faite, le beau geste, parfois, on ne trouve pas l\'interlocuteur en face, je dirais, le miroir qui vous aide à avancer. Alors ça n\'est pas mon cas, comme je disais là, puisque moi au contraire, j\'ai pu : et je dis merci à la vie, je lui dis merci, je chante la vie, je danse la vie… Je ne suis qu\'amour ! Et finalement, quand beaucoup de gens, aujourd\'hui, me disent « Mais comment fais-tu pour avoir cette humanité ? » , et bien je leur réponds très simplement, je leur dis que c\'est ce goût de l\'amour ce goût donc qui m\'a poussé aujourd\'hui à entreprendre une construction mécanique, mais demain qui sait ? Peut-être simplement à me mettre au service de la communauté, à faire le don, le don de soi…";
const String commentFourContent = "On est tous avec toi ! Bisous, Andrée";
const String commentFiveContent = "Top";
const String commentSixContent = "J'apprécie grandement l'efficacité et la simplicité de ce nouvel outil de gestion de projet. Il facilite la collaboration en équipe, augmente la productivité et simplifie la gestion des tâches. Un atout incontournable pour tous les professionnels.";

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
  });

  static String name = 'comments-list';

  @override
  Widget build(BuildContext context) {
    List<String> comments = [
      commentOneContent,
      commentTwoContent,
      commentThreeContent,
      commentFourContent,
      commentFiveContent,
      commentSixContent,
    ];
    return Column(
      children: [
        // As the comments view is "inside" the home
        // (with a `push` rather than a `go` to reach
        // the view), we cannot use the ListView widget
        // which is already used in the parent.
        // We must loop over the different comments with a `for`.
        for (String comment in comments) ...[
          CommentElement(content: comment, author: "Max Hymôme"),
          const SizedBox(
            height: 15,
            width: 15,
          ),
        ],
      ],
    );
  }
}