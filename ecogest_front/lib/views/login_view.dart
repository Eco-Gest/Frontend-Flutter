import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/views/register_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  static String name = 'login';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final bool _passwordVisible = false;

  // A function that validate user entered password
  bool validatePassword(String pass) {
    //regular expression to check if string
    RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    String passwordToTest = pass.trim();
    if (passValid.hasMatch(passwordToTest)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
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
                    child: const Column(children: [
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
                    ]),
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mot de passe',
                        hintText: 'Entrez votre mot de passe',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          (validatePassword(value!) && value.length >= 8)
                              ? null
                              : 'Mot de passe non valide',
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

                  BlocListener<AuthenticationCubit, AuthenticationState>(
                    // Error message if user is not allowed to connect
                    listener: (context, state) {
                      final status =
                          context.read<AuthenticationCubit>().state.status;

                      if (status == AuthenticationStatus.unauthenticated) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Echec de la connexion",
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (state is AuthenticationLoading) {
                        // Show only CircularProgressIndicator
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Stack(
                              children: [
                                // Background: Full-screen white background
                                Positioned.fill(
                                  child: Container(
                                    color: Colors
                                        .white, // Adjust the opacity as needed
                                  ),
                                ),
                                // Centered CircularProgressIndicator
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },

                    // Connect button
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(30),
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.all(20),
                            foregroundColor:
                                Colors.white, // Color of button text
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () {
                          context.read<AuthenticationCubit>().login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                        },
                        child: const Text('Se connecter'),
                      ),
                    ),
                  ),

                  // Link s'inscrire
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(40),
                    child: Column(children: [
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
                        )),
                        onPressed: () {
                          GoRouter.of(context).goNamed(RegisterView.name);
                        },
                        child: const Text(
                          'S\'inscrire',
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
