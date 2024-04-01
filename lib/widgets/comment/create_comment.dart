import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/comments/comment_cubit.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';

class CreateComment extends StatelessWidget {
  CreateComment({super.key, required this.postId});

  int postId;
  final _newCommentController = TextEditingController();
  bool isCliked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.read<ThemeSettingsCubit>().state.isDarkMode
          ? darkColorScheme.primary
          : lightColorScheme.primary,
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _newCommentController,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.read<ThemeSettingsCubit>().state.isDarkMode
                ? Colors.black
                : Colors.white,
          suffixIcon: IconButton(
            color: context.read<ThemeSettingsCubit>().state.isDarkMode
                ? darkColorScheme.primary
                : lightColorScheme.primary,
            onPressed: () {
              if (!isCliked) {
                context.read<CommentCubit>().createComment(
                      postId: postId,
                      content: _newCommentController.text,
                    );
                isCliked = true;
              }
            },
            icon: const Icon(Icons.send),
          ),
          hintText: 'Rédiger un commentaire...',
        ),
      ),
    );
  }
}
