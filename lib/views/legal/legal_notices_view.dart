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

class LegalNotices extends StatelessWidget {
  const LegalNotices({Key? key});

  static String name = 'legal-notices';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ThemeAppBar(title: 'Mentions Légales'),
        bottomNavigationBar: const AppBarFooter(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Editeur
              Column(children: [
                const LegalTitle(textContent: 'Éditeur du site :'),
                const Text('Société EcO\'Gest'),
                const Text('2 Rue George Sand, 36120 Ardentes'),
                const Text('Téléphone : 01.23.45.67.89'),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'E-mail : ',
                      ),
                      TextSpan(
                        text: 'report@ecogest.dev',
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
                              path: 'report@ecogest.io',
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
              // Directeur
              const Column(children: [
                LegalTitle(textContent: 'Directeur de la publication :'),
                Text('Tigrou'),
              ]),
              const PostSeparator(),
              // Hébergement
              // TODO : A complété
              const Column(children: [
                LegalTitle(textContent: 'Hébergement du site :'),
                Text('[Nom de l\'hébergeur]'),
                Text('[Adresse de l\'hébergeur]'),
                Text(
                    'Téléphone de l\'hébergeur : [Numéro de téléphone de l\'hébergeur]'),
              ]),
              const PostSeparator(),
              // CGU
              const Column(children: [
                LegalTitle(
                    textContent: 'Conditions générales d\'utilisation :'),
                LegalTitle(
                  textContent: '1. Utilisation du site web',
                  textSize: 14,
                ),
                Text(
                    'En accédant à ce site web, vous acceptez de vous conformer à ces conditions d\'utilisation. Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser le site.'),
                LegalTitle(
                  textContent: '2. Propriété intellectuelle',
                  textSize: 14,
                ),
                Text(
                    'Tous les contenus de ce site, y compris les textes, les images, les vidéos, les logos et les marques, sont protégés par les lois sur la propriété intellectuelle. Vous ne pouvez pas reproduire, distribuer ou utiliser ces contenus sans autorisation écrite.'),
                LegalTitle(
                  textContent: '3. Politique de confidentialité',
                  textSize: 14,
                ),
                // TODO : lien vers la page politique de confidentialité
                Text(
                    'Veuillez consulter notre politique de confidentialité pour en savoir plus sur la manière dont nous collectons, utilisons et protégeons vos données personnelles.'),
              ]),
              const PostSeparator(),
              // Confidentialité
              const Column(children: [
                LegalTitle(textContent: 'Politique de confidentialité :'),
                Text(
                    'Pour en savoir plus sur notre politique de confidentialité, veuillez consulter notre page dédiée.'),
              ]),
              const PostSeparator(),
              // Cookie
              const Column(children: [
                LegalTitle(textContent: 'Cookies :'),
                Text(
                    'Ce site web n\'utilise pas de cookie. Pour en savoir plus sur l\'utilisation des cookies, veuillez consulter notre politique de cookies.'),
              ])
            ],
          ),
        )));
  }
}
