import 'package:flutter/material.dart';


class ThemeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ThemeAppBar({
    super.key,
    required this.title,
    this.tabController,
    this.tabs,
  });

  final String title;
  final TabController? tabController;
  final List<Widget>? tabs; 

  static Size get prefSize => const Size.fromHeight(55.0);

  @override
  Size get preferredSize => prefSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      bottom: tabController != null && tabs != null ? TabBar(
        controller: tabController,
        tabs: tabs!,
      ) : null,
    );
  }
}



