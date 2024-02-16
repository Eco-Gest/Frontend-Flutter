import 'package:ecogest_front/widgets/app_bar.dart';
import 'package:ecogest_front/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

class Error404View extends StatelessWidget {
  const Error404View({super.key});

  static String name = 'error-404';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ThemeAppBar(title: 'Page non trouvée'),
      bottomNavigationBar: const AppBarFooter(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Oups !',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset('assets/404.jpg'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('La page que vous recherchez semble introuvable.')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
