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
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('fr_FR', null);
  if (!kIsWeb) {
    await PusherBeams.instance.start(dotenv.env['PUSHER_BEAMS_ID'].toString());
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

  @override
  void initState() {
    super.initState();
    requestPermissions();
    listenToNotification();
  }

  Future<void> requestPermissions() async {
    final permissionStorageStatus = await Permission.storage.status;
    if (!permissionStorageStatus.isGranted) {
      await Permission.storage.request();
    }
    final notificationPermissionStatus = await Permission.notification.status;
    if (!notificationPermissionStatus.isGranted) {
      await Permission.notification.request();
    }
  }

  /// Check if app is opened by click on a push notification
  Future<void> checkForInitialMessage() async {
    final message = await PusherBeams.instance.getInitialMessage();

    if (message != null) {
      Future.delayed(Duration.zero, () {
        GoRouter.of(context).push(NotificationsView.name);
      });
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
}
