import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/presentation/page/login/widget/forgot_password_text_button.dart';
import 'package:smart_courier_assistant/presentation/page/login/widget/login_email_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/login/widget/login_password_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/login/widget/not_have_account_section.dart';
import 'package:smart_courier_assistant/presentation/page/login/widget/sign_in_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Hi! Welcome back, you\'ve been missed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 50),
                const LoginEmailTextField(),
                const SizedBox(height: 15),
                const LoginPasswordTextField(),
                const SizedBox(height: 15),
                const ForgotPasswordTextButton(),
                const SizedBox(height: 30),
                const SignInButton(),
                const SizedBox(height: 20),
                const NotHaveAccountSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
