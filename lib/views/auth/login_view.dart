import 'package:ecogest_front/views/auth/reset_password_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/views/auth/register_view.dart';
import 'package:ecogest_front/widgets/loading_widget.dart'; // Importez le widget de chargement

class LoginView extends StatefulWidget {
  LoginView({super.key});

  static String name = 'login';

  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool validatePassword(String pass) {
    RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    String passwordToTest = pass.trim();
    if (passValid.hasMatch(passwordToTest)) {
      return true;
    } else {
      return false;
    }
  }

  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState(); // N'oubliez pas d'appeler super.initState()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationUnauthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Identifiants incorrects",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          } 
        },
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationLoading || state is AuthenticationAuthenticated) {
              return LoadingWidget(); 
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.all(20),
                        width: 300,
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
                          ],
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
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : 'Veuillez entrer un email valide',
                        ),
                      ),
                      // Input password
                      Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mot de passe',
                            hintText: 'Entrez votre mot de passe',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => (validatePassword(value!) &&
                                  value.length >= 8)
                              ? null
                              : 'Le mot de passe doit ếtre long de 8 caractères \net doit contenir une lettre majuscule et minuscule \nun chiffre et un caractère spécial',
                        ),
                      ),
                      // Forgot password
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).goNamed(ResetPasswordView.name);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            style: TextStyle(fontSize: 18),
                            'Mot de passe oublié ?',
                          ),
                        ),
                      ),
                      // Connect button
                      SizedBox(
                        width: 300,
                        child: FilledButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            padding: const EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            context.read<AuthenticationCubit>().login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                          },
                          child: const Text(
                            style: TextStyle(fontSize: 18),
                            'Se connecter',
                          ),
                        ),
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
                                ),
                              ),
                              onPressed: () {
                                GoRouter.of(context).goNamed(RegisterView.name);
                              },
                              child: const Text(
                                'S\'inscrire',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
