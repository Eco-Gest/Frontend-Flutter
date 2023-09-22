import 'dart:async';

import 'package:ecogest_front/views/account_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/views/register_view.dart';
import 'package:ecogest_front/views/login_view.dart';
import 'package:ecogest_front/views/home_view.dart';
import '../views/account_view.dart';

abstract class AppRouter {
  /// Public routes
  static List<String> get publicRoutes => [
        '/login',
        '/register',
      ];

  /// Creates a [GoRouter] with a [GoRouterRefreshStream] that listens to the
  /// [AuthenticationCubit] stream.
  static GoRouter routerWithAuthStream(Stream<AuthenticationState> stream) {
    return GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          name: LoginView.name,
          builder: (context, state) => LoginView(),
        ),
        GoRoute(
          path: '/register',
          name: RegisterView.name,
          builder: (context, state) => const RegisterView(),
        ),
        GoRoute(
          path: '/home',
          name: HomeView.name,
          builder: (context, state) => const HomeView(),
        ),
        GoRoute(
          path: '/account',
          name: AccountView.name,
          builder: (context, state) => const AccountView(),
        ),
      ],
      refreshListenable: GoRouterRefreshStream(stream),
      redirect: (context, state) {
        // If the user is not authenticated, redirect to the login page.
        final authState = context.read<AuthenticationCubit>().state;

        if (authState is AuthenticationAuthenticated) {
          if (!publicRoutes.contains(state.uri.toString())) {
            return null;
          }

          // If the user is authenticated, redirect to the home page (only if
          // the current location is public page).
          return '/home';
        }

        if (authState is AuthenticationUnauthenticated) {
          // If the user is not authenticated, only allow to access the public routes
          if (publicRoutes.contains(state.uri.toString())) {
            return null;
          }


          // If the user is not authenticated, redirect to the login page.
          // (only if the current location is not a public page).
          return '/login';
        }

        return null;
      },
    );
  }
}

/// A [ChangeNotifier] that listens to a [Stream] and notifies listeners when
/// the stream emits an event.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
