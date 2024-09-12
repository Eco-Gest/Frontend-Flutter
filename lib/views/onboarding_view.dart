import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class OnboardingView extends StatelessWidget {
  static String name = 'onboarding';

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600), // Style for the title
      bodyTextStyle: TextStyle(fontSize: 16.0), // Style for the body text
      imagePadding: EdgeInsets.fromLTRB(16.0, 144.0, 16.0, 0.0), // Padding around the image
      imageAlignment: Alignment.bottomCenter, // Centering the image
      bodyAlignment: Alignment.center, // Centering the body content
      contentMargin: EdgeInsets.symmetric(horizontal: 24.0),
      bodyFlex: 2, // Space ratio for the body
      imageFlex: 4, // Space ratio for the image
    );

    return IntroductionScreen(
      globalHeader: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: _buildImage('logo/logo-color.png', 200),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Agis",
          body: "Avec Eco'Gest, adopte des actions simples et concrètes pour préserver la planète au quotidien.",
          image: _buildImage('onboarding/onboarding_act.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Partage",
          body: "Montre tes éco-gestes et inspire la communauté à faire de même.",
          image: _buildImage('onboarding/onboarding_share.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Encourage",
          body: "Crée des défis écoresponsables ou relève ceux de tes amis pour motiver la communauté.",
          image: _buildImage('onboarding/onboarding_cheer.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('onboardingSeen', true);
        GoRouter.of(context).go('/login');
      },
      next: const Icon(Icons.arrow_forward),
      done: const Text("Commencer", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
