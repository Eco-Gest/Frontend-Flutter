import 'package:ecogest_front/assets/ecogest_theme.dart';
import 'package:ecogest_front/widgets/legal_title_widget.dart';
import 'package:ecogest_front/widgets/post/post_separator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecogest_front/state_management/theme_settings/theme_settings_cubit.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  static String name = 'privacy-policy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ThemeAppBar(title: 'Politique de confidentialité'),
        bottomNavigationBar: const AppBarFooter(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Dernière mise à jour : 22 juin 2024'),
              const PostSeparator(),
              const Text(
                  'Bienvenue sur l\'application Ecogest de Ecogest (ci-après "nous", "notre" ou "l\'entreprise"). Chez Ecogest, nous accordons une grande importance à la protection de la vie privée de nos utilisateurs. Cette politique de confidentialité a pour but de vous informer sur la manière dont nous collectons, utilisons, partageons et protégeons vos informations personnelles. En utilisant notre site web ou notre application mobile, vous acceptez les conditions de cette politique de confidentialité.'),
              const PostSeparator(),
              const Column(children: [
                LegalTitle(
                    textContent: 'Collecte d\'informations personnelles :'),
                Text(
                    'Nous pouvons collecter les types d\'informations personnelles suivants lorsque vous interagissez avec notre site web ou notre application :'),
                SizedBox(
                  height: 10,
                ),
                // ’\u2022’ is the code for a bullet
                Text(
                    '\u2022 Informations d\'identification, telles que votre pseudo, adresse e-mail, photo de profil, etc.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '\u2022 Informations de connexion, telles que les données de connexion, les adresses IP et les balises Web.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '\u2022 Informations sur votre utilisation de nos services.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '\u2022 Autres informations que vous choisissez de nous fournir, telles que des commentaires, des évaluations, des préférences, etc.'),
              ]),
              const PostSeparator(),
              const Column(children: [
                LegalTitle(
                    textContent: 'Utilisation des informations personnelles :'),
                Text(
                    'Nous utilisons les informations personnelles que nous collectons à des fins diverses, notamment :'),
                SizedBox(
                  height: 10,
                ),
                Text('\u2022 Fournir, exploiter et améliorer nos services.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '\u2022 Communiquer avec vous, notamment pour répondre à vos questions, demandes de service ou commentaires.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '\u2022 Vous informer des mises à jour, promotions et offres spéciales de notre entreprise, sauf si vous choisissez de ne pas recevoir de telles communications.'),
              ]),
              const PostSeparator(),
              const Column(children: [
                LegalTitle(
                    textContent: 'Partage des informations personnelles :'),
                Text(
                    'Nous ne partageons pas vos informations personnelles avec des tiers, sauf dans les cas suivants :'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '\u2022 Pour se conformer aux lois et réglementations en vigueur, ou pour protéger nos droits, notre vie privée, notre sécurité ou notre propriété, ainsi que ceux de nos utilisateurs ou du public.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '\u2022 En cas de fusion, d\'acquisition ou de vente de tout ou partie de nos actifs, vos informations personnelles peuvent être transférées à une autre entité.'),
              ]),
              const PostSeparator(),
              const Column(children: [
                LegalTitle(textContent: 'Sécurité des informations :'),
                Text(
                    'Nous mettons en place des mesures de sécurité appropriées pour protéger vos informations personnelles contre tout accès non autorisé, toute divulgation, altération ou destruction. Cependant, aucune méthode de transmission sur Internet ni de stockage électronique n\'est 100 % sécurisée.'),
              ]),
              const PostSeparator(),
              Column(children: [
              LegalTitle(textContent: 'Vos choix :'),
              RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Vous disposez d\'un droit d\'accès, de rectification, d\’effacement, de limitation du traitement, de portabilité et d\’opposition à vos données personnelles. Pour exercer ces droits, veuillez nous contacter à l\'adresse email suivante : ',
                      style: TextStyle(
                          color: context
                                  .read<ThemeSettingsCubit>()
                                  .state
                                  .isDarkMode
                              ? darkColorScheme.onSurfaceVariant
                              : lightColorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextSpan(
                        text: 'contact@egogest.org',
                        style: TextStyle(
                          color: context
                                  .read<ThemeSettingsCubit>()
                                  .state
                                  .isDarkMode
                              ? darkColorScheme.primary
                              : lightColorScheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            // Launch email application
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: 'contact@egogest.org',
                            );
                            try {
                              await launchUrl(emailLaunchUri);
                            } catch (e) {
                              throw Exception("Contact non éffectué");
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ]),
              const PostSeparator(),
              const Column(children: [
                LegalTitle(
                    textContent:
                        'Modifications de la politique de confidentialité :'),
                Text(
                    'Nous nous réservons le droit de modifier cette politique de confidentialité à tout moment. La date de la dernière mise à jour sera toujours indiquée en haut du document. Les modifications seront effectives dès leur publication sur notre site web ou notre application.'),
              ]),
              const PostSeparator(),
              Column(children: [
                const LegalTitle(textContent: 'Nous contacter :'),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Si vous avez des questions, des commentaires ou des préoccupations concernant cette politique de confidentialité, veuillez nous contacter à l\'adresse suivante : ',
                      style: TextStyle(
                          color: context
                                  .read<ThemeSettingsCubit>()
                                  .state
                                  .isDarkMode
                              ? darkColorScheme.onSurfaceVariant
                              : lightColorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextSpan(
                        text: 'contact@egogest.org',
                        style: TextStyle(
                          color: context
                                  .read<ThemeSettingsCubit>()
                                  .state
                                  .isDarkMode
                              ? darkColorScheme.primary
                              : lightColorScheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            // Launch email application
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: 'contact@egogest.org',
                            );
                            try {
                              await launchUrl(emailLaunchUri);
                            } catch (e) {
                              throw Exception("Contact non éffectué");
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ])
            ],
          ),
        )));
  }
}
