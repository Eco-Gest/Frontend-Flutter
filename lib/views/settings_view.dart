import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:ecogest_front/views/legal/change_password_view.dart';
import 'package:ecogest_front/views/legal/legal_notices_view.dart';
import 'package:ecogest_front/views/legal/privacy_policy_view.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ecogest_front/views/auth/login_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static String name = 'settings';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAccountDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message), 
              duration: const Duration(seconds: 3), 
            ),
          );
        } else if (state is AuthenticationDeleteAccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message), 
              duration: const Duration(seconds: 3), 
            ),
          );
        }
      },
      child: Scaffold(
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
                              activeColor: lightColorScheme.primary,
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
                        GoRouter.of(context).pushNamed(LegalNoticesView.name);
                      },
                      child: const Text('Mentions légales')),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(PrivacyPolicyView.name);
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
                        const String email = 'contact@ecogest.org';

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
                  TextButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(ChangePasswordView.name);
                      },
                      child: const Text('Modifier mon mot de passe')),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextButton(
                    onPressed: () {
                      showDeleteAccountDialog(context);
                    },
                    child: const Text('Supprimer mon compte'),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width - 26) / 2,
                      height: 50.0,
                      child: FilledButton(
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
    ),
    );
  }
void showDeleteAccountDialog(BuildContext context) {
  final TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Etes-vous sûr.e ?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              'Vous serez déconnecté de tous vos appareils et perdrez l\'accès à votre compte.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Veuillez taper "Supprimer mon compte" pour confirmer.',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirmation',
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
        Container(
          height: 40, // Définissez une hauteur fixe pour la zone d'actions
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ajouter de l'espace entre les boutons
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                },
                child: const Text('Non'),
              ),
              TextButton(
                onPressed: () {
                  if (controller.text == 'Supprimer mon compte') {
                    context.read<AuthenticationCubit>().deleteMyAccount();
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Le texte ne correspond pas. Veuillez réessayer.',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Oui'),
              ),
            ],
          ),
        ),
      ],
      );
    },
  );
}
}