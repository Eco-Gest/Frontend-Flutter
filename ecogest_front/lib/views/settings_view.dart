import 'package:ecogest_front/assets/color_schemes.g.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static String name = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Paramètres'),
      bottomNavigationBar: AppBarFooter(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Dark Mode'),
                    trailing:
                        BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
                      builder: (context, state) {
                        return Checkbox(
                            activeColor: lightColorScheme.primary,
                            value: state.isDarkMode,
                            onChanged: (value) {
                              context.read<ThemeSettingsCubit>().toggleTheme();
                            });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<AuthenticationCubit>().logout();
                    },
                    icon: const Icon(Icons.logout),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
