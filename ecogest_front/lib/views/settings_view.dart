import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:ecogest_front/views/legal/legal_notices_view.dart';
import 'package:ecogest_front/views/legal/privacy_policy_view.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static String name = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Paramètres'),
      bottomNavigationBar: const AppBarFooter(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      const Text('Thème'),
                      BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
                          builder: (context, state) {
                        // ’.adaptive’ allow to adapt switch according to platform (Android / iOS)
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.light_mode,
                              size: 30.0,
                              semanticLabel: 'Mode clair',
                            ),
                            Switch.adaptive(
                              // This bool value toggles the switch.
                              value: state.isDarkMode,
                              activeColor: EcogestTheme.primary,
                              onChanged: (bool value) {
                                // This is called when the user toggles the switch.
                                context
                                    .read<ThemeSettingsCubit>()
                                    .toggleTheme();
                              },
                            ),
                            const Icon(
                              Icons.dark_mode,
                              size: 20.0,
                              semanticLabel: 'Mode sombre',
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(LegalNotices.name);
                      },
                      child: const Text('Mentions légales')),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(PrivacyPolicy.name);
                      },
                      child: const Text('Politique de confidentialité')),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextButton(
                      onPressed: () async {
                        // Launch email application
                        const String subject =
                            'Demande de modification de mes données personnelles';
                        const String body =
                            'Je souhaite modifier mes informations personnelles dans votre base de données.';
                        const String email = 'tigrou-dpo@ecogest.dev';

                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: email,
                          queryParameters: {
                            // temporary fix for + replacing spaces
                            'subject': subject.replaceAll(' ', '_'),
                            'body': body.replaceAll(' ', '_'),
                          },
                        );
                        try {
                          await launchUrl(emailLaunchUri);
                        } catch (e) {
                          throw Exception("Demande non éffectué");
                        }
                      },
                      child: const Text('Modifier mes données personnelles')),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width - 26) / 2,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthenticationCubit>().logout();
                        },
                        child: const Text('Se déconnecter'),
                      )),
                  // ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
