import 'dart:async';

import 'package:ecogest_front/services/notifications/local_notification_service.dart';
import 'package:ecogest_front/services/notifications/notifications_service.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:ecogest_front/views/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/core/router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:notification_permissions/notification_permissions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await FlutterConfig.loadEnvVariables();
  unawaited(MobileAds.instance.initialize());

  initializeDateFormatting('fr_FR', null).then((_) => runApp(MainApp()));
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  final AuthenticationCubit authenticationCubit = AuthenticationCubit();

  final NotificationsService notificationsService = NotificationsService();

  late Future<String?> permissionStatusFuture;

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";

  /// Checks the notification permission status
  Future<String?> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return null;
      }
    });
  }

  @override
  void initState() {
    listenToNotification();
    permissionStatusFuture = getCheckNotificationPermStatus();
    super.initState();
  }

  Widget build(BuildContext context) {
    final GoRouter router = AppRouter.routerWithAuthStream(
      authenticationCubit.stream,
    );
    return MultiBlocProvider(
        providers: [
          BlocProvider<ThemeSettingsCubit>(
            create: (context) => ThemeSettingsCubit(),
          ),
          BlocProvider.value(value: authenticationCubit),
        ],
        child: Builder(
          builder: (context) {
            return BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
              return BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
                  builder: (context, state) {
                return MaterialApp.router(
                  title: "Ecogest",
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      useMaterial3: true, colorScheme: lightColorScheme),
                  darkTheme: ThemeData(
                      useMaterial3: true, colorScheme: darkColorScheme),
                  themeMode: state.themeMode,
                  routerConfig: router,
                );
              });
            });
          },
        ));
  }

  void listenToNotification() => notificationsService
      .localNotificationService.selectNotificationStream.stream
      .listen(onNotificationListener);

  void onNotificationListener(String? payload) {
    GoRouter.of(context).push(NotificationsView.name);
  }
}
