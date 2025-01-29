import 'package:ecogest_front/services/notifications/notifications_service.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:ecogest_front/views/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import 'assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/core/router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notification_permissions/notification_permissions.dart'
    as notification_permissions;
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initializeDateFormatting('fr_FR', null);
   debugPrint('PUSHER_BEAMS_ID: ${dotenv.env['PUSHER_BEAMS_ID'].toString()}');
   if (!kIsWeb) {
    await PusherBeams.instance.start(dotenv.env['PUSHER_BEAMS_ID'].toString());
   await PusherBeams.instance.addDeviceInterest("debug-hello");
   }
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AuthenticationCubit authenticationCubit = AuthenticationCubit();
  final NotificationsService notificationsService = NotificationsService();
  late Future<String?> permissionStatusFuture;

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";

  /// Checks the notification permission status
  Future<String?> getCheckNotificationPermStatus() {
    return notification_permissions.NotificationPermissions
        .getNotificationPermissionStatus()
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
    super.initState();
    requestPermissions();
    listenToNotification();
    permissionStatusFuture = getCheckNotificationPermStatus();
    initPusherBeams();
  }

  Future<void> requestPermissions() async {
    final status = await permission_handler.Permission.storage.status;
    if (!status.isGranted) {
      await permission_handler.Permission.storage.request();
    }
  }

  @override
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
                builder: (context, themeState) {
                  return MaterialApp.router(
                    title: 'Ecogest',
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                      useMaterial3: true,
                      colorScheme: lightColorScheme,
                    ),
                    darkTheme: ThemeData(
                      useMaterial3: true,
                      colorScheme: darkColorScheme,
                    ),
                    themeMode: themeState.themeMode,
                    routerConfig: router,
                    localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('fr', 'FR'),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void listenToNotification() => notificationsService
      .localNotificationService.selectNotificationStream.stream
      .listen(onNotificationListener);

  void onNotificationListener(String? payload) {
    GoRouter.of(context).push(NotificationsView.name);
  }

    initPusherBeams() async {
    // Let's see our current interests
    print(await PusherBeams.instance.getDeviceInterests());

    // This is not intented to use in web
    if (!kIsWeb) {
      await PusherBeams.instance
          .onInterestChanges((interests) => {print('Interests: $interests')});

      await PusherBeams.instance
          .onMessageReceivedInTheForeground(_onMessageReceivedInTheForeground);
    }
    await _checkForInitialMessage();
  }

    Future<void> _checkForInitialMessage() async {
    final initialMessage = await PusherBeams.instance.getInitialMessage();
    if (initialMessage != null) {
      _showAlert('Initial Message Is:', initialMessage.toString());
    }
  }

  void _onMessageReceivedInTheForeground(Map<Object?, Object?> data) {
    _showAlert(data["title"].toString(), data["body"].toString());
  }

   void _showAlert(String title, String message) {
    AlertDialog alert = AlertDialog(
        title: Text(title), content: Text(message), actions: const []);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
