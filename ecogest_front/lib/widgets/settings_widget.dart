import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: const Text('Dark Mode'),
          trailing: BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
            builder: (context, state) {
              return Checkbox(
                  activeColor: EcogestTheme.primary,
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
    );
  }
}
