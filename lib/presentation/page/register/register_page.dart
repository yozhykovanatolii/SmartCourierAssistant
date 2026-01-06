import 'package:flutter/material.dart';
import 'package:smart_courier_assistant/presentation/page/register/widget/register_email_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/register/widget/register_full_name_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/register/widget/register_password_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/register/widget/register_phone_number_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/register/widget/sign_up_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                  'Create Account',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Fill information about yourself below',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 50),
                const RegisterFullNameTextField(),
                const SizedBox(height: 15),
                const RegisterEmailTextField(),
                const SizedBox(height: 15),
                const RegisterPasswordTextField(),
                const SizedBox(height: 15),
                const RegisterPhoneNumberTextField(),
                const SizedBox(height: 30),
                const SignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
