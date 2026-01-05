import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/util/ui_helper.dart';
import 'package:smart_courier_assistant/presentation/bloc/forgot_password/forgot_password_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/forgot_password/forgot_password_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';
import 'package:smart_courier_assistant/presentation/page/forgot_password/widget/forgot_password_email_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/forgot_password/widget/reset_password_button.dart';
import 'package:smart_courier_assistant/presentation/page/login/login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.success) {
            UiHelper.showSnackBar(
              context: context,
              message:
                  'If an account with this email exists, you will receive a password reset email.',
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          }
          if (state.formStatus == FormStatus.failure) {
            UiHelper.showSnackBar(
              context: context,
              message: state.errorMessage,
              isErrorSnackBar: true,
            );
          }
        },
        child: SafeArea(
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
      ),
    );
  }
}
