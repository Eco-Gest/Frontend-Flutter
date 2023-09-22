import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/core/router.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final AuthenticationCubit authenticationCubit = AuthenticationCubit();

  @override
  Widget build(BuildContext context) {
    final GoRouter router = AppRouter.routerWithAuthStream(
      authenticationCubit.stream,
    );
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authenticationCubit),
        ],
        child: Builder(
          builder: (context) {
            return BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
              return MaterialApp.router(
                title: "EcO'Gest",
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: EcogestTheme.primary,
                  textTheme: GoogleFonts.openSansTextTheme(),
                ),
                routerConfig: router,
              );
            });
          },
        ));
  }
}
