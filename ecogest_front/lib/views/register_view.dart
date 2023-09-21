import 'package:ecogest_front/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  static String name = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )
          ),
          onPressed: () {
            GoRouter.of(context).goNamed(LoginView.name);
          },
          child: const Text(
            'Hello World from register! Click to redirect to login',
          ),
        ),
      ),
    );
  }
}