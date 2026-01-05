import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/presentation/page/login/login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: const Color(0xFF007DFC),
      animationDuration: const Duration(milliseconds: 3000),
      childWidget: const Text(
        'Smart Courier Assistant',
        style: TextStyle(
          fontFamily: 'Pacifico',
          color: Colors.white,
          fontSize: 35,
          fontWeight: FontWeight.w600,
        ),
      ),
      onEnd: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      },
    );
  }
}
