import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_courier_assistant/core/navigation/app_routes.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((AppBloc appBloc) => appBloc.state);
    return FlutterSplashScreen.fadeIn(
      backgroundColor: const Color(0xFF007DFC),
      animationDuration: const Duration(milliseconds: 3000),
      childWidget: const Text(
        'Smart Courier Assistant',
        style: TextStyle(
          fontFamily: 'Pacifico',
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
      onEnd: () {
        if (state is UserAuthenticatedState) {
          context.go(AppRoutes.homePage);
        }
        if (state is UserUnauthenticatedState) {
          context.go(AppRoutes.loginPage);
        }
      },
    );
  }
}
