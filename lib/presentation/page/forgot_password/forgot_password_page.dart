import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/presentation/page/forgot_password/widget/forgot_password_email_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/forgot_password/widget/reset_password_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your email address and we will send you a link to reset your password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 50),
              const ForgotPasswordEmailTextField(),
              const SizedBox(height: 30),
              const ResetPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}
