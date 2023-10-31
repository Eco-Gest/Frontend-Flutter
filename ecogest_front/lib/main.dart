import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/core/router.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('fr_FR', null).then((_) => runApp(MainApp()));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final AuthenticationCubit authenticationCubit = AuthenticationCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ThemeSettingsCubit>(
            create: (context) => ThemeSettingsCubit(),
          ),
          BlocProvider<AuthenticationCubit>(
            create: (context) => AuthenticationCubit()..getStatus(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
              return BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
                  builder: (context, state) {
                return MaterialApp.router(
                  title: "EcO'Gest",
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    // TODO improve dark theme
                    primarySwatch: EcogestTheme.primary,
                    textTheme: GoogleFonts.openSansTextTheme(),
                    brightness: state.brightness,
                  ),
                  routerConfig: AppRouter.getRouter(context),
                );
              });
            });
          },
        ));
  }
}
