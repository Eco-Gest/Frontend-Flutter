import 'package:ecogest_front/core/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'assets/ecogest_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "EcO'Gest",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: EcogestTheme.primary,
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      routerConfig: AppRouter.getRouter(context),
    );
  }
}
