import 'package:ecogest_front/services/notifications/local_notification_service.dart';
import 'package:ecogest_front/services/notifications/notifications_service.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:ecogest_front/views/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/core/router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:notification_permissions/notification_permissions.dart' as notification_permissions;
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'package:intl/intl.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initializeDateFormatting('fr_FR', null);
  runApp(MainApp());
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
    return notification_permissions.NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case notification_permissions.PermissionStatus.denied:
          return permDenied;
        case notification_permissions.PermissionStatus.granted:
          return permGranted;
        case notification_permissions.PermissionStatus.unknown:
          return permUnknown;
        case notification_permissions.PermissionStatus.provisional:
          return permProvisional;
        default:
          return null;
      }
    });
  }

  @override
  void initState() {
    requestPermissions();
    listenToNotification();
    permissionStatusFuture = getCheckNotificationPermStatus();
    super.initState();
  }


  Future<void> requestPermissions() async {
    var status = await permission_handler.Permission.storage.status;
    if (!status.isGranted) {
      await permission_handler.Permission.storage.request();
    }
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
                  localizationsDelegates: [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: [
                      const Locale('fr', 'FR'),
                    ],
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
