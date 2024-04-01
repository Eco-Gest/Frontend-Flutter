import 'package:ecogest_front/views/home_view.dart';
import 'package:ecogest_front/views/notifications_view.dart';
import 'package:ecogest_front/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';

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

  static Size get prefSize => const Size.fromHeight(60.0);

  String _getCurrentRoute(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }

  @override
  Size get preferredSize => prefSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: context.read<ThemeSettingsCubit>().state.isDarkMode
          ? darkColorScheme.surface
          : lightColorScheme.surface,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      actions: [
        IconButton(
          icon: (_getCurrentRoute(context) == "/${HomeView.name}"
              ? const Icon(Icons.notifications)
              : const Icon(Icons.settings)),
          onPressed: () {
            if (_getCurrentRoute(context) == "/${HomeView.name}") {
              GoRouter.of(context).pushNamed(NotificationsView.name);
            } else {
              GoRouter.of(context).pushNamed(SettingsView.name);
            }
          },
        ),
      ],
      bottom: tabController != null && tabs != null
          ? TabBar(
              controller: tabController,
              tabs: tabs!,
            )
          : null,
    );
  }
}
