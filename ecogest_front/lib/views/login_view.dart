import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

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
            Image.asset('assets/logo/logo-color.png'),

            // Form
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
                autovalidateMode: AutovalidateMode.always,
                validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
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
                autovalidateMode: AutovalidateMode.always,
                validator: (value) => value!.length < 8 ? 'Mot de passe non valide' : null,
              ),
            ),
            
              // Forgot password
              // TODO : Error message

              // Connect button

            // Link s'inscrire
          ],
        ),
      ),
    );
  }
}