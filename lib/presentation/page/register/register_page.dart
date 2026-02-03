import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/util/ui_helper.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/register/register_state.dart';
import 'package:smart_courier_assistant/presentation/page/login/login_page.dart';
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
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.failure) {
            UiHelper.showSnackBar(
              context: context,
              message: state.errorMessage,
              isErrorSnackBar: true,
            );
          }
          if (state.formStatus == FormStatus.success) {
            UiHelper.showSnackBar(
              context: context,
              message: S.of(context).successRegistration,
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          }
        },
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).createAccount,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    S.of(context).fillInformationAboutYourselfBelow,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium,
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
      ),
    );
  }
}
