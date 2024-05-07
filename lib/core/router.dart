import 'dart:async';

import 'package:ecogest_front/models/trophy_model.dart';
import 'package:ecogest_front/models/user_model.dart';
import 'package:ecogest_front/views/posts/challenges_view.dart';
import 'package:ecogest_front/views/comments_view.dart';
import 'package:ecogest_front/views/legal/legal_notices_view.dart';
import 'package:ecogest_front/views/legal/privacy_policy_view.dart';
import 'package:ecogest_front/views/notifications_view.dart';
import 'package:ecogest_front/views/errors/error404_view.dart';
import 'package:ecogest_front/views/posts/post_detail_view.dart';
import 'package:ecogest_front/views/users/account_view.dart';
import 'package:ecogest_front/views/settings_view.dart';
import 'package:ecogest_front/views/users/trophies_view.dart';
import 'package:ecogest_front/views/users/user_view.dart';
import 'package:ecogest_front/views/search_view.dart';
import 'package:ecogest_front/views/users/subscriptions_list_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/views/auth/register_view.dart';
import 'package:ecogest_front/views/auth/login_view.dart';
import 'package:ecogest_front/views/home_view.dart';
import 'package:ecogest_front/views/posts/post_create_view.dart';
import 'package:ecogest_front/views/posts/post_edit_view.dart';

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
      errorBuilder: (context, state) => const Error404View(),
      routes: [
        GoRoute(
          path: '/login',
          name: LoginView.name,
          builder: (context, state) => LoginView(),
        ),
        GoRoute(
          path: '/register',
          name: RegisterView.name,
          builder: (context, state) => RegisterView(),
        ),
        GoRoute(
          path: '/home',
          name: HomeView.name,
          builder: (context, state) => HomeView(),
        ),
        GoRoute(
          path: '/posts/:id',
          name: PostDetailView.name,
          builder: (context, state) => PostDetailView(
            postId: int.parse(state.pathParameters['id'].toString()),
          ),
        ),
        GoRoute(
          path: '/posts/:id/edit',
          name: PostEditView.name,
          builder: (context, state) => PostEditView(
            postId: int.parse(state.pathParameters['id'].toString()),
          ),
        ),
        GoRoute(
          path: '/account',
          name: AccountView.name,
          builder: (context, state) => const AccountView(),
        ),
        GoRoute(
          path: '/search',
          name: SearchView.name,
          builder: (context, state) => SearchView(),
        ),
        GoRoute(
          path: '/post-create',
          name: PostCreateView.name,
          builder: (context, state) => PostCreateView(),
        ),
        GoRoute(
          path: '/challenge',
          name: ChallengesView.name,
          builder: (context, state) => const ChallengesView(),
        ),
        GoRoute(
            path: '/posts/:id/comments',
            name: CommentsView.name,
            builder: (context, state) {
              final comments = state.extra! as List;
              return CommentsView(
                commentsList: comments,
                postId: int.parse(state.pathParameters['id'].toString()),
              );
            }),
        GoRoute(
          path: '/settings',
          name: SettingsView.name,
          builder: (context, state) => const SettingsView(),
        ),
        GoRoute(
          path: '/users/:id',
          name: UserView.name,
          builder: (context, state) => UserView(
            userId: int.parse(state.pathParameters['id'].toString()),
          ),
        ),
        GoRoute(
          path: '/notifications',
          name: NotificationsView.name,
          builder: (context, state) => NotificationsView(),
        ),
        GoRoute(
          path: '/legal-notices',
          name: LegalNotices.name,
          builder: (context, state) => const LegalNotices(),
        ),
        GoRoute(
          path: '/privacy-policy',
          name: PrivacyPolicy.name,
          builder: (context, state) => const PrivacyPolicy(),
        ),
        GoRoute(
          path: '/user/follow',
          name: SubscriptionsListView.name,
          builder: (context, state) => SubscriptionsListView(
            user:state.extra! as UserModel
          ),
        ),
        GoRoute(
          path: '/trophies',
          name: TrophiesView.name,
          builder: (context, state) => TrophiesView(
            trophies: state.extra! as List<TrophyModel>
          ),
        ),
      ],
      refreshListenable: GoRouterRefreshStream(stream),
      redirect: (context, state) {
        // If the user is not authenticated, redirect to the login page.
        final status = context.read<AuthenticationCubit>().state;

        // If the user is authenticated, redirect to the home page (only if
        // the current location is public page)
        if (publicRoutes.contains(state.uri.toString()) &&
            status is AuthenticationAuthenticated) {
          return '/home';
        }
        // If the user is not authenticated, redirect to the login page.
        // (only if the current location is not a public page).
        if (!publicRoutes.contains(state.uri.toString()) &&
            status is AuthenticationUnauthenticated) {
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
