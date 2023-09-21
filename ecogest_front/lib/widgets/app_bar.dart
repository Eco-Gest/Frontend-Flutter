import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';


class ThemeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ThemeAppBar({
    super.key,
    required this.title,
  });

  final String title;

  static Size get prefSize => const Size.fromHeight(55.0);

  @override
  Size get preferredSize => prefSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title), 
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: () {
              if (Navigator.canPop(context)) {
              Navigator.pop(context); // Naviguer en arrière uniquement si c'est possible
            }
          },
        ),
      );
  }
}
