import 'package:ecogest_front/state_management/user/user_cubit.dart';
import 'package:ecogest_front/views/users/account_view.dart';
import 'package:ecogest_front/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key});

  static String name = 'change-password';

  @override
  _ChangePasswordView createState() => _ChangePasswordView();
}

class _ChangePasswordView extends State<ChangePasswordView> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatedController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  late bool _passwordVisible;
  late bool _oldPasswordVisible;
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
    _oldPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Changer de mot de passe'),
      bottomNavigationBar: const AppBarFooter(),
      body: BlocProvider<UserCubit>(
        create: (_) => UserCubit(),
        child: Builder(
          builder: (context) {
            return BlocListener<UserCubit, UserState>(
              // Error message if user is not allow to connect
              listener: (context, state) {
                final status = context.read<UserCubit>().state;

                if (status is UserError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        status.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (status is UserSuccess) {
                  // Show only CircularProgressIndicator
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Changement de mot de passe réussi')),
                  );
                  GoRouter.of(context).goNamed(AccountView.name);
                }
              },
              // register button

              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Input password
                    Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: oldPasswordController,
                        obscureText: !_oldPasswordVisible,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Mot de passe actuel',
                          hintText: 'Entrez votre mot de passe actuel',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _oldPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _oldPasswordVisible = !_oldPasswordVisible;
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
                        controller: passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Nouveau mot de passe',
                          hintText: 'Entrez votre nouveau mot de passe',
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
                          labelText: 'Répètez votre nouveau mot de passe',
                          hintText: 'Répètez votre nouveau mot de passe',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => validatePasswordRepeated(
                                value, passwordController.text)
                            ? null
                            : 'Les mots de passe doivent être identiques',
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: FilledButton(
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          padding: const EdgeInsets.all(15),
                        ),
                        onPressed: () {
                          context.read<UserCubit>().changePassword(
                                oldPassword: oldPasswordController.text,
                                password: passwordController.text,
                                passwordRepeated:
                                    passwordRepeatedController.text,
                              );
                        },
                        child: const Text(
                            "Changer de mot de passe"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
