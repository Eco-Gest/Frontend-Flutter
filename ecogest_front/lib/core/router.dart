import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/login_view.dart';

abstract class AppRouter {

  static GoRouter getRouter(BuildContext context) => GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: LoginView.name,
        builder: (context, state) => LoginView(),
      ),
    ]
  );
}