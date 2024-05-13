import 'package:ecogest_front/views/auth/login_view.dart';
import 'package:ecogest_front/views/auth/register_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ecogest_front/state_management/authentication/authentication_cubit.dart';

class ResetPasswordView extends StatefulWidget {
  ResetPasswordView({super.key});

  static String name = 'reset-password';

  @override
  _ResetPasswordView createState() => _ResetPasswordView();
}

class _ResetPasswordView extends State<ResetPasswordView> {
  final TextEditingController emailController = TextEditingController();

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
                        'Mot de passe oublié',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Veuillez entrer l\'adresse email associée à votre compte pour modifier votre mot de passe.',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ]),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
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
                  BlocListener<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                      final status = context.read<AuthenticationCubit>().state;

                      if (status is AuthenticationResetPasswordStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Erreur lors de la modification du mot de passe. Veuillez réessayer.",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (status is AuthenticationResetPasswordStateSuccess) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    color: Colors
                                        .white,
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.topCenter,
                                        padding: const EdgeInsets.all(20),
                                        width: 300,
                                        child: Image.asset('assets/logo/logo-color.png'),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Un e-mail de réinitialisation de mot de passe a été envoyé à l'adresse fournie. Veuillez suivre les instructions pour réinitialiser votre mot de passe.",
                                              style: TextStyle(
                                                fontSize: 16
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              "Une fois terminé, vous pourrez vous reconnecter à l'application avec vos nouvelles informations d'identification.",
                                              style: TextStyle(
                                                fontSize: 16
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        "Vous avez réinitialisé votre mot de passe ?",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        width: 300,
                                        child: FilledButton(
                                          style: TextButton.styleFrom(
                                            minimumSize: const Size.fromHeight(50),
                                            padding: const EdgeInsets.all(20),
                                          ),
                                          onPressed: () {
                                            GoRouter.of(context).goNamed(LoginView.name);
                                          },
                                          child: const Text(
                                            style: TextStyle(fontSize: 18),
                                            'Se connecter',
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
                          padding: const EdgeInsets.all(20),
                        ),
                        onPressed: () {
                          context.read<AuthenticationCubit>().resetPassword(
                            email: emailController.text
                          );
                        },
                        child: const Text(
                            style: TextStyle(fontSize: 18), "Modifier le mot de passe"),
                      ),
                    ),
                  ),

                  // Link s'inscrire
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(40),
                    child: Column(children: [
                      const Text(
                        'Vous n\'avez pas encore de compte ?',
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
