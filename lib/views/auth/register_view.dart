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
  _RegisterView createState() => _RegisterView();
}

class _RegisterView extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatedController =
      TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode passwordRepeatedFocusNode = FocusNode();
  String? emailError;
  String? usernameError;
  String? passwordError;
  String? passwordRepeatedError;

  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;

    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        if (!EmailValidator.validate(emailController.text)) {
          setState(() {
            emailError = 'Veuillez entrer un email valide';
          });
        } else {
          setState(() {
            emailError = null;
          });
        }
      }
    });

    usernameFocusNode.addListener(() {
      if (!usernameFocusNode.hasFocus) {
        if (!valideUsername(usernameController.text)) {
          setState(() {
            usernameError =
                'Le nom d\'utilisateur doit être de 5 caractères minimum';
          });
        } else {
          setState(() {
            usernameError = null;
          });
        }
      }
    });

    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        if (!validatePassword(passwordController.text)) {
          setState(() {
            passwordError =
                'Le mot de passe doit ếtre long de 8 caractères \net doit contenir une lettre majuscule et minuscule \nun chiffre et un caractère spécial';
          });
        } else {
          setState(() {
            passwordError = null;
          });
        }
      }
    });

    passwordRepeatedFocusNode.addListener(() {
      if (!passwordRepeatedFocusNode.hasFocus) {
        if (!validatePasswordRepeated(
            passwordController.text, passwordRepeatedController.text)) {
          setState(() {
            passwordRepeatedError = 'Les mots de passe doivent être identiques';
          });
        } else {
          setState(() {
            passwordRepeatedError = null;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordRepeatedController.dispose();
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordRepeatedFocusNode.dispose();
    super.dispose();
  }

  bool validatePassword(String pass) {
    RegExp passValid =
        RegExp(r"(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    return passValid.hasMatch(pass.trim());
  }

  bool valideUsername(String username) {
    RegExp usernameValid = RegExp(r"^[A-Za-z0-9_]{5,29}$");
    return usernameValid.hasMatch(username.trim());
  }

  bool validatePasswordRepeated(String? pass, String? passRepeated) {
    return pass == passRepeated;
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
                    // Input email
                    Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Entrez votre email',
                          errorText: emailError,
                        ),
                      ),
                    ),
                    // Input username
                    Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: usernameController,
                        focusNode: usernameFocusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nom d\'utilisateur',
                          hintText: 'Entrez votre nom d\'utilisateur',
                          errorText: usernameError,
                        ),
                      ),
                    ),
                    // Input password
                    Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: passwordController,
                        focusNode: passwordFocusNode, // Ajoutez le FocusNode
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mot de passe',
                          hintText: 'Entrez votre mot de passe',
                          errorText: passwordError,
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
                      ),
                    ),
                    // Input password repeated
                    Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: passwordRepeatedController,
                        focusNode:
                            passwordRepeatedFocusNode, // Ajoutez le FocusNode
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Répétez votre mot de passe',
                          hintText: 'Répétez votre mot de passe',
                          errorText: passwordRepeatedError,
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
                      ),
                    ),
                    BlocListener<AuthenticationCubit, AuthenticationState>(
                      listener: (context, state) {
                        final status =
                            context.read<AuthenticationCubit>().state;

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
                                  Positioned.fill(
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: SizedBox(
                        width: 300,
                        child: FilledButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            padding: const EdgeInsets.all(15),
                          ),
                          onPressed: () {
                            context.read<AuthenticationCubit>().register(
                                  email: emailController.text,
                                  username: usernameController.text,
                                  password: passwordController.text,
                                );
                          },
                          child: const Text("S'inscrire"),
                        ),
                      ),
                    ),
                    // Link to login
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          const Text(
                            'Vous avez déjà un compte ?',
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
                              GoRouter.of(context).goNamed(LoginView.name);
                            },
                            child: const Text(
                              'Se connecter',
                            ),
                          ),
                        ],
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
  }
}
