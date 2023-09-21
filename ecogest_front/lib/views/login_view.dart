import 'package:ecogest_front/views/register_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  static String name = 'login';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/logo/logo-color.png'),
            ),

            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Column(
                children: [
                  Text(
                    'Vous avez déjà un compte ?',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Heureux de vous revoir',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ]
              ),
            ),

            // Input email
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Entrez votre email',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => EmailValidator.validate(value!) ? null : 'Veuillez entrer un email valide',
              ),
            ),

            // Input password
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: passwordController,
                obscureText: !_passwordVisible,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mot de passe',
                  hintText: 'Entrez votre mot de passe',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value!.length < 8 ? 'Mot de passe non valide' : null,
              ),
            ),

            // Forgot password
            TextButton(
              onPressed: () {
                //TODO: redirect to forgot password screen
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Mot de passe oublié ?',
                ),
              ),
            ),

            // TODO: Error message if user is not allow to connect

            // Connect button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(30),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white, // Color of button text
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )
              ),
              onPressed: () {
                debugPrint('Email: ${emailController.text}');
                debugPrint('Password: ${passwordController.text}');
                // TODO: Auth user
              },
              child: const Text('Se connecter'),
            ),

            // Link s'inscrire
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  const Text(
                    'Vous souhaitez créer un compte ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    onPressed: () {
                      GoRouter.of(context).goNamed(RegisterView.name);
                    },
                    child: const Text(
                      'S\'inscrire',
                    ),
                  ),
                ]
              ),
            ),

          ],
        ),
      ),
    );
  }
}