import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';
import 'package:ecogest_front/views/auth/login_view.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  static String name = 'register';

  @override
  _RegisterView createState() =>
      _RegisterView();
}

class _RegisterView extends State<RegisterView> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatedController =
      TextEditingController();

  late bool _passwordVisible;

  // A function that validate user entered password
  bool validatePassword(String pass) {
    //regular expression to check if string
    RegExp passValid =
        RegExp(r"(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    String passwordToTest = pass.trim();
    if (passValid.hasMatch(passwordToTest)) {
      return true;
    } else {
      return false;
    }
  }

  bool valideUsername(String username) {
    //regular expression to check if string
    RegExp usernameValid = RegExp(r"^[A-Za-z0-9_]{5,29}$");
    String usernameToTest = username.trim();
    if (usernameValid.hasMatch(usernameToTest)) {
      return true;
    } else {
      return false;
    }
  }

  bool validatePasswordRepeated(String? pass, String? passRepeated) {
    if (pass != passRepeated) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.only(top: 40),
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
                            'Inscription',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]),
                      ),
                      // Input username
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
                      // Input email
                      Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nom d\'utilisateur',
                            hintText: 'Entrez votre nom d\'utilisateur',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => valideUsername(value!)
                              ? null
                              : 'Veuillez entrer un nom d\'utilisateur de 5 caractères minimum',
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

                      // Input password
                      Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: passwordRepeatedController,
                          obscureText: !_passwordVisible,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Répètez votre mot de passe',
                            hintText: 'Répètez votre mot de passe',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => validatePasswordRepeated(
                                  value, passwordController.text)
                              ? null
                              : 'Les mots de passe doivent être identiques',
                        ),
                      ),

                      BlocListener<AuthenticationCubit, AuthenticationState>(
                        // Error message if user is not allow to connect
                        listener: (context, state) {
                          final status = context.read<AuthenticationCubit>().state;

                          if (status is AuthenticationUnauthenticated) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  status.message,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (status is AuthenticationAuthenticated) {
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
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        // register button
                        child: SizedBox(
                          width: 300,
                          child: FilledButton(
                            style: TextButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              padding: const EdgeInsets.all(20),
                            ),
                            onPressed: () {
                              context.read<AuthenticationCubit>().register(
                                    email: emailController.text,
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  );
                            },
                            child: const Text(
                                style: TextStyle(fontSize: 18), "S'inscrire"),
                          ),
                        ),
                      ),

                      // Link s'inscrire
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(40),
                        child: Column(children: [
                          const Text(
                            'Vous avez déjà compte ?',
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
                              GoRouter.of(context).goNamed(LoginView.name);
                            },
                            child: const Text(
                              'Se connecter',
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
      ),
    );
  }
}
