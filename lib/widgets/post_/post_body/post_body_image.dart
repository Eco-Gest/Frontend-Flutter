import 'package:ecogest_front/models/user_post_participation_model.dart';
import 'package:ecogest_front/views/users/user_view.dart';
import 'package:ecogest_front/widgets/post/category_icon_widget.dart';
import 'package:ecogest_front/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:go_router/go_router.dart';

// PostBodyImage is a widget inside PostBody that
// displays the image of the post if it exists

class PostBodyImage extends StatelessWidget {
  final String? imageUrl;

  const PostBodyImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(imageUrl!, fit: BoxFit.cover)
        : SizedBox.shrink();
  }
}
